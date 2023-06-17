//
//  QRCodeView.swift
//  DartApp
//
//  Created by Julian Fischer on 16.06.23.
//

import SwiftUI

struct QRCodeView: View {
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
                Text("Kommt bald!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 1)
                    .frame(width:200, height: 3)
                    .foregroundColor(.white)
                    .offset(y:-15)
                
                Text("Um mit Freunden auf einem Gerät zu spielen und die Statistiken aktuell zu halten, scanne einfach den QR-Code deines Freundes und spielt gegeneinander!")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .frame(width: 370, height: 125)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    )
                    .padding()
                
            }
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
