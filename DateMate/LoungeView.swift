//
//  LoungeView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/04.
//

import SwiftUI

struct LoungeView: View {
    @ObservedObject var viewModel = LoungeViewModel(.init())
    
    var body: some View {
        VStack {
            ForEach(viewModel.posts) { post in
                PostCell(post: post)
            }
        }.onAppear(perform: viewModel.getPosts)
    }
}

struct PostCell: View {
    var post: Post
    
    var body: some View {
        Text(post.title)
    }
}

struct LoungeView_Previews: PreviewProvider {
    static var previews: some View {
        LoungeView()
    }
}
