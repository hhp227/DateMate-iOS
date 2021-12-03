//
//  ContentView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/11/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = SignInViewModel(.init())
    
    var body: some View {
        if viewModel.signInResult.success {
            MainView().environmentObject(viewModel)
        } else {
            SignInView().environmentObject(viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
