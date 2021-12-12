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
            List {
                ForEach(viewModel.posts) { post in
                    PostCell(post: post)
                }
            }
            
        }.onAppear(perform: viewModel.getPosts)
    }
}

struct PostCell: View {
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill").frame(width: 40, height: 40, alignment: .center)
                Text(post.author)
            }
            VStack(alignment: .leading) {
                Text(post.title).lineLimit(1)
                Text(post.body)
            }
            NavigationLink(destination: PostDetailView()) {
                EmptyView()
            }.hidden()
        }
    }
}

struct LoungeView_Previews: PreviewProvider {
    static var previews: some View {
        LoungeView()
    }
}
