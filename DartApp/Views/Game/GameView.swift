//
//  GameView.swift
//  DartApp
//
//  Created by Julian Fischer on 26.05.23.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject private var gameSettings: GameSettings
    @Environment(\.presentationMode) var presentationMode
    
    @State private var inputText = ""
    @State private var selectedNumber: Int?
    
    @State private var letzterWurfSpieler1: Array = [0]
    @State private var letzterWurfSpieler2: Array = [0]
    
    @State private var currentPlayerIsOne = true
    
    @State private var score1 = 0
    @State private var score2 = 0
    @State private var startScore = 0
    
    @State private var darts1 = 0
    @State private var darts2 = 0
    
    @State private var avg1: Array = [0]
    @State private var avg2: Array = [0]
    
    @State private var double1 = 0.0
    @State private var double2 = 0.0
    
    @State private var würfeAufDoppel1 = 0
    @State private var würfeAufDoppel2 = 0
    
    @State private var showCongratulationsPopup = false
    
    @State private var showActionSheet = false
    @State private var selectedOption: Int = -1
    
    let keyboardButtons = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [-1, 0, -2]
    ]
    
    
    
    var body: some View {
        
        
       
        
        VStack{
            
            HStack{
                VStack{         //Spieler 1 Anzeige
                    HStack{
                        
                        Image("person")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Name")
                    }
                    Text("Score:  \(score1)")
                        .bold()
                          
                    
                    Text("Letzter Wurf: " + String(letzterWurfSpieler1.last!))
                        
                    Text("Avg.: " + String(avg1.last!))
                    
                    Text("Darts: " + String(darts1))
                    
                    Text("Double: " + String(würfeAufDoppel1) + "%")
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(currentPlayerIsOne == true ?
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.green)
                            .shadow(radius: 2)
                                 :
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.white)
                            .shadow(radius: 2)
                    )
                
                .padding(.vertical)
                
                VStack{         //Spieler 2 Anzeige
                    HStack{
                        
                        Image("person")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Name")
                    }
                    Text("Score:  \(score2)")
                        .bold()
                                      
                    Text("Letzter Wurf: " + String(letzterWurfSpieler2.last!))
                        
                    Text("Avg.: " + String(avg2.last!))
                    
                    Text("Darts: " + String(darts2))
                    
                    Text("Double: " + String(würfeAufDoppel2) + "%")
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(currentPlayerIsOne == false ?
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.green)
                            .shadow(radius: 2)
                                 :
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.white)
                            .shadow(radius: 2)
                    )
                .padding(.vertical)
            }
            .onAppear {
                        // Startwert für score1 und score2 festlegen
                        score1 = gameSettings.punkteHöhe
                        score2 = gameSettings.punkteHöhe
                        startScore = gameSettings.punkteHöhe
                    }
            
            
            HStack{         // Verschiedene Tastaturen Auswahl
                
            }
            
            
            VStack(spacing: 10) {
                HStack {
                    Button(action: {
                        // Aktion für die Rückgängig Taste (Vorige Eingabe wird gelöscht)
                        if currentPlayerIsOne{
                            score2 += letzterWurfSpieler2.last!
                            letzterWurfSpieler2.removeLast()
                            darts2 -= 3 // Einfügen, dass er schaut wie viele darts beim letzten Wurf geworfen wurden
                            avg2.removeLast()
                            
                        } else{  // anders herum weil das ja nur geht wenn der andere Spieler dran ist
                            score1 += letzterWurfSpieler1.last!
                            letzterWurfSpieler1.removeLast()
                            darts1 -= 3 // Einfügen wie oben
                            avg1.removeLast()
                        }
                        currentPlayerIsOne.toggle()
                        
                    }) {
                        Image(systemName: "arrow.uturn.left")
                            .font(.title)
                            .frame(width: 80, height: 60)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 13)
                    
                    
                    Text(inputText) // Anzeige der eingegebenen Zahl
                        .font(.title)
                        .frame(width: 150, height: 60)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button(action: {
                        // Aktion für die Bestätigungstaste
                        if currentPlayerIsOne {
                            let inputScore = Int(inputText)!
                            if inputScore <= score1 {
                                // Gültige Eingabe: Score aktualisieren
                                
                                score1 -= inputScore
                                letzterWurfSpieler1.append(inputScore)
                                darts1 += 3
                                let avgNeu = Float((startScore-score1)/darts1*3)
                                avg1.append(Int(avgNeu))
                                
                            } else {    // Ungültige Eingabe: Score ist zu hoch
                                print("Fehler")
                            }
                            if score1 == 0 {// Score von Spieler 1 ist 0: Präsentationsmodus verwenden, um zur vorherigen Ansicht zurückzukehren
                                presentationMode.wrappedValue.dismiss()
                                showCongratulationsPopup = true
                            }
                            
                            
                            
                        } else {    // Ähnliche Logik für Spieler 2
                            let inputScore = Int(inputText)!
                            if inputScore <= score2 {
                                // Gültige Eingabe: Score aktualisieren
                                if istCheckbar(score2) {
                                                   showActionSheet = true
                                               }
                                score2 -= inputScore
                                letzterWurfSpieler2.append(inputScore)
                                darts2 += 3
                                
                                let avgNeu = Float((startScore-score1)/darts1*3)
                                avg2.append(Int(avgNeu))
                                
                            } else {    // Ungültige Eingabe: Score ist zu hoch
                                print("Fehler")
                            }
                        }
                        if score2 == 0 { // Score von Spieler 2 ist 0: Präsentationsmodus verwenden, um zur vorherigen Ansicht zurückzukehren
                            presentationMode.wrappedValue.dismiss()
                            showCongratulationsPopup = true
                        }
                        inputText = ""
                        currentPlayerIsOne.toggle()
                    }) {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .frame(width: 80, height: 60)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 13)
                    
                }
                .padding(.horizontal, 17)

                .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(
                                title: Text("Wie viele Würfe aufs Doppel?"),
                                buttons: [
                                    .default(Text("0"), action: {handleOptionSelected(0)}),
                                    .default(Text("1"), action: { handleOptionSelected(1)}),
                                    .default(Text("2"), action: {handleOptionSelected(2)}),
                                    .default(Text("3"), action: { handleOptionSelected(3)}),
                                    .cancel()
                                ]
                            )
                        }
                .alert(isPresented: Binding<Bool>(
                            get: { selectedOption != -1 },
                            set: { _ in selectedOption = -1 }
                        )) {
                            switch selectedOption {
                            case 0:
                                return Alert(title: Text("Option 0 ausgewählt"))
                            case 1:
                                return Alert(title: Text("Option 1 ausgewählt"))
                            case 2:
                                return Alert(title: Text("Option 2 ausgewählt"))
                            case 3:
                                return Alert(title: Text("Option 3 ausgewählt"))
                            default:
                                return Alert(title: Text("Ungültige Option ausgewählt"))
                            }
                        }
                
                
                .alert(isPresented: $showCongratulationsPopup) {
                    Alert(title: Text("Glückwunsch!"), message: Text("Spieler \(currentPlayerIsOne ? 1 : 2) hat gewonnen."), dismissButton: .default(Text("OK")))
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                    ForEach(keyboardButtons, id: \.self) { row in
                        ForEach(row, id: \.self) { number in
                            Button(action: {
                                if number >= 0 {
                                    if inputText.count < 3  { // Maximal 3 Zahlen erlaubt
                                        if let newNumber = Int("\(inputText)\(number)"), newNumber <= 180 {
                                                    inputText += "\(number)"
                                                }                                    }
                                } else if number == -1 {
                                    // Aktion für die BUST-Taste
                                    
                                    if currentPlayerIsOne{
                                        letzterWurfSpieler1.append(0)
                                        darts1 += 3
                                    } else{
                                        letzterWurfSpieler2.append(0)
                                        darts2 += 3
                                    } // Einfügen, dass man eingeben kann wie viele Darts geworfen wurden vor dem Bust
                                    
                                    currentPlayerIsOne.toggle()
                                    
                                    
                                    //Input ist 0 Abfrage wie viele Würfe gebraucht wurden
                                    
                                } else if number == -2 {
                                    // Aktion für die Rückgängig-Taste
                                    if inputText.isEmpty == false {
                                        inputText.removeLast()
                                    }
                                }
                                selectedNumber = number
                            }) {
                                ZStack {
                                    if number == -1 {
                                        Text("Bust")
                                    } else if number == -2 {
                                        Image(systemName: "arrow.left")
                                    } else {
                                        Text("\(number)")
                                    }
                                }
                                .font(.title)
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(selectedNumber == number ? Color.blue : Color.gray)
                                .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        
    }
    
    private func handleOptionSelected(_ option: Int) {
            selectedOption = option
            if option == 0 || option == 1 {
                würfeAufDoppel1 = option
            } else if option == 2 || option == 3 {
                würfeAufDoppel2 = option
            }
        }
    
    private func istCheckbar(_ score: Int) -> Bool {
        
        if score < 159 || score == 160 || score == 161 || score == 164 || score == 167 || score == 170{
            return true
        } else {
            return false
        }
        
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameSettings())
    }
}
