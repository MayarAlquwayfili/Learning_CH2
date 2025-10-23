//
//  StreakModel.swift
//  Learning Journey
//
//  Created by yumii on 22/10/2025.
//

import Foundation

struct LearningDay: Identifiable, Codable {
    var id = UUID()
    let date: Date
    var state: DayState
}

enum DayState: String, Codable {
    case `default`
    case learned
    case freezed
}

struct StreakData: Codable {
    var currentStreak: Int
    var totalLearnedDays: Int
    var freezesUsed: Int
    var totalFreezes: Int
    var lastLearningDate: Date?
}

struct FreezePolicy: Codable {
    let freezesPerWeek: Int
    let freezesPerMonth: Int
    let freezesPerYear: Int
    let streakResetHours: Int
    

    init(
        freezesPerWeek: Int = 2,
        freezesPerMonth: Int = 8,
        freezesPerYear: Int = 96,
        streakResetHours: Int = 32
    ) {
        self.freezesPerWeek = freezesPerWeek
        self.freezesPerMonth = freezesPerMonth
        self.freezesPerYear = freezesPerYear
        self.streakResetHours = streakResetHours
    }
}
