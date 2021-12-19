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
        ZStack {
            content
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: WriteView()) {
                        Text("+").font(.system(.largeTitle)).frame(width: 66, height: 60).foregroundColor(.white).padding(.bottom, 7)
                    }.background(Color.blue).cornerRadius(38.5).padding().shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3).animation(.none)
                }
            }
        }
    }
    
    var content: some View {
        ZStack {
            List {
                ForEach(viewModel.state.posts) { post in
                    PostCell(post: post)
                }
            }
            if viewModel.state.isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle.init())
            } else if !viewModel.state.error.isEmpty {
                Text(viewModel.state.error).frame(alignment: Alignment.center).padding()
            }
        }
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
