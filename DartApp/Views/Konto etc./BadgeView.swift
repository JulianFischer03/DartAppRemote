//
//  BadgeView.swift
//  DartApp
//
//  Created by Julian Fischer on 16.06.23.
//

import SwiftUI

struct BadgeView: View {
    
    @EnvironmentObject private var dataManager: DataManager
    
    @State private var progress180 = 0
    @State private var progressDouble = 0
    @State private var progressDarts = 0
    @State private var progressSpiele = 0
    
    var body: some View {
        ScrollView{
            ZStack{
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.red, .pink],startPoint:.topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1100, height: 250)
                    .rotationEffect (.degrees (135))
                    .offset (y: -500)
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1100, height: 250)
                    .rotationEffect (.degrees (135))
                    .offset (y: 550)
                
                   
                
                
                VStack{
                    Text("Badges")
                        .foregroundColor(.white)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                    
                    HStack{
                        Text("Du erhälst Badges durch das erreichen verschiedener Meilensteine!")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.horizontal, 4)
                    }
                    .frame(width: 370, height: 75)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    )
                    
                    VStack{ //Rahmen für einzelne Badge Kategorien
                        
                        BadgeCategoryView(title: "Darts", badgeImages: ["badge1", "badge1", "badge1"], progress: progressDarts, nextBadgeArr: ["250", "1000", "10000"])
                        
                        
                        BadgeCategoryView(title: "180er",  badgeImages: ["badge1", "badge1", "badge1"], progress: progress180 ,nextBadgeArr: ["1-180er" , "10-180er" , "100-180er"])
                        
                        
                        BadgeCategoryView(title: "Doppelmeister", badgeImages: ["badge1", "badge1", "badge1"], progress: progressDouble, nextBadgeArr: ["10%", "25%", "50%"])
                        
                        BadgeCategoryView(title: "Spiele", badgeImages: ["badge1", "badge1", "badge1"], progress: progressSpiele, nextBadgeArr: ["10", "100", "1000"])
                     
                        
                    }
                    
                    
                    
                    .padding()
                }
            }
        }
        .background(.linearGradient(colors: [.black, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
        .onAppear{
            let hundertAchtziger: Int = dataManager.stats.hundertAchtziger
            if hundertAchtziger > 0 &&  hundertAchtziger < 10 {
                progress180 = 1
            } else if hundertAchtziger < 100 {
                progress180 = 2
            } else if hundertAchtziger > 100 {
                progress180 = 3
            }
            
            let doppelQuote: Float = dataManager.stats.avgDoppelQuote
            if doppelQuote >= 10 && doppelQuote < 25{
                progressDouble = 1
            } else if doppelQuote >= 25 && doppelQuote < 50 {
                progressDouble = 2
            } else if doppelQuote > 50 {
                progressDouble = 3
            }
            
            let darts: Int = dataManager.stats.darts
            if darts >= 250 && darts < 1000 {
                progressDarts = 1
            } else if darts >= 1000 && darts < 10000{
                progressDarts = 2
            } else if darts >= 10000 {
                progressDarts = 3
            }
            
            let spiele: Int = dataManager.stats.spieleGespielt
            if spiele >= 10 && spiele < 100 {
                progressSpiele = 1
            }else if spiele >= 100 && spiele < 1000 {
                progressSpiele = 2
            }else if spiele > 1000 {
                progressSpiele = 3
            }
        }
    }
        
}

struct BadgeCategoryView: View {
    var title: String
    var badgeImages: [String]
    var progress: Int
    var nextBadgeArr: [String]
    
    var nextBadge: String {
        if progress < nextBadgeArr.count {
            return nextBadgeArr[progress]
        } else {
            return "Alle erreicht!"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .padding(.horizontal)
                Spacer()
                Text("Nächstes Badge: \(nextBadge)")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .padding(.horizontal)
            }
            .offset(y:10)
            HStack {
                ForEach(0..<3) { index in
                    Image(badgeImages[index])
                        .resizable()
                        .frame(width: 50, height: 50)
                        .opacity(index < progress ? 1 : 0.3)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
            }
            .padding(.bottom)
        }
        .frame(width: 370, height: 100)
        .background(Color.white)
        .cornerRadius(15)
        .foregroundColor(.black)
        .padding()
    }
}




struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView()
            .environmentObject(DataManager())
    }
}
