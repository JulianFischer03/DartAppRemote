//
//  StatsView.swift
//  DartApp
//
//  Created by Julian Fischer on 26.05.23.
//

import SwiftUI
import Charts

struct StatsView: View {
    
    @EnvironmentObject private var dataManager: DataManager
    
   
    
    var body: some View {
        
        ZStack{
            
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect (.degrees (225))
                .offset (y: -350)
            
                
                VStack {
                    Text("Hello, Stats!")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.green.shadow(.drop(radius: 2)))
                        )
                        .padding(25)
                    
                    
                    Text("Deine geworfenen Darts: \(dataManager.stats.darts)")
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.green.shadow(.drop(radius: 2)))
                    )
                    .padding(15)
                    
                    Text("Deine geworfenen 180s: \(dataManager.stats.hundertAchtziger)")
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.green.shadow(.drop(radius: 2)))
                    )
                    .padding(15)
                    
                    Text(String(format: "Deine gesamte Doppelquote: %.2f", dataManager.stats.doppelQuote))
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.green.shadow(.drop(radius: 2)))
                    )
                    .padding(15)
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(DataManager())
    }
}
