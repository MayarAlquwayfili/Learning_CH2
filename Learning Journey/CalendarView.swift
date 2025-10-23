//
//  CalendarView.swift
//  Learning Journey
//
//  Created by yumii on 21/10/2025.
//

import SwiftUI

struct CalendarView: View {
    
    @StateObject private var viewModel = StreakViewModel()
    @State private var currentDate = Date()
    @State private var showFullCalendar = false
    private let weekDays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    private let calendar = Calendar.current
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .frame(width: 365, height: 254)
                    .foregroundStyle(Color.black01)
                    .cornerRadius(13)
                    .padding(.vertical)
                headerView
                
                weeklyGridView
                    .padding(.horizontal)
            }
            
            Spacer()
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                
                HStack(spacing: 5) {
                    Button(action: {
                        showFullCalendar.toggle()
                    }) {
                        HStack(spacing: 5) {
                            Text(getCurrentMonthYear())
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.orgMain)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            goToPreviousWeek()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.orgMain)
                        }
                        
                        Button(action: {
                            goToNextWeek()
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.orgMain)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
        }
        .padding(.bottom, 200)
    }
    
    private var weeklyGridView: some View {
        VStack(spacing: -1) {
            // أيام الأسبوع
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black02)
                        .frame(width: 44, height: 44)
                }
            }
            .padding(.vertical, -20)
            
            // الأرقام مع الدوائر - الدوائر مو أزرار
            HStack(spacing: 17) {
                ForEach(getCurrentWeekRealDays(), id: \.self) { dayInfo in
                    ZStack {
                        // الدائرة الكبيرة - مجرد شكل مو زر
                        Circle()
                            .fill(getCircleColor(for: dayInfo))
                            .frame(width: 44, height: 44)
                        
                        // الرقم
                        Text(dayInfo.day)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(getTextColor(for: dayInfo))
                    }
                    .padding(.horizontal, -7)
                }
            }
        }
        .padding(.bottom, 55)
    }
    
    // MARK: - Helper Functions
    
    private func getCircleColor(for dayInfo: DayInfo) -> Color {
        let dayState = viewModel.getDayState(for: dayInfo.date)
        
        switch dayState {
        case .learned:
            return .brownn // دائرة برتقالية فاتحة
        case .freezed:
            return .darkBlue01 // دائرة زرقاء فاتحة
        case .default:
            return dayInfo.isToday ? Color.orgMain : .clear // اليوم الحالي برتقالي، الباقي شفاف
        }
    }
    
    private func getTextColor(for dayInfo: DayInfo) -> Color {
        let dayState = viewModel.getDayState(for: dayInfo.date)
        
        // إذا كان learned أو freezed، الرقم يكون أبيض
        if dayState != .default {
            return .white
        } else {
            // إذا كان default، الرقم يكون أبيض (مع دائرة شفافة) أو أبيض (مع دائرة برتقالية لليوم الحالي)
            return .white
        }
    }
    
    private func getCurrentMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    private func getCurrentWeekRealDays() -> [DayInfo] {
        var weekDays: [DayInfo] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)) else {
            return []
        }
        
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) {
                let day = formatter.string(from: date)
                let isToday = calendar.isDateInToday(date)
                weekDays.append(DayInfo(day: day, date: date, isToday: isToday))
            }
        }
        
        return weekDays
    }
    
    private func goToPreviousWeek() {
        if let newDate = calendar.date(byAdding: .weekOfYear, value: -1, to: currentDate) {
            currentDate = newDate
        }
    }
    
    private func goToNextWeek() {
        if let newDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate) {
            currentDate = newDate
        }
    }
}

struct DayInfo: Hashable {
    let day: String
    let date: Date
    let isToday: Bool
}

#Preview {
    CalendarView()
}
