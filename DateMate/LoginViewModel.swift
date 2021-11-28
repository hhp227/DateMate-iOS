//
//  LoginViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/11/28.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var loggedIn = false
    
    let auth = Auth.auth()
    
    var isLoggedIn: Bool {
        return auth.currentUser != nil
    }
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.loggedIn = true
            }
        }
    }
    
    func logout() {
        self.loggedIn = false
        
        try? auth.signOut()
    }
}
