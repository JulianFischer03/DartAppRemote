//
//  ContentView.swift
//  DartApp
//
//  Created by Julian Fischer on 26.05.23.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        
        BaseView()
            .environmentObject(DataManager())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
