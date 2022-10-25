//
//  TimeManager.swift
//  StopWatch
//
//  Created by Michal on 22/10/2022.
//

import Foundation


class TimeManager: ObservableObject {
    @Published var secondsElapsed = 0.00
    var timer = Timer()
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            self.secondsElapsed += 0.01
        })
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
    }
    
    func clearTime() {
        self.secondsElapsed = 0
    }
    
}


