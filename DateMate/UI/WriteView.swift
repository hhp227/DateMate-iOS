//
//  WriteView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/13.
//

import SwiftUI

struct WriteView: View {
    @ObservedObject var viewModel = WriteViewModel(.init())
    
    var body: some View {
        List {
            ZStack {
                TextEditor(text: $viewModel.title).autocapitalization(.none).keyboardType(.default).disableAutocorrection(true)
            }.listRowInsets(EdgeInsets()).shadow(radius: 1)
            ZStack {
                TextEditor(text: $viewModel.content).autocapitalization(.none).keyboardType(.default).disableAutocorrection(true)
                Text(viewModel.content).opacity(0).padding(.all, 8)
            }.listRowInsets(EdgeInsets()).shadow(radius: 1)
        }.navigationBarTitleDisplayMode(.inline).navigationBarItems(trailing: Button(action: viewModel.actionSend) { Text("Send") })
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView()
    }
}
