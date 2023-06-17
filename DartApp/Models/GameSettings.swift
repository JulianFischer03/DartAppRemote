import SwiftUI

class GameSettings: ObservableObject {
    
    @Published var sets: Int = 1
    @Published var legs: Int = 1
    @Published var spielerZahl: Int = 2
    @Published var punkteHöhe: Int = 501
    @Published var spielArt: Int = 1 //1 = Best Of ,  2 = First To
    // Weitere Eigenschaften hier
    
    
    
    @Published var leisteUnten = true
    @Published var showGame = false
   
}

