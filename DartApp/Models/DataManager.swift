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
        stats = Stats(id: "yourPlayerID", hundertAchtziger: 0, doppelQuote: 0.0, darts: 0)
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
            let doppelQuote = data?["doppelQuote"] as? Float ?? 0.0
            let darts = data?["darts"] as? Int ?? 0
            
            self.stats = Stats(id: id, hundertAchtziger: hundertAchtziger, doppelQuote: doppelQuote, darts: darts)
        }
    }


    
    func saveStatsForUser(playerID: String, hundertAchtziger: Int, doppelQuote: Float, darts: Int) {
        if let currentUserID = Auth.auth().currentUser?.uid {
            let data: [String: Any] = [
                "hundertAchtziger": hundertAchtziger,
                "doppelQuote": doppelQuote,
                "darts": darts
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

    
    func incrementHundertAchtziger() {
        stats.hundertAchtziger += 1
        saveStatsForUser(playerID: stats.id, hundertAchtziger: stats.hundertAchtziger, doppelQuote: stats.doppelQuote, darts: stats.darts)
    }
    
    func incrementDarts(){
        stats.darts += 3
        saveStatsForUser(playerID: stats.id, hundertAchtziger: stats.hundertAchtziger, doppelQuote: stats.doppelQuote, darts: stats.darts)
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