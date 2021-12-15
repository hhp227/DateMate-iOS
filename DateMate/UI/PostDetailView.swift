//
//  PostDetailView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/12.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var viewModel = PostDetailViewModel(.init())
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}
