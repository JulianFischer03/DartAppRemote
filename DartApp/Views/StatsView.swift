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
    
    struct dartsProLeg {
        var legNummer: Int
        var dartsProLeg: Int
    }

    var data: [dartsProLeg] {
            var dataArray: [dartsProLeg] = []
            for (index, darts) in dataManager.stats.dartsProLeg.enumerated() {
                let item = dartsProLeg(legNummer: index, dartsProLeg: darts)
                dataArray.append(item)
            }
            return dataArray
        }
   
    
    var body: some View {
        
        ZStack{
            
            Color.black
            
        /*    RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect (.degrees (225))
                .offset (y: -350)
            */
                
            VStack {
                Text("Hello, Stats!")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(25)
                
                
                Text("Deine geworfenen Darts: \(dataManager.stats.darts)")
                    .font(.body)
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                
                Text("Deine geworfenen 180s: \(dataManager.stats.hundertAchtziger)")
                    .font(.body)
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                
                Text(String(format: "Deine gesamte Doppelquote: %.2f", dataManager.stats.doppelQuote))
                    .font(.body)
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                
                HStack{
                    Chart(data, id: \.legNummer) { item in
                        BarMark(
                            x: .value("Leg", item.legNummer),
                            y: .value("darts", item.dartsProLeg)
                        )
                    }
                    .cornerRadius(20)
                    .frame(maxWidth: 300, maxHeight: 300)
                    .foregroundStyle(Color.green.gradient)
                   // .background(.gray)
                }
                .padding()
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
