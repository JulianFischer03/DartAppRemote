//
//  PreGameView.swift
//  DartApp
//
//  Created by Julian Fischer on 26.05.23.
//

import SwiftUI
import Combine
import FirebaseAuth

struct PreGameView: View {
    
    @EnvironmentObject private var gameSettings: GameSettings
    @EnvironmentObject private var selectedPlayer: SelectedPlayer
    
    @State private var selectedPlayer1 = "Gast1"
    @State private var selectedPlayer2 = "Gast2"
    @State private var selectedSets: Int = 1
    @State private var selectedLegs: Int = 1
    
    @State private var selectedButton: Int = 1
    @State private var selectedButtonCount: Int = 2
    @State private var selectedButtonBestFirst: Int = 1
    
    @State private var showAlert = false
    @State private var customValueInput = ""
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.black
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [Color("Rot2"), Color("Rot3")],startPoint:.topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 570)
                    .rotationEffect (.degrees (225))
                    .offset (y: 10)
                
                VStack{
                   
                    VStack{
                        
                        Text("Spiel")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        Rectangle()
                            .frame(width: 100, height: 3)
                            .foregroundColor(.white)
                            .offset(y: -20)
                    }
                    
                    
                    HStack(spacing: 27) {
                        
                        Button(action: {
                            gameSettings.spielerZahl = 2
                            selectedButton = 1
                        }) {
                            
                            Text("1 gegen 1")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 125, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(selectedButton == 1 ? .black : .white)
                                )
                                .foregroundColor(selectedButton == 1 ? .white : .black)
                        }
                        
                        
                        // Button 2
                        Button(action: {
                            gameSettings.spielerZahl = 4
                            selectedButton = 2
                        }) {
                            Text("Teams")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 125, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(selectedButton == 2 ? .black : .white)
                                )
                                .foregroundColor(selectedButton == 2 ? .white : .black)
                        }
                    }
                    .padding(.horizontal, 10)
                    
                    HStack(spacing: 27) {
                        VStack {
                            Text("Spieler 1:")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Rectangle()
                                .frame(width: 100, height: 2)
                                .foregroundColor(.white)
                                .offset(y: -10)
                            Picker("", selection: $selectedPlayer.player1) {
                                Text("Gast1").tag("Gast1")
                                Text("Du").tag("Du")
                            }
                            .pickerStyle(MenuPickerStyle())
                            .tint(.black)
                            .bold()
                            .frame(width: 125, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white))
                            
                        }
                        
                        VStack {
                            Text("Spieler 2:")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .bold()
                                .foregroundColor(.white)
                            Rectangle()
                                .frame(width: 100, height: 2)
                                .foregroundColor(.white)
                                .offset(y: -10)
                            Picker("", selection: $selectedPlayer.player2) {
                                Text("Gast2").tag("Gast2")
                                Text("Du").tag("Du")
                            }
                            .pickerStyle(MenuPickerStyle())
                            .tint(.black)
                            .bold()
                            .frame(width: 125, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white))
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        Rectangle()
                            .frame(width: 500, height: 2)
                            .foregroundColor(.white)
                            .offset(y: 10)
                        
                        Text("Einstellungen")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .bold()
                        
                        Rectangle()
                            .frame(width: 500, height: 2)
                            .foregroundColor(.white)
                            .offset(y: -10)
                    }
                    .padding(.horizontal)
                    
                    
                    
                    HStack{
                        Button(action: {
                            gameSettings.punkteHöhe = 301
                            selectedButtonCount = 1
                        }) {
                            Text("301")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 80, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(selectedButtonCount == 1 ? .black : .white)
                                )
                                .foregroundColor(selectedButtonCount == 1 ? .white : .black)
                        }
                        Button(action: {
                            gameSettings.punkteHöhe = 501
                            selectedButtonCount = 2
                        }) {
                            Text("501")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 80, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(selectedButtonCount == 2 ? .black : .white)
                                )
                                .foregroundColor(selectedButtonCount == 2 ? .white : .black)
                        }
                        
                        Button(action: {
                            gameSettings.punkteHöhe = 701
                            selectedButtonCount = 3
                        }) {
                            Text("701")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(width: 80, height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(selectedButtonCount == 3 ? .black : .white)
                                )
                                .foregroundColor(selectedButtonCount == 3 ? .white : .black)
                        }
                        
                        Button(action: {
                            selectedButtonCount = 4
                            showAlert = true
                            gameSettings.punkteHöhe = Int(customValueInput) ?? 501
                            }) {
                            Text("Custom:")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .frame(width: 80, height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(selectedButtonCount == 4 ? .black : .white)
                                    )
                                    .foregroundColor(selectedButtonCount == 4 ? .white : .black)
                            }
                        
                            .alert("Eingabe", isPresented: $showAlert, actions: {
                                       // Any view other than Button would be ignored
                                
                                       TextField("Gib hier den Startwert an", text: $customValueInput)
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(customValueInput)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.customValueInput = filtered
                                                }
                                            }
                                   })
                        
                    }
                    .padding(.horizontal)
                    
                    
                    HStack{
                        Button(action: {
                           
                            gameSettings.spielArt = 1
                            selectedButtonBestFirst = 1
                        }) {
                            Text("Best Of")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(width: 125, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(selectedButtonBestFirst == 1 ? .black : .white)
                            )
                            .foregroundColor(selectedButtonBestFirst == 1 ? .white : .black)
                    }
                        
                        
                        Button(action: {
                            gameSettings.leisteUnten = false
                            gameSettings.spielArt = 2
                            selectedButtonBestFirst = 2
                        }) {
                            Text("First to")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(width: 125, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(selectedButtonBestFirst == 2 ? .black : .white)
                            )
                            .foregroundColor(selectedButtonBestFirst == 2 ? .white : .black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    HStack(spacing: 40) {
                        VStack {
                            Text("Legs")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Rectangle()
                                .frame(width: 100, height: 2)
                                .foregroundColor(.white)
                                .offset(y: -10)
                            Picker("", selection: $selectedLegs) {
                                ForEach(1...10, id: \.self) { number in
                                    Text("\(number)")
                                    
                                }
                            }
                            .onChange(of: selectedLegs) { newValue in
                                gameSettings.legs = newValue}
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .pickerStyle(MenuPickerStyle())
                            .tint(.black)
                            .bold()
                            .frame(width: 125, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white))
                    
                        }
                        
                        VStack {
                            Text("Sets")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Rectangle()
                                .frame(width: 100, height: 2)
                                .foregroundColor(.white)
                                .offset(y: -10)
                            Picker("", selection: $selectedSets) {
                                ForEach(1...10, id: \.self) { number in
                                    Text("\(number)")
                                    
                                }
                            }
                            .onChange(of: selectedSets) { newValue in
                                gameSettings.sets = newValue}
                            .pickerStyle(MenuPickerStyle())
                            .tint(.black)
                            .bold()
                            .frame(width: 125, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                            )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    
                    VStack{
                        NavigationLink(destination: GameView()) {
                            
                            Text("Game On")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .frame(width: 250, height: 55)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("DunkelGrün")))
                                    .foregroundColor(.white)
                    
                        }
                    }
                }// ENDE HSTACK
                .offset(y: -20)
            }
        }
    }
    
    func getLoggedInUserID() -> String? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        } else {
            return nil
        }
    }
    
}

struct PreGameView_Previews: PreviewProvider {
    static var previews: some View {
        PreGameView()
            .environmentObject(GameSettings())
            .environmentObject(SelectedPlayer())
    }
}
