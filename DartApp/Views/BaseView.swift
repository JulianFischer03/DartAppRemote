//
//  BaseView.swift
//  FinanzAppV2
//
//  Created by Julian Fischer on 16.05.23.
//

import SwiftUI

struct BaseView: View {
    @StateObject private var gameSettings = GameSettings()
    
    @State var currentTab = "person"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Tab View
            TabView(selection: $currentTab) {
                
                PersonView()
                    .modifier(HintergrundModifizierer())
                    .tag("person")
                
                PreGameView()
                    .environmentObject(gameSettings)
                    .modifier(HintergrundModifizierer())
                    .tag("dart")
                
                StatsView()
                    .modifier(HintergrundModifizierer())
                    .tag("graph")
            
            }
            
            HStack(spacing: 80) {
                
                           TabButton(image: "graph")
                          
                           
                Button {
                                    currentTab = "dart"
                    } label: {
                            Image("dart")
                            .resizable()
                            .frame(width: 50, height: 50)
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(16)
                                        .tag("dart")
                                        .background(
                                            Circle()
                                                .fill(Color("Rot"))
                                                .frame(width: 70, height: 70)
                                                .shadow(color: Color("Rot").opacity(0.15), radius: 5, x: 0, y: 8)
                                        )
                                }
                                .offset(y: -30)
                                
                           
                           TabButton(image: "person")
                       }
                       .frame(maxWidth: .infinity, minHeight: 60)
                       .background(Color("HintergrundLeiste"))
        
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    func TabButton(image: String) -> some View{
        
        Button{
            withAnimation {
                currentTab = image
            }
        } label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(
                
                    currentTab == image ? Color.black :
                        Color.gray.opacity(0.95)
                )
        }
    }

    
}



struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}



//Hintergrund Modifizierer

struct HintergrundModifizierer: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Weiß").ignoresSafeArea())
    }
}

