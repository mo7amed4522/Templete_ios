//
//  Localization.swift
//  Luxor-App
//
//  Created by Standard User on 04/09/2025.
//


import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    @Published var currentLanguage: SupportedLanguage = .english {
        didSet {
            UserDefaults.standard.set(
                currentLanguage.rawValue,
                forKey: "selectedLanguage"
            )
        }
    }

    init() {
        if let savedLanguage = UserDefaults.standard.string(
            forKey: "selectedLanguage"
        ),
            let language = SupportedLanguage(rawValue: savedLanguage)
        {
            self.currentLanguage = language
        } else {
            let systemLanguage =
                Locale.current.language.languageCode?.identifier ?? "en"
            switch systemLanguage {
            case "ar":
                self.currentLanguage = .arabic
            case "fr":
                self.currentLanguage = .french
            case "zh":
                self.currentLanguage = .chinese
            default:
                self.currentLanguage = .english
            }
        }
    }

    func changeLanguage(to language: SupportedLanguage) {
        currentLanguage = language
    }
}

enum SupportedLanguage: String, CaseIterable {
    case english = "en"
    case arabic = "ar"
    case french = "fr"
    case chinese = "zh"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .arabic: return "العربية"
        case .french: return "Français"
        case .chinese: return "中文"
        }
    }

    var flag: String {
        switch self {
        case .english: return "🇺🇸"
        case .arabic: return "🇦🇪"
        case .french: return "🇫🇷"
        case .chinese: return "🇨🇳"
        }
    }

    var isRTL: Bool {
        return self == .arabic
    }
}

struct LocalizedStrings {
    
    static func authenticating(_ language: SupportedLanguage) -> String {
            switch language {
            case .english: return "Authenticating..."
            case .arabic: return "جارٍ التحقق..."
            case .french: return "Authentification..."
            case .chinese: return "正在验证..."
            }
        }
    static func pleaseFillInAllFieldsCorrectly(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Please fill in all fields correctly"
        case .arabic: return "يرجى تعبئة جميع الحقول بشكل صحيح"
        case .french: return "Veuillez remplir tous les champs correctement"
        case .chinese: return "请正确填写所有字段"
        }
    }
    static func invalidEmailOrPassword(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Invalid email or password"
        case .arabic: return "بريد إلكتروني أو كلمة مرور غير صالحة"
        case .french: return "Email ou mot de passe invalide"
        case .chinese: return "邮箱或密码无效"
        }
    }
    static func networkConnectionError(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Network connection error"
        case .arabic: return "خطأ في اتصال الشبكة"
        case .french: return "Erreur de connexion réseau"
        case .chinese: return "网络连接错误"
        }
    }
    static func dataProcessingError(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Data processing error"
        case .arabic: return "خطأ في معالجة البيانات"
        case .french: return "Erreur de traitement des données"
        case .chinese: return "数据处理错误"
        }
    }
    static func unknownErrorOccurred(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "An unknown error occurred"
        case .arabic: return "حدث خطأ غير معروف"
        case .french: return "Une erreur inconnue est survenue"
        case .chinese: return "发生未知错误"
        }
    }
    static func welcomeBack(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Welcome Back"
        case .arabic: return "مرحبًا بعودتك"
        case .french: return "Bienvenue de retour"
        case .chinese: return "欢迎回来"
        }
    }
    
    static func signInToYourAccount(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Sign in to your account"
        case .arabic: return "سجّل الدخول إلى حسابك"
        case .french: return "Connectez-vous à votre compte"
        case .chinese: return "登录您的账户"
        }
    }
    
    static func forgotPassword(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Forgot Password?"
        case .arabic: return "نسيت كلمة المرور؟"
        case .french: return "Mot de passe oublié ?"
        case .chinese: return "忘记密码？"
        }
    }
    
    static func signIn(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Sign In"
        case .arabic: return "تسجيل الدخول"
        case .french: return "Se connecter"
        case .chinese: return "登录"
        }
    }
    
    static func or(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "OR"
        case .arabic: return "أو"
        case .french: return "OU"
        case .chinese: return "或"
        }
    }
    
    static func createNewAccount(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Create New Account"
        case .arabic: return "إنشاء حساب جديد"
        case .french: return "Créer un nouveau compte"
        case .chinese: return "创建新账户"
        }
    }
    
    static func byCreatingAccountAgree(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "By creating an account, you agree to our"
        case .arabic: return "بالتسجيل، فإنك توافق على"
        case .french: return "En créant un compte, vous acceptez nos"
        case .chinese: return "创建账户即表示您同意我们的"
        }
    }
    
    static func termsOfService(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Terms of Service"
        case .arabic: return "شروط الخدمة"
        case .french: return "Conditions d'utilisation"
        case .chinese: return "服务条款"
        }
    }
    
    static func and(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "and"
        case .arabic: return "و"
        case .french: return "et"
        case .chinese: return "和"
        }
    }
    
    static func privacyPolicy(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Privacy Policy"
        case .arabic: return "سياسة الخصوصية"
        case .french: return "Politique de confidentialité"
        case .chinese: return "隐私政策"
        }
    }
    static func emailAddress(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Email Address"
        case .arabic: return "عنوان البريد الإلكتروني"
        case .french: return "Adresse e-mail"
        case .chinese: return "邮箱地址"
        }
    }
    static func pleaseEnterValidEmail(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Please enter a valid email address"
        case .arabic: return "يرجى إدخال عنوان بريد إلكتروني صالح"
        case .french: return "Veuillez entrer une adresse e-mail valide"
        case .chinese: return "请输入有效的邮箱地址"
        }
    }
    static func password(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "Password"
        case .arabic: return "كلمة المرور"
        case .french: return "Mot de passe"
        case .chinese: return "密码"
        }
    }
    static func orContinueWith(_ language: SupportedLanguage) -> String {
        switch language {
        case .english: return "or continue with"
        case .arabic: return "أو متابعة باستخدام"
        case .french: return "ou continuer avec"
        case .chinese: return "或使用以下方式继续"
        }
    }

}
extension View {
    func localizedEnvironment(_ languageManager: LanguageManager) -> some View {
        self.environment(
            \.layoutDirection,
            languageManager.currentLanguage.isRTL ? .rightToLeft : .leftToRight
        )
    }
}
extension String {
    func localized(_ language: SupportedLanguage) -> String {
        return self
    }
}
