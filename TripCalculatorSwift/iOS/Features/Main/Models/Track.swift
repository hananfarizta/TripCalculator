//
//  Track.swift
//  TripCalculatorSwift
//
//  Created by Hanan Farizta on 19/09/24.
//

import Foundation
import SwiftUI

enum Difficulty: String {
    case easy = "Easy"
    case intermediate = "Intermediate"
    case expert = "Expert"
}


@Observable
class Track {
    
    var averageDuration: String
    var climbDistance: String
    var difficulty: Difficulty
    
    var totalDuration: String
    var totalDistance: String
    var upwardsDistance: String
    var downwardsDistance: String
    
    
    // MARK: - Inits
    init(averageDuration: String, climbDistance: String, difficulty: Difficulty, totalDuration: String, totalDistance: String, upwardsDistance: String, downwardDistance: String) {
        self.averageDuration = averageDuration
        self.climbDistance = climbDistance
        self.difficulty = difficulty
        
        self.totalDuration = totalDuration
        self.totalDistance = totalDistance
        self.upwardsDistance = upwardsDistance
        self.downwardsDistance = downwardDistance
    }
}
