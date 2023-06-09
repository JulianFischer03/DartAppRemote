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
    
    init() {
        stats = Stats(id: "yourPlayerID", hundertAchtziger: 0, doppelQuote: 0.0, darts: 0)
        fetchStats()
    }
    
    func fetchStats() {
        let db = Firestore.firestore()
        let ref = db.collection("Stats").document("yourPlayerID")
        
        ref.getDocument { snapshot, error in
            guard error == nil, let snapshot = snapshot, snapshot.exists else {
                print("Error fetching stats: \(error?.localizedDescription ?? "")")
                return
            }
            
            let data = snapshot.data()
            let id = "yourPlayerID"
            let hundertAchtziger = data?["hundertAchtziger"] as? Int ?? 0
            let doppelQuote = data?["doppelQuote"] as? Float ?? 0.0
            let darts = data?["darts"] as? Int ?? 0
            
            self.stats = Stats(id: id, hundertAchtziger: hundertAchtziger, doppelQuote: doppelQuote, darts: darts)
        }
    }

    
    func saveStatsForUser(playerID: String, hundertAchtziger: Int, doppelQuote: Float, darts: Int) {
        let db = Firestore.firestore()
        let statsRef = db.collection("Stats").document(playerID)
        let data: [String: Any] = [
            "hundertAchtziger": hundertAchtziger,
            "doppelQuote": doppelQuote,
            "darts": darts
        ]

        statsRef.setData(data) { error in
            if let error = error {
                print("Error saving stats: \(error.localizedDescription)")
            } else {
                print("Stats saved successfully!")
            }
        }
    }

    
    func incrementHundertAchtziger() {
        stats.hundertAchtziger += 1
        saveStatsForUser(playerID: stats.id, hundertAchtziger: stats.hundertAchtziger, doppelQuote: stats.doppelQuote, darts: stats.darts)
    }
    
    func incrementDarts(){
        stats.darts += 3
        saveStatsForUser(playerID: stats.id, hundertAchtziger: stats.hundertAchtziger, doppelQuote: stats.doppelQuote, darts: stats.darts)
    }
}
