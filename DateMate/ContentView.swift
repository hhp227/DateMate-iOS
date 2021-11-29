//
//  ContentView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/11/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.loggedIn {
                VStack {
                    Text("You are Logged In")
                    Button(action: viewModel.logout, label: {
                        Text("Logout").frame(width: 200, height: 50).background(Color.green).foregroundColor(Color.blue).padding()
                    })
                }
            } else {
                SignInView().environmentObject(viewModel)
            }
        }.onAppear(perform: {
            viewModel.loggedIn = viewModel.isLoggedIn
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
