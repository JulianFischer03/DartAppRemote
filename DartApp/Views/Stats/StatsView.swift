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
    
    @State private var selectedOption = 0
    let options = ["Darts pro Leg", "Doppelquote", "Avg. Pro Leg"]
    
    struct dartsProLeg {
        var legNummer: Int
        var dartsProLeg: Int
    }
    var data1: [dartsProLeg] {
            var dataArray1: [dartsProLeg] = []
            for (index, darts) in dataManager.stats.dartsProLeg.enumerated() {
                let item = dartsProLeg(legNummer: index, dartsProLeg: darts)
                dataArray1.append(item)
            }
            return dataArray1
        }
   
    struct doppelQuoteProMatch {
        var matchNummer: Int
        var doppelQuoteProMatch: Float
    }
    var data2: [doppelQuoteProMatch] {
            var dataArray2: [doppelQuoteProMatch] = []
            for (index, quote) in dataManager.stats.lastDoppelQuote.enumerated() {
                let item = doppelQuoteProMatch(matchNummer: index, doppelQuoteProMatch: quote)
                dataArray2.append(item)
            }
            return dataArray2
        }
    
    struct avgProLeg {
        var legNummer: Int
        var avgProLeg: Float
    }
    var data3: [avgProLeg] {
            var dataArray3: [avgProLeg] = []
            for (index, avg) in dataManager.stats.avgProLeg.enumerated() {
                let item = avgProLeg(legNummer: index, avgProLeg: avg)
                dataArray3.append(item)
            }
            return dataArray3
        }
    
    
    
    var body: some View {
        
        ZStack{
            
            Color.black
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 550)
                .rotationEffect (.degrees (225))
               // .offset (y: -350)
            
                
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
                
                Text(String(format: "Deine gesamte Doppelquote: %.2f", dataManager.stats.avgDoppelQuote))
                    .font(.body)
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                
                Text(String(format:"Deine Siegquote: \(dataManager.stats.siegQuote) %"))
                    .font(.body)
                    .foregroundColor(.white)
                    .bold()
                
                VStack{
                
                    Picker("Select an option", selection: $selectedOption) {
                            ForEach(0..<3) { index in       //3 optionen deswegen 0..3
                                Text(options[index])
                                
                            }
                        }
                    .pickerStyle(.segmented)
                    .frame(width: 350)
                    .padding(.bottom,15)
                    
                    
                    if selectedOption == 0 { //Option DartsProLeg
                        Chart(data1, id: \.legNummer) { item in
                            BarMark(
                                x: .value("Leg", item.legNummer),
                                y: .value("Darts", item.dartsProLeg)
                            )
                        }
                        .chartXAxis {
                          AxisMarks(values: .automatic) { _ in
                              AxisGridLine(centered: true, stroke: StrokeStyle(dash: [0]))
                              .foregroundStyle(Color.white)
                            AxisValueLabel()
                          }
                        }
                        .chartYAxis {
                          AxisMarks(values: .automatic) { _ in
                            AxisGridLine(centered: true, stroke: StrokeStyle(dash: [0]))
                              .foregroundStyle(Color.white)
                            AxisValueLabel()
                          }
                        }
                        .frame(maxWidth: 300, maxHeight: 300)
                        .foregroundStyle(Color.black.gradient)
                    }
                    if selectedOption == 1 {
                        Chart(data2, id: \.matchNummer) { item in
                            BarMark(
                                x: .value("Match", item.matchNummer),
                                y: .value("Quote", item.doppelQuoteProMatch)
                            )
                        }
                        .chartXAxis {
                          AxisMarks(values: .automatic) { _ in
                              AxisGridLine(centered: true, stroke: StrokeStyle(dash: [0]))
                              .foregroundStyle(Color.white)
                            AxisValueLabel()
                          }
                        }
                        .chartYAxis {
                          AxisMarks(values: .automatic) { _ in
                            AxisGridLine(centered: true, stroke: StrokeStyle(dash: [0]))
                              .foregroundStyle(Color.white)
                            AxisValueLabel()
                          }
                        }
                        .frame(maxWidth: 300, maxHeight: 300)
                        .foregroundStyle(Color.black.gradient)
                    }
                    
                    if selectedOption == 2 {            //avg pro Leg
                        Chart(data3, id: \.legNummer) { item in
                            BarMark(
                                x: .value("Leg", item.legNummer),
                                y: .value("Avg", item.avgProLeg)
                            )
                        }
                        .chartXAxis {
                          AxisMarks(values: .automatic) { _ in
                              AxisGridLine(centered: true, stroke: StrokeStyle(dash: [0]))
                              .foregroundStyle(Color.white)
                            AxisValueLabel()
                          }
                        }
                        .chartYAxis {
                          AxisMarks(values: .automatic) { _ in
                            AxisGridLine(centered: true, stroke: StrokeStyle(dash: [0]))
                              .foregroundStyle(Color.white)
                            AxisValueLabel()
                          }
                        }
                        .frame(maxWidth: 300, maxHeight: 300)
                        .foregroundStyle(Color.black.gradient)
                    }
                    
                    Spacer()
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
