//
//  LoginViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/11/28.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var signInResult: SignInResult
    
    private let repository: UserRepository
    
    init(_ repository: UserRepository) {
        self.repository = repository
        self.signInResult = SignInResult(repository.getCurrentUser() != nil)
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return email.contains("@") ? NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email) : !email.isEmpty
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        return password.count > 3
        }
    
    func signIn(email: String, password: String) {
        guard isEmailValid(email), isPasswordValid(password) else {
            return
        }
        repository.signIn(email: email, password: password) {
            switch $0 {
            case .Success:
                self.signInResult = SignInResult(true)
            case .Failure:
                self.signInResult = SignInResult(false)
            case .Loading:
                print("loading중입니다.")
            }
        }
    }
    
    func signOut() {
        
    }
    
    struct SignInResult {
        let success: Bool
        
        init(_ success: Bool = false) {
            self.success = success
        }
    }
}
