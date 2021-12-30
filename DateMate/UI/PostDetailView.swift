//
//  PostDetailView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/12.
//

import SwiftUI

struct PostDetailView: View {
    @EnvironmentObject var viewModel: PostDetailViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                if let post = viewModel.state.post {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.fill").frame(width: 40, height: 40, alignment: .center)
                            Text(post.author)
                        }
                        VStack(alignment: .leading) {
                            Text(post.title).lineLimit(1)
                            Text(post.body)
                        }
                    }
                }
                ForEach(Array(viewModel.state.comments.enumerated()), id: \.offset) { i, comment in
                    CommentCell(comment: comment)
                }
            }
            VStack(spacing: 0) {
                Divider()
                HStack(spacing: 5) {
                    TextField("Add a Comment", text: $viewModel.message).padding(10)
                    Button(action: viewModel.addComment) {
                        Text("Send").padding(10).foregroundColor(viewModel.message.isEmpty ? .gray : .red).overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.5), lineWidth: 1))
                    }
                }.padding(5)
            }
        }
    }
}

struct CommentCell: View {
    var comment: Comment
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill").frame(width: 32, height: 32, alignment: .center)
            VStack(alignment: .leading) {
                Text(comment.author)
                Text(comment.text)
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}
