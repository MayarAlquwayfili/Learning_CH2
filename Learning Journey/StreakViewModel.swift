//
//  StreakViewModel.swift
//  Learning Journey
//
//  Created by yumii on 22/10/2025.
//

import Foundation
import SwiftUI
import Combine

class StreakViewModel: ObservableObject {
    @Published var goalAchieved = false
    @Published var streakData = StreakData(
        currentStreak: 0,
        totalLearnedDays: 0,
        freezesUsed: 0,
        totalFreezes: 2,
        lastLearningDate: nil
    )
    
    @Published var todayState: DayState = .default
    @Published var selectedDuration: LearningDuration = .week
    @Published var learningGoal: String = "Swift"
    
    private let freezePolicy = FreezePolicy()
    private let calendar = Calendar.current
    private let userDefaults = UserDefaults.standard
    
    enum LearningDuration: String, CaseIterable, Codable {
        case week = "Week"
        case month = "Month"
        case year = "Year"

        var freezesAllowed: Int {
            switch self {
            case .week: return 2
            case .month: return 8
            case .year: return 96
            }
        }
        
        var targetDays: Int {
            switch self {
            case .week: return 7
            case .month: return 30
            case .year: return 365
            }
        }
     }
    
    init() {
        loadData()
        checkStreakReset()
        updateTodayState()
    }
     
        var learnedButtonTextColor: Color {
            switch todayState {
            case .learned:
                return .orgMain
            case .freezed:
                return .bluee
            case .default:
                return .white
            }
        }
    
    
    
    
    
    func logAsLearned() {
            guard canLogAsLearned() else { return }
            
            todayState = .learned
            streakData.totalLearnedDays += 1
            streakData.currentStreak += 1
            streakData.lastLearningDate = Date()
            
            updateHistory(for: Date(), with: .learned)
        
            if streakData.totalLearnedDays >= selectedDuration.targetDays {
                goalAchieved = true
            } else {
                goalAchieved = false
            }
        
            saveData()
        }
    
    
    func logAsFreezed() {
            guard canLogAsFreezed() else { return }
            
            todayState = .freezed
            streakData.freezesUsed += 1
            streakData.currentStreak += 1
            streakData.lastLearningDate = Date()
            
            updateHistory(for: Date(), with: .freezed)  
            
            saveData()
        }
    
    func canLogAsLearned() -> Bool {
             return todayState == .default
        }
        
        func canLogAsFreezed() -> Bool {
            if todayState != .default { return false }
            if streakData.freezesUsed >= streakData.totalFreezes { return false }
             return true
        }
    
    func updateDuration(_ duration: LearningDuration) {
        selectedDuration = duration
        streakData.totalFreezes = duration.freezesAllowed
        saveData()
    }
    
    func updateLearningGoal(_ goal: String) {
        learningGoal = goal
        resetStreak()
        goalAchieved = false
        saveData()
        
    }
    
 
    func saveDataPublic() {
        saveData()
    }
    
    var learnedButtonColor: Color {
        switch todayState {
        case .learned:
            return .brownn
        case .freezed:
            return .darkBlue01
        case .default:
            return .orgMain 
        }
    }
    
    var learnedButtonText: String {
        switch todayState {
        case .learned:
            return "Learned\nToday"
        case .freezed:
            return "Day\nFreezed" 
        case .default:
            return "Log as\nLearned"
        }
    }
    
    var freezedButtonEnabled: Bool {
        canLogAsFreezed()
    }
    
    var freezedButtonColor: Color {
        freezedButtonEnabled ? .bluee : .darkBlue01
    }
    
    var freezeCounterText: String {
        "\(streakData.freezesUsed) out of \(streakData.totalFreezes) Freeze\(streakData.totalFreezes == 1 ? "" : "s") used"
    }
    
    var daysLearnedText: String {
        "\(streakData.totalLearnedDays) Day\(streakData.totalLearnedDays == 1 ? "" : "s") Learned"
    }
    
    var daysFreezedText: String {
        "\(streakData.freezesUsed) Day\(streakData.freezesUsed == 1 ? "" : "s") Freezed"
    }
     
    
    
    
    private func isNewDay() -> Bool {
        guard let lastDate = streakData.lastLearningDate else { return true }
        
        let now = Date()
        let components = calendar.dateComponents([.hour], from: lastDate, to: now)
        return (components.hour ?? 0) >= 0
    }
    
    private func checkStreakReset() {
        guard let lastDate = streakData.lastLearningDate else { return }
        
        let now = Date()
        let components = calendar.dateComponents([.hour], from: lastDate, to: now)
        
        if (components.hour ?? 0) > freezePolicy.streakResetHours {
            resetStreak()
        }
    }
    
    private func resetStreak() {
            streakData.currentStreak = 0
            streakData.history.removeAll()
            streakData.totalLearnedDays = 0
            streakData.freezesUsed = 0
            streakData.lastLearningDate = nil
            updateTodayState()
             saveData()
        }
    
    private func updateTodayState() {
             self.todayState = getDayState(for: Date())
        }
    
    private func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(streakData) {
            userDefaults.set(encoded, forKey: "streakData")
        }
        userDefaults.set(learningGoal, forKey: "learningGoal")
        userDefaults.set(selectedDuration.rawValue, forKey: "selectedDuration")
    }
    
    private func loadData() {
        if let savedData = userDefaults.data(forKey: "streakData"),
           let decoded = try? JSONDecoder().decode(StreakData.self, from: savedData) {
            streakData = decoded
        }
        
        if let goal = userDefaults.string(forKey: "learningGoal") {
            learningGoal = goal
        }
        
        if let durationString = userDefaults.string(forKey: "selectedDuration"),
           let duration = LearningDuration(rawValue: durationString) {
            selectedDuration = duration
            streakData.totalFreezes = duration.freezesAllowed
        }
    }
     
        func startNewGoalCycle() {
            streakData.currentStreak = 0
            streakData.totalLearnedDays = 0
            streakData.lastLearningDate = nil
            goalAchieved = false
            updateTodayState()
            saveData()  
            print("Starting new goal cycle with same goal: \(learningGoal)")
        }
    
    private func updateHistory(for date: Date, with state: DayState) {
            let startOfDay = calendar.startOfDay(for: date)
            
             if let index = streakData.history.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: startOfDay) }) {
                 streakData.history[index].state = state
            } else {
                 let newDay = LearningDay(date: startOfDay, state: state)
                streakData.history.append(newDay)
            }
        }
}



// CalendarView

extension StreakViewModel {
 
        func getDayState(for date: Date) -> DayState {
             if let day = streakData.history.first(where: { calendar.isDate($0.date, inSameDayAs: date) }) {
                 return day.state
            }
              return .default
        }
    
    func markDayAsLearned(date: Date) {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            logAsLearned()
        } else {
             print("Marked previous day as learned: \(date)")
            saveDataPublic()
        }
    }
    
    func markDayAsFreezed(date: Date) {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            logAsFreezed()
        } else {
             print("Marked previous day as freezed: \(date)")
            saveDataPublic()
        }
    }
    
    func markDayAsDefault(date: Date) {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            todayState = .default
            saveDataPublic() 
        }
    }
}
