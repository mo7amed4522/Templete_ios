import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage = ""
    @EnvironmentObject var languageManager: LanguageManager
    
    private let authUseCase: AuthUseCase
    private let authState: AuthState
    private var cancellables = Set<AnyCancellable>()
    
    init(authUseCase: AuthUseCase, authState: AuthState) {
        self.authUseCase = authUseCase
        self.authState = authState
    }
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && isValidEmail(email) && isValidPassword(password)
    }
    
    func login() {
        guard isFormValid else {
            showError(LocalizedStrings.pleaseFillInAllFieldsCorrectly(languageManager.currentLanguage))
            return
        }
        
        isLoading = true
        authState.setLoading(true)
        
        authUseCase.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isLoading = false
                self?.authState.setLoading(false)
                
                switch result {
                case .success(let authResponse):
                    self?.authState.login(user: authResponse.user, authResponse: authResponse)
                    self?.authState.showSuccessToast("Login successful!")
                case .failure(let error):
                    let errorMessage = self?.getErrorMessage(from: error) ?? "Login failed"
                    self?.showError(errorMessage)
                    self?.authState.showErrorToast(errorMessage)
                }
            }
            .store(in: &cancellables)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let hasCapital = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasMinLength = password.count >= 8
        let hasSpecial = password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil
        return hasCapital && hasMinLength && hasSpecial
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showError = true
    }
    
    private func getErrorMessage(from error: Error) -> String {
        if let authError = error as? AuthError {
            switch authError {
            case .invalidCredentials:
                return LocalizedStrings.invalidEmailOrPassword(languageManager.currentLanguage)
            case .networkError:
                return LocalizedStrings.networkConnectionError(languageManager.currentLanguage)
            case .serverError(let message):
                return message
            case .decodingError:
                return LocalizedStrings.dataProcessingError(languageManager.currentLanguage)
            case .unknownError:
                return LocalizedStrings.unknownErrorOccurred(languageManager.currentLanguage)
            }
        }
        return error.localizedDescription
    }
    func forgotPassword() {
        // Handle forgot password action
        print("Forgot password tapped for email: \(email)")
        // TODO: Navigate to forgot password screen or show alert
    }
    func createAccount() {
        // Handle create account action
        print("Create account tapped")
        // TODO: Navigate to registration screen
    }
    func showTerms() {
        // Handle terms of service action
        print("Terms of service tapped")
        // TODO: Show terms of service
    }
    func showPrivacyPolicy() {
        // Handle privacy policy action
        print("Privacy policy tapped")
        // TODO: Show privacy policy
    }
}
