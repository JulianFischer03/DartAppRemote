//
//  Stats.swift
//  DartApp
//
//  Created by Julian Fischer on 08.06.23.
//

import SwiftUI

struct Stats: Identifiable {
    
    var id: String

    var hundertAchtziger: Int
    var hundertVierzigPlus: Int
    var hundertPlus: Int
    var sechzigPlus: Int
    var lastDoppelQuote: [Float]
    var avgDoppelQuote: Float
    var darts: Int
    var avgAllTime: Float
    var legsGespielt: Int
    var legsGewonnen: Int
    var setsGespielt: Int
    var setsGewonnen: Int
    var spieleGespielt: Int
    var spieleGewonnen: Int
    var siegQuote: Float
    var dartsProLeg: [Int]
    var avgProLeg: [Float]
    
    
   /*  kommt noch:
    var doppelQuoteGegner2DartFinish: Float
    var doppelQuoteGegner3DartFinish: Float
    var besteNineDartAvg: Float
    var bestFirstNineDartsAvg: Float
    
    Zeiträume für die ganzen einzelnen Features
    
    */
}
