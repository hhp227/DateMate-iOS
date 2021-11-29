//
//  LoginView.swift
//  DateMate
//
//  Created by 홍희표 on 2021/11/27.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    @State var email = ""
    
    @State var password = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Email", text: $email).disableAutocorrection(true).autocapitalization(.none).padding().background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password).disableAutocorrection(true).autocapitalization(.none).padding().background(Color(.secondarySystemBackground))
                Button(action: {
                    viewModel.login(email: email, password: password)
                }, label: {
                    Text("Login").foregroundColor(Color.white).frame(width: 200, height: 50).cornerRadius(8).background(Color.blue)
                })
                NavigationLink("Register", destination: SignUpView())
            }.padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().preferredColorScheme(.dark)
    }
}
