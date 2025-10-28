//
//  StreakModel.swift
//  Learning Journey
//
//  Created by yumii on 22/10/2025.
//
import SwiftUI
import UIKit
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
    
    struct DayInfo: Hashable {
        let day: String
        let date: Date
        let isToday: Bool
    }
    
    //Full
    var circleSwiftUIColor: Color {
        switch self {
        case .learned: return .brownn
        case .freezed: return .darkBlue01
        case .default: return .clear
        }
    }
     
    var circleUIColor: UIColor {
        switch self {
        case .learned: return UIColor(named: "Brownn") ?? .brown
        case .freezed: return UIColor(named: "DarkBlue01") ?? .blue
        case .default: return .clear
        }
    }
    
    
    //Mini
    var textSwiftUIColor: Color {
        switch self {
        case .learned: return .orgMain
        case .freezed: return .bluee
        case .default: return .white
        }
    }
    
     var textUIColor: UIColor {
        switch self {
        case .learned: return UIColor(named: "orgMain") ?? .orange
        case .freezed: return UIColor(named: "bluee") ?? .bluee
        case .default: return .white
        }
    }
}

struct StreakData: Codable {
    var currentStreak: Int
    var totalLearnedDays: Int
    var freezesUsed: Int
    var totalFreezes: Int
    var lastLearningDate: Date?
    var history: [LearningDay] = []  
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
