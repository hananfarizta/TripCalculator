//
//  MainViewModel.swift
//  TripCalculatorSwift
//
//  Created by Hanan Farizta on 19/09/24.
//

import SwiftUI

@Observable
class MainViewModel {
    
    // MARK: - Variables
    var track: Track = Track(averageDuration: "16 hours 4 minutes", climbDistance: "3180 meters", difficulty: .expert, totalDuration: "48 h 12 m", totalDistance: "28.95 km", upwardsDistance: "9450 m", downwardDistance: "10500 m")
    var isLoading = false
    
    var days: Int = 3
    
    var loaderRotation: Angle = .zero
    var loaderStart: Double = 0
    var loaderOpacity: Double =  0
    
    let climbDistance = 9540
    
    let totalHours = 49
    let totalMinutes = 12
    
    // MARK: - inits
    init() {
        
    }
    
    
    // MARK: - Functions
    func compute() {
        if (days <= 5) {
            self.track.difficulty = .expert
        } else if (days <= 14) {
            self.track.difficulty = .intermediate
        } else {
            self.track.difficulty = .easy
        }
        
        let climbDistance = climbDistance / days
        
        self.track.climbDistance = "\(climbDistance) meters"
        
        let allMinutes = totalHours * 60 + 12
        let computedMinutes = allMinutes / days
        
        let hours = computedMinutes / 60
        let minutes = computedMinutes % 60
        
        self.track.averageDuration = "\(hours) hours \(minutes) minutes"
    }
}
