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
        NavigationView {
            TabView {
                HomeView().tabItem {
                    Image(systemName: "heart.fill")
                    Text("Home")
                }
                LoungeView().tabItem {
                    Image(systemName: "text.bubble")
                    Text("Lounge")
                }
            }.navigationTitle("Datemate").navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
