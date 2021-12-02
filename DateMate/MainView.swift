//
//  MainView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/03.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    var body: some View {
        VStack {
            Text("You are Logged In")
            Button(action: signInViewModel.signOut, label: {
                Text("Logout").frame(width: 200, height: 50).background(Color.green).foregroundColor(Color.blue).padding()
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
