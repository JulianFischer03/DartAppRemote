//
//  settingsView.swift
//  DartApp
//
//  Created by Julian Fischer on 16.06.23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack{
            
            Color.black
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1100, height: 450)
                .rotationEffect (.degrees (135))
                .offset (y: -350)
            
            
            VStack{
                Text("Hier wirst du bald verschiedene Einstellungen vornehmen können")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
            }
        .frame(width: 370, height: 50)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        )
        .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
