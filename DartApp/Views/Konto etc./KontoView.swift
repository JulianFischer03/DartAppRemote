//
//  KontoView.swift
//  DartApp
//
//  Created by Julian Fischer on 26.05.23.
//

import SwiftUI
import Firebase

struct KontoView: View {
    
    @State private var email = ""
    @State private var passwort = ""
    @EnvironmentObject private var dataManager: DataManager
    
    var body: some View {
        
        if dataManager.userIstEingeloggt {
           contentEingeloggt
        }else {
            content
        }
        
    }
    
    var contentEingeloggt: some View {
        NavigationView {
            VStack {
                Text("Geworfene Darts: \(dataManager.stats.darts)")
                Text("Geworfene 180s: \(dataManager.stats.hundertAchtziger)")
                Text("Deine Doppel Quote: \(dataManager.stats.avgDoppelQuote)")
                
                Button{
                    dataManager.logout()
                }label: {
                    Text("Abmelden")
                        .padding(.top)
                }
                
            }
        }
    }
    
    var content: some View {
        
        ZStack{
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect (.degrees (135))
                .offset (y: -350)
            
            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset (x: -100, y: -100)
                
                
                TextField("Email: ", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Passwort: ", text: $passwort)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: passwort.isEmpty) {
                        Text("Passwort")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button{
                    register()
                } label: {
                    Text("Registrieren")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:100)
                
                Button{
                    login()
                } label: {
                    Text("Hast du bereits einen Account? Einloggen")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 110)
                
                
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        dataManager.userIstEingeloggt.toggle()
                        print(dataManager.userIstEingeloggt)
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: passwort) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                dataManager.userIstEingeloggt = true
            }
            
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: passwort) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
            } else{
                dataManager.userIstEingeloggt = true
            }
            
        }
    }
}

struct KontoView_Previews: PreviewProvider {
    static var previews: some View {
        KontoView()
        .environmentObject(DataManager())
    }
        
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
