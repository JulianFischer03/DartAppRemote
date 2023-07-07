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
    
    var body: some View {
        
    /*    let hundertAchtziger: Int = dataManager.stats.hundertAchtziger
        if hundertAchtziger > 0 &&  hundertAchtziger < 10 {
            progress180 = 1
        } else if hundertAchtziger < 100 {
            progress180 = 2
        } else if hundertAchtziger > 100 {
            progress180 = 3
        }
       
        return*/ ZStack{
            
            Color.black
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1100, height: 450)
                .rotationEffect (.degrees (135))
                .offset (y: -650)
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red],startPoint:.topLeading, endPoint: .bottomTrailing))
                .frame(width: 1100, height: 250)
                .rotationEffect (.degrees (135))
                .offset (y: 550)
            
            
            VStack{
                HStack{
                    Text("Du erhälst Badges durch das erreichen verschiedener Meilensteine!")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                }
                .frame(width: 370, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                )
                
                VStack{ //Rahmen für einzelne Badge Kategorien
                    BadgeCategoryView(title: "180er",  badgeImages: ["badge1", "badge1", "badge1"], progress: progress180 ,nextBadgeArr: ["1-180er" , "10-180er" , "100-180er"])
                    
                    

                    BadgeCategoryView(title: "Doppelmeister", badgeImages: ["badge1", "badge1", "badge1"], progress: progressDouble, nextBadgeArr: ["25%", "50%", "75%"])
                    
                    BadgeCategoryView(title: "Darts", badgeImages: ["badge1", "badge1", "badge1"], progress: progressDarts, nextBadgeArr: ["250", "1000", "10000"])

                    
                }
                
                
                
                .padding()
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
