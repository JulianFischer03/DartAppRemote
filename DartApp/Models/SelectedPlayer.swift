//
//  SelectedPlayer.swift
//  DartApp
//
//  Created by Julian Fischer on 09.06.23.
//
import SwiftUI

class SelectedPlayer: ObservableObject {
    @Published var player1: String = "Gast1"
    @Published var player2: String = "Gast2"
}
