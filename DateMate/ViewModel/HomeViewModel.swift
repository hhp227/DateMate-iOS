//
//  HomeViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/07.
//

import Foundation
import FirebaseAuth

class HomeViewModel: ObservableObject {
    func test() {
        print("HomeViewModel test")
        try? Auth.auth().signOut()
    }
}
