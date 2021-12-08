//
//  HomeView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/04.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        Text("Home").onTapGesture {
            viewModel.test()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
