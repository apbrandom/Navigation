//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Вадим Виноградов on 16.05.2023.
//

import Foundation

class FeedViewModel {
    var feedModel = FeedModel()
    
    private let passwordCracking = PasswordCrack()
    private var timer: Timer?
    private var secondsPassed = 0
    
    var passwordUpdated: ((String) -> Void)?
    var activityIndicatorState: ((Bool) -> Void)?
    var passwordStatus: ((Bool) -> Void)?
    var timerUpdated: ((String) -> Void)?
    
    func generateAndCrackPassword() {
        // Generate password
        let password = passwordCracking.generateRandomPassword(length: 4)
        passwordUpdated?(password)
            
        // Starting the activity indicator
        activityIndicatorState?(true)

        //Start the timer and update the timer every second
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            self?.secondsPassed += 1
            self?.timerUpdated?(self?.timeString(seconds: self?.secondsPassed ?? 0) ?? "")
        }
            
        // Password cracking (in background thread)
        DispatchQueue.global().async { [weak self] in
            self?.passwordCracking.bruteForce(passwordToUnlock: password)
            DispatchQueue.main.async {
                // Stopping the activity indicator
                self?.activityIndicatorState?(false)

                // Update password status
                self?.passwordStatus?(true)

                // Stop timer
                self?.timer?.invalidate()
                self?.timer = nil
                self?.secondsPassed = 0
            }
        }
    }
        
    private func timeString(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
