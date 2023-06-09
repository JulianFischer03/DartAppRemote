//
//  EingeloggtView.swift
//  DartApp
//
//  Created by Julian Fischer on 08.06.23.
//

import SwiftUI

struct EingeloggtView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Geworfene Darts: \(dataManager.stats.darts)")
                Text("Geworfene 180s: \(dataManager.stats.hundertAchtziger)")
                Text("Deine Doppel Quote: \(dataManager.stats.doppelQuote)")
            }
        }
    }
}

struct EingeloggtView_Previews: PreviewProvider {
    static var previews: some View {
        EingeloggtView()
            .environmentObject(DataManager())
    }
}
