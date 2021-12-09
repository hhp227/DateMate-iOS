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
        Text("Lounge").onTapGesture {
            viewModel.test()
            print("temp: \(viewModel.test2())")
        }
    }
}

struct LoungeView_Previews: PreviewProvider {
    static var previews: some View {
        LoungeView()
    }
}
