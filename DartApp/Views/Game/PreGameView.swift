//
//  PreGameView.swift
//  DartApp
//
//  Created by Julian Fischer on 26.05.23.
//

import SwiftUI

struct PreGameView: View {
    
    @EnvironmentObject private var gameSettings: GameSettings
    
    @State private var selectedPlayer1 = "Gast1"
    @State private var selectedPlayer2 = "Gast2"
    @State private var selectedSets: Int = 1
    @State private var selectedLegs: Int = 1
    
    @State private var selectedButton: Int = 1
    @State private var selectedButtonCount: Int = 2
    @State private var selectedButtonBestFirst: Int = 1
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    
                    Image("MTVLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(1)
                    
                    Text("Spiel")
                        .font(.system(size: 25))
                        .padding()
                        .bold()
                    
                    Image("MTVLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(1)
                    
                    
                }
                .padding(.horizontal,10)
                .padding(.vertical,4)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background{
                    
                    RoundedRectangle(cornerRadius: 6,style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                    
                }
                
                HStack(spacing: 40) {
                    // Button 1
                    Button(action: {
                        gameSettings.spielerZahl = 2
                        selectedButton = 1
                    }) {
                        
                        Text("1 gegen 1")
                        
                            .foregroundColor(selectedButton == 1 ? .white : .blue)
                            .padding()
                            .background(selectedButton == 1 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                    
                    
                    // Button 2
                    Button(action: {
                        gameSettings.spielerZahl = 4
                        selectedButton = 2
                    }) {
                        Text("Teams")
                            .foregroundColor(selectedButton == 2 ? .white : .blue)
                            .padding()
                            .background(selectedButton == 2 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
                .padding(.top)
                
                
                
                
                HStack(spacing: 40) {
                    VStack {
                        Text("Spieler 1:")
                            .font(.system(size: 16))
                        Picker("", selection: $selectedPlayer1) {
                            Text("Gast1").tag("Gast1")
                            // Füge hier weitere Spieler hinzu
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 6,style: .continuous)
                                .fill(.white.shadow(.drop(radius: 2)))
                        )
                    }
                    
                    VStack {
                        Text("Spieler 2:")
                            .font(.system(size: 16))
                        Picker("", selection: $selectedPlayer2) {
                            Text("Gast2").tag("Gast2")
                            // Füge hier weitere Spieler hinzu
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 6,style: .continuous)
                                .fill(.white.shadow(.drop(radius: 2)))
                        )
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
                .padding(.vertical)
                
                
                HStack{
                    Image("MTVLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(1)
                    
                    Text("Einstellungen")
                        .font(.system(size: 25))
                        .padding()
                        .bold()
                    
                    Image("MTVLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(1)
                    
                }
                .padding(.horizontal,10)
                .padding(.vertical,4)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background{
                    
                    RoundedRectangle(cornerRadius: 6,style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                    
                }
                
                
                HStack{
                    Button(action: {
                        gameSettings.punkteHöhe = 301
                        selectedButtonCount = 1
                    }) {
                        Text("301")
                        
                            .foregroundColor(selectedButtonCount == 1 ? .white : .blue)
                            .padding()
                            .background(selectedButtonCount == 1 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                    
                    Button(action: {
                        gameSettings.punkteHöhe = 501
                        selectedButtonCount = 2
                    }) {
                        Text("501")
                        
                            .foregroundColor(selectedButtonCount == 2 ? .white : .blue)
                            .padding()
                            .background(selectedButtonCount == 2 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                    
                    Button(action: {
                        gameSettings.punkteHöhe = 701
                        selectedButtonCount = 3
                    }) {
                        Text("701")
                        
                            .foregroundColor(selectedButtonCount == 3 ? .white : .blue)
                            .padding()
                            .background(selectedButtonCount == 3 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                    
                    Button(action: {
                     //   gameSettings.punkteHöhe =         //Einfügen noch
                        selectedButtonCount = 4
                    }) {
                        Text("Custom:")
                        
                            .foregroundColor(selectedButtonCount == 4 ? .white : .blue)
                            .padding()
                            .background(selectedButtonCount == 4 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
                .padding(.vertical)
                
                
                HStack{
                    Button(action: {
                        gameSettings.spielArt = 1
                        selectedButtonBestFirst = 1
                    }) {
                        Text("Best Of")
                        
                            .foregroundColor(selectedButtonBestFirst == 1 ? .white : .blue)
                            .padding()
                            .background(selectedButtonBestFirst == 1 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                    
                    
                    Button(action: {
                        gameSettings.spielArt = 2
                        selectedButtonBestFirst = 2
                    }) {
                        Text("First to")
                        
                            .foregroundColor(selectedButtonBestFirst == 2 ? .white : .blue)
                            .padding()
                            .background(selectedButtonBestFirst == 2 ? Color.blue : Color.white)
                            .cornerRadius(6)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
                .padding(.vertical)
                
                
                
                HStack(spacing: 40) {
                    VStack {
                        Text("Sets")
                            .font(.system(size: 16))
                        Picker("", selection: $selectedSets) {
                            ForEach(1...10, id: \.self) { number in
                                Text("\(number)")
                               
                            }
                        }
                        .onChange(of: selectedSets) { newValue in
                            gameSettings.sets = newValue}
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.white)
                                .shadow(radius: 2)
                        )
                    }
                    
                    VStack {
                        Text("Legs")
                            .font(.system(size: 16))
                        Picker("", selection: $selectedLegs) {
                            ForEach(1...10, id: \.self) { number in
                                Text("\(number)")
                             
                            }
                        }
                        .onChange(of: selectedLegs) { newValue in
                            gameSettings.legs = newValue}
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.white)
                                .shadow(radius: 2)
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                
                    VStack{
                        NavigationLink(destination: GameView()) {
                            Text("Game On")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .frame(maxWidth: 100, maxHeight: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(Color.white.shadow(.drop(radius: 2)))
                                )
                                .padding(25)
                        }
                    
                }
            }// ENDE HSTACK
        }
    }
}

struct PreGameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameSettings())
    }
}
