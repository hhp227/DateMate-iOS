//
//  RegisterViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/11/28.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    @Published var loggedIn = false
    
    let auth = Auth.auth()
    
    func register(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.loggedIn = true
            }
        }
    }
}
