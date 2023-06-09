//
//  EingeloggtView.swift
//  DartApp
//
//  Created by Julian Fischer on 08.06.23.
//

import SwiftUI
import FirebaseAuth

struct EingeloggtView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Geworfene Darts: \(dataManager.stats.darts)")
                Text("Geworfene 180s: \(dataManager.stats.hundertAchtziger)")
                Text("Deine Doppel Quote: \(dataManager.stats.doppelQuote)")
                
                Button{
                    logout()
                }label: {
                    Text("Abmelden")
                        .padding(.top)
                }
                .environmentObject(DataManager())
            }
        }
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
            
            // Wechseln zur KontoView
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = UIHostingController(rootView: KontoView())
                window.makeKeyAndVisible()
            }
        } catch {
            print("Fehler beim Abmelden: \(error.localizedDescription)")
        }
    }
}

struct EingeloggtView_Previews: PreviewProvider {
    static var previews: some View {
        EingeloggtView()
           .environmentObject(DataManager())
    }
}
