//
//  DataManager.swift
//  DartApp
//
//  Created by Julian Fischer on 08.06.23.
//

import SwiftUI
import Firebase
class DataManager: ObservableObject {
    @Published var stats: Stats
    @Published var userIstEingeloggt = false
    
    init() {
        stats = Stats(id: "yourPlayerID", hundertAchtziger: 0, hundertVierzigPlus: 0, hundertPlus: 0, sechzigPlus: 0, doppelQuote: 0.0, darts: 0, avgAllTime: 0.0, legsGespielt: 0, legsGewonnen: 0,setsGespielt: 0,setsGewonnen: 0, spieleGespielt: 0, spieleGewonnen: 0, siegQuote: 0.0, dartsProLeg: [0], avgProLeg: [0])
        fetchStats()
    }
    
    func fetchStats() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Benutzer nicht angemeldet")
            return
        }
        
        let db = Firestore.firestore()
        let ref = db.collection("Stats").document(currentUserID)
        
        ref.getDocument { snapshot, error in
            if let error = error {
                print("Error fetching stats: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists else {
                print("Stats document does not exist")
                return
            }
            
            let data = snapshot.data()
            let id = currentUserID
            let hundertAchtziger = data?["hundertAchtziger"] as? Int ?? 0
            let hundertVierzigPlus = data?["hunderVierzigPlus"] as? Int ?? 0
            let hundertPlus = data?["hunderPlus"] as? Int ?? 0
            let sechzigPlus = data?["sechzigPlus"] as? Int ?? 0
            let doppelQuote = data?["doppelQuote"] as? Float ?? 0.0
            let darts = data?["darts"] as? Int ?? 0
            let avgAllTime = data?["avgAllTime"] as? Float ?? 0.0
            let legsGespielt = data?["legsGespielt"] as? Int ?? 0
            let legsGewonnen = data?["legsGewonnen"] as? Int ?? 0
            let setsGespielt = data?["setsGespielt"] as? Int ?? 0
            let setsGewonnen = data?["setsGewonnen"] as? Int ?? 0
            let spieleGespielt = data?["spieleGespielt"] as? Int ?? 0
            let spieleGewonnen = data?["spieleGewonnen"] as? Int ?? 0
            let siegQuote = data?["siegQuote"] as? Float ?? 0.0
            let dartsProLeg = data?["dartsProLeg"] as? [Int] ?? [0]
            let avgProLeg = data?["avgProLeg"] as? [Float] ?? [0.0]
            
            self.stats = Stats(id: id, hundertAchtziger: hundertAchtziger, hundertVierzigPlus: hundertVierzigPlus, hundertPlus: hundertPlus, sechzigPlus: sechzigPlus, doppelQuote: doppelQuote, darts: darts, avgAllTime: avgAllTime, legsGespielt: legsGespielt, legsGewonnen: legsGewonnen, setsGespielt: setsGespielt, setsGewonnen: setsGewonnen, spieleGespielt: spieleGespielt, spieleGewonnen: spieleGewonnen, siegQuote: siegQuote, dartsProLeg: dartsProLeg, avgProLeg: avgProLeg)
        }
    }


    
    func saveStatsForUser(playerID: String, hundertAchtziger: Int, hundertVierzigPlus: Int, hundertPlus: Int, sechzigPlus: Int ,doppelQuote: Float, darts: Int, avgAllTime: Float, legsGespielt: Int, legsGewonnen: Int,setsGespielt: Int, setsGewonnen: Int, spieleGespielt: Int, spieleGewonnen: Int, siegQuote: Float, dartsProLeg: [Int], avgProLeg: [Float]) {
        if let currentUserID = Auth.auth().currentUser?.uid {
            let data: [String: Any] = [
                "hundertAchtziger": hundertAchtziger,
                "hundertVierzigPlus": hundertVierzigPlus,
                "hundertPlus": hundertPlus,
                "sechzigPlus": sechzigPlus,
                "doppelQuote": doppelQuote,
                "darts": darts,
                "avgAllTime": avgAllTime,
                "legsGespielt": legsGespielt,
                "legsGewonnen": legsGewonnen,
                "setsGespielt": setsGespielt,
                "setsGewonnen": setsGewonnen,
                "spieleGespielt": spieleGespielt,
                "spieleGewonnen": spieleGewonnen,
                "siegQuote": siegQuote,
                "dartsProLeg": dartsProLeg,
                "avgProLeg": avgProLeg
            ]
            let db = Firestore.firestore()
            let statsCollection = db.collection("Stats")
            statsCollection.document(currentUserID).setData(data) { error in
                if let error = error {
                    print("Error saving stats: \(error.localizedDescription)")
                } else {
                    print("Stats saved successfully!")
                }
            }
        } else {
           print("Benutzer nicht angemeldet")
        }
    }
    
    func dreiDartsGeworfen(inputScore: Int) {
        stats.darts += 3
        
        if inputScore == 180 {
            stats.hundertAchtziger += 1
        }
        if inputScore >= 140 {
            stats.hundertVierzigPlus += 1
        }
        if inputScore >= 100 {
            stats.hundertPlus += 1
        }
        if inputScore >= 60 {
            stats.sechzigPlus += 1
        }
        
        saveStats()
    }
    
    func legGewonnen(darts: Int, avg: Float) {
        stats.legsGespielt += 1
        stats.legsGewonnen += 1
        stats.dartsProLeg.append(darts)
        stats.avgProLeg.append(avg)
        
        saveStats()
    }
    
    func legVerloren(avg: Float) {
        stats.legsGespielt += 1
        stats.avgProLeg.append(avg)
        
        saveStats()
    }
    
    func setGewonnen() {
        stats.setsGespielt += 1
        stats.setsGewonnen += 1
        
        saveStats()
    }
    
    func setVerloren() {
        stats.setsGespielt += 1
        
        saveStats()
    }
    
    func matchGewonnen() {
        stats.spieleGespielt += 1
        stats.spieleGewonnen += 1
        
        saveStats()
    }
    
    func matchVerloren() {
        stats.spieleGespielt += 1
        
        saveStats()
    }
    
    func saveStats() {
        saveStatsForUser(playerID: stats.id, hundertAchtziger: stats.hundertAchtziger, hundertVierzigPlus: stats.hundertVierzigPlus, hundertPlus: stats.hundertPlus, sechzigPlus: stats.sechzigPlus, doppelQuote: stats.doppelQuote, darts: stats.darts, avgAllTime: stats.avgAllTime, legsGespielt: stats.legsGespielt, legsGewonnen: stats.legsGewonnen, setsGespielt: stats.setsGespielt, setsGewonnen: stats.setsGewonnen, spieleGespielt: stats.spieleGespielt, spieleGewonnen: stats.spieleGewonnen, siegQuote: stats.siegQuote, dartsProLeg: stats.dartsProLeg, avgProLeg: stats.avgProLeg)
    }
    
    func logout() {
            do {
                try Auth.auth().signOut()
                userIstEingeloggt = false // Zustand für den Benutzerstatus aktualisieren
            } catch {
                print("Fehler beim Abmelden: \(error.localizedDescription)")
            }
        }
}
