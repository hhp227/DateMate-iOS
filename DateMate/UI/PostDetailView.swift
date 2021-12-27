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
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}
