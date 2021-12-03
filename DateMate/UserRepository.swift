//
//  UserRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/01.
//

import Foundation
import FirebaseAuth

class UserRepository {
    let auth = Auth.auth()
    
    func signIn(email: String, password: String, result: @escaping (SignInStatus) -> Void) {
        result(SignInStatus.Loading)
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            if authDataResult != nil {
                print("LoginSuccess")
                result(SignInStatus.Success)
            } else if error != nil {
                result(SignInStatus.Failure)
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authDataResult, error in
            guard authDataResult != nil, error == nil else {
                return
            }
        }
    }
}

enum SignInStatus {
    case Success
    case Loading
    case Failure
}
