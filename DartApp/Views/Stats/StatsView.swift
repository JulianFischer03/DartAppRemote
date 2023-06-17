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
    @EnvironmentObject private var gameSettings: GameSettings
    
    @State private var selectedOptionGraph = 0
    @State private var selectedOptionStats = 0
    
    let optionsGraph = ["Darts pro Leg", "Doppelquote", "Avg. Pro Leg"]
    let optionsStats = ["Scoring Statistiken", "Quoten", "Match Statistiken"]
    
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
                .foregroundStyle(.linearGradient(colors: [.red, .pink],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 600)
                .rotationEffect (.degrees (225))
                .offset (y: 20)
            
                
            VStack {
                VStack{
                    Text("Statistiken")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 50)
                    Rectangle()
                        .frame(width: 200, height: 3)
                        .foregroundColor(.white)
                        .offset(y: -20)
                    
                }
                
                VStack{
                    
                    Picker("Select an option", selection: $selectedOptionStats) {
                            ForEach(0..<3) { index in
                                Text(optionsStats[index])
                                
                            }
                        }
                    .pickerStyle(.wheel)
                    .frame(width: 350)
                    .padding(.bottom,15)
                    
                    
                   
                    
                    switch selectedOptionStats {
                    case 0:
                        Text("Deine geworfenen Darts: \(dataManager.stats.darts)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(width: 370, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            )
                            .foregroundColor(.black)
                       
                        HStack{
                            Text("Davon 180s: \(dataManager.stats.hundertAchtziger)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                            
                            Text("Davon 140+: \(dataManager.stats.hundertVierzigPlus)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                        }
                        HStack{
                            Text("Davon 100+: \(dataManager.stats.hundertPlus)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                            
                            Text("Davon 60+: \(dataManager.stats.sechzigPlus)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                        }
                    case 1:
                        
                        HStack{
                            Text("Doppel Quote: \(dataManager.stats.avgDoppelQuote)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                            
                            Text("Dein Avg.: \(dataManager.stats.avgAllTime)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                        }
                    case 2:
                        
                        Text("Sieg Quote: \(dataManager.stats.siegQuote)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(width: 370, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            )
                            .foregroundColor(.black)
                        
                        HStack{
                            Text("Spiele gespielt: \(dataManager.stats.spieleGespielt)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                            
                            Text("Davon gewonnen: \(dataManager.stats.spieleGewonnen)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                        }
                        HStack{
                            Text("Sets gespielt: \(dataManager.stats.setsGespielt)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                            
                            Text("Davon gewonnen: \(dataManager.stats.setsGewonnen)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                        }
                        HStack{
                            Text("Legs gespielt: \(dataManager.stats.legsGespielt)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                            
                            Text("Davon gewonnen: \(dataManager.stats.legsGewonnen)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 180, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.white)
                                )
                                .foregroundColor(.black)
                        }
                        
                        
                        
                    default:
                        Text("Wähle eine Statistik aus")
                    }
                    
                    
                    
                    
                   
                }
                VStack{
                
                    Picker("Select an option", selection: $selectedOptionGraph) {
                            ForEach(0..<3) { index in       //3 optionen deswegen 0..3
                                Text(optionsGraph[index])
                                
                            }
                        }
                    .pickerStyle(.segmented)
                    .frame(width: 350)
                    .padding(.bottom,15)
                    
                    
                    if selectedOptionGraph == 0 { //Option DartsProLeg
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
                    if selectedOptionGraph == 1 {
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
                    
                    if selectedOptionGraph == 2 {            //avg pro Leg
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
        .onAppear(){
                gameSettings.leisteUnten = true
        }
    }
        
    
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(DataManager())
            .environmentObject(GameSettings())
    }
}
