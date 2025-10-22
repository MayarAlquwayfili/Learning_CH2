//
//  CalendarView.swift
//  Learning Journey
//
//  Created by yumii on 21/10/2025.
//
//

import SwiftUI

struct CalendarView: View {
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
             HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black02)
 
                }
                .padding(.horizontal, 6)

             }
             .padding(.vertical, -20)

            
             HStack(spacing: 17) {
                ForEach(getCurrentWeekRealDays(), id: \.self) { dayInfo in
                    ZStack {
                        Circle()
                            .fill(dayInfo.isToday ? Color.orange : Color.clear)
                            .frame(width: 44, height: 44)
                        
                        Text(dayInfo.day)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, -7)
                 }
            }
 
        }
        .padding(.bottom, 55)

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
                weekDays.append(DayInfo(day: day, isToday: isToday))
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
    let isToday: Bool
}

#Preview {
    CalendarView()
}
