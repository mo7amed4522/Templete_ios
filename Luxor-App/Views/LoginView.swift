import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @EnvironmentObject var languageManager: LanguageManager
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var authState: AuthState
    @EnvironmentObject var diContainer: DIContainer
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    init() {
        let container = DIContainer.shared
        self._viewModel = StateObject(wrappedValue: container.makeLoginViewModel())
        self.authState = container.authState
    }
    
    private var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack(spacing: 24) {
                    LuxorLogoView(size: isIPad ? 140 : 100)
                    
                    VStack(spacing: 8) {
                        Text(LocalizedStrings.welcomeBack(languageManager.currentLanguage))
                            .font(.system(size: isIPad ? 32 : 28, weight: .bold))
                            .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textPrimary : LuxorColors.Light.textPrimary)
                        
                        Text(LocalizedStrings.signIn(languageManager.currentLanguage))
                            .font(.system(size: isIPad ? 18 : 16, weight: .medium))
                            .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary)
                    }
                }
                .padding(.top, 60)
                .padding(.bottom, 32)
                .background(
                    (themeManager.isDarkMode ? LuxorColors.Dark.background : LuxorColors.Light.background)
                        .ignoresSafeArea(.all, edges: .top)
                )
                
                ScrollView {
                    VStack(spacing: 24) {
                        loginForm
                            .padding(.horizontal, isIPad ? 60 : 24)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 20)
                }
            }
        }
        .luxorThemedBackground(themeManager)
        .ignoresSafeArea(.all, edges: .bottom)
        .toast(
            isShowing: $authState.showToast,
            message: authState.toastMessage,
            type: authState.toastType
        )
    }
    
    @ViewBuilder
    private var loginForm: some View {
        VStack(spacing: 24) {
            LuxorEmailTextField(email: $viewModel.email)
                .environmentObject(themeManager)
            LuxorPasswordTextField(password: $viewModel.password)
                .environmentObject(themeManager)
            HStack {
                Spacer()
                Button(action: {
                    viewModel.forgotPassword()
                }) {
                    Text(LocalizedStrings.forgotPassword(languageManager.currentLanguage))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(LuxorColors.luxorTeal)
                }
            }
            .padding(.top, -8)
            Button(action: {
                viewModel.login()
            }) {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.8)
                    } else {
                        Text(LocalizedStrings.signIn(languageManager.currentLanguage))
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                colors: viewModel.isFormValid ? 
                                    [LuxorColors.luxorTeal, LuxorColors.luxorGold] :
                                    [Color.gray.opacity(0.5), Color.gray.opacity(0.3)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
                .disabled(!viewModel.isFormValid || viewModel.isLoading)
                .scaleEffect(viewModel.isLoading ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: viewModel.isLoading)
            }
            HStack {
                Rectangle()
                    .fill(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary.opacity(0.3) : LuxorColors.Light.textSecondary.opacity(0.3))
                    .frame(height: 1)
                
                Text(LocalizedStrings.or(languageManager.currentLanguage))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary)
                    .padding(.horizontal, 16)
                
                Rectangle()
                    .fill(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary.opacity(0.3) : LuxorColors.Light.textSecondary.opacity(0.3))
                    .frame(height: 1)
            }
            .padding(.vertical, 8)
            SocialLoginButtons()
                .environmentObject(themeManager)
            VStack(spacing: 16) {
                Rectangle()
                    .fill(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary.opacity(0.2) : LuxorColors.Light.textSecondary.opacity(0.2))
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                Button(action: {
                    viewModel.createAccount()
                }) {
                    HStack {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 16, weight: .medium))
                        
                        Text(LocalizedStrings.createNewAccount(languageManager.currentLanguage))
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textPrimary : LuxorColors.Light.textPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                LinearGradient(
                                    colors: [LuxorColors.luxorTeal, LuxorColors.luxorGold],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        themeManager.isDarkMode ? 
                                        LuxorColors.Dark.cardBackground.opacity(0.5) :
                                        LuxorColors.Light.cardBackground.opacity(0.8)
                                    )
                            )
                    )
                }
                VStack(spacing: 4) {
                    Text(LocalizedStrings.byCreatingAccountAgree(languageManager.currentLanguage))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary)
                    
                    HStack(spacing: 4) {
                        Button(action: {
                            viewModel.showTerms()
                        }) {
                            Text(LocalizedStrings.termsOfService(languageManager.currentLanguage))
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(LuxorColors.luxorTeal)
                                .underline()
                        }
                        Text(LocalizedStrings.and(languageManager.currentLanguage))
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(themeManager.isDarkMode ? LuxorColors.Dark.textSecondary : LuxorColors.Light.textSecondary)
                        
                        Button(action: {
                            viewModel.showPrivacyPolicy()
                        }) {
                            Text(LocalizedStrings.privacyPolicy(languageManager.currentLanguage))
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(LuxorColors.luxorTeal)
                                .underline()
                        }
                    }
                }
                .padding(.top, 8)
            }
            .padding(.top, 16)
        }
        .frame(maxWidth: isIPad ? 500 : .infinity)
    }
}

#Preview {
    LoginView()
        .environmentObject(ThemeManager())
        .environmentObject(AuthState())
        .environmentObject(DIContainer.shared)
        .environmentObject(LanguageManager())
}
