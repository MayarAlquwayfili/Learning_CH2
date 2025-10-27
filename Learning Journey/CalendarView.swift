//
//  CalendarView.swift
//  Learning Journey
//
//  Created by yumii on 21/10/2025.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var viewModel: StreakViewModel
    @Binding var showMonthYearPicker: Bool
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
                    
                    if showMonthYearPicker {
                        MonthYearPicker(currentDate: $currentDate)
                            .padding(.top, 40)
                        
                            .transition(.opacity.combined(with: .scale(scale: 0.95)))
                    } else {
                        weeklyGridView
                            .padding(.horizontal)
                            .transition(.opacity.combined(with: .scale(scale: 1.0)))
                    }
                    
                    Spacer()
                }
                
            }
        }
 
    
    struct MonthYearPicker: View {
        @Binding var currentDate: Date
        
        @State private var selectedMonth: Int
        @State private var selectedYear: Int
        
        private let calendar = Calendar.current
        private let months = Calendar.current.monthSymbols
        private let years: [Int] = Array(2010...2030)
        
        init(currentDate: Binding<Date>) {
            self._currentDate = currentDate
            let components = Calendar.current.dateComponents([.month, .year], from: currentDate.wrappedValue)
 
            self._selectedMonth = State(initialValue: components.month ?? 1)
            self._selectedYear = State(initialValue: components.year ?? 2025)
        }
        
        var body: some View {
            HStack(spacing: 0) {

                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(months[month - 1]).tag(month)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 180)
 

                Picker("Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text(String(year)).tag(year)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 120)
                .clipped()
            }
            .frame(height: 180)
            .onChange(of: selectedMonth) { updateDate() }
            .onChange(of: selectedYear) { updateDate() }
        }
        
        
        func updateDate() {
            var components = calendar.dateComponents([.day, .hour, .minute], from: currentDate)
            components.month = selectedMonth
            components.year = selectedYear
            
             if let newDate = calendar.date(from: components) {
                currentDate = newDate
            }
        }
    }
    
    
    
    
    //Header
    
    private var headerView: some View {
            VStack(spacing: 16) {
                HStack {
 
                     Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showMonthYearPicker.toggle()
                        }
                    }) {
                        HStack(spacing: 5) {
                            Text(getCurrentMonthYear())
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            
                             Image(systemName: showMonthYearPicker ? "chevron.down" : "chevron.right")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.orgMain)
                        }
                    }
                    
                    Spacer()
                    
                     if !showMonthYearPicker {
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
        VStack(spacing: 5) {
             HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black02)
                        .frame(width: 44, height: 44)
                        .padding(.horizontal, -2)
                }
            }
            .padding(.vertical, -30)
            
            
             HStack(spacing: 17) {
                ForEach(getCurrentWeekRealDays(), id: \.self) { dayInfo in
                    ZStack {
                         Circle()
                            .fill(getCircleColor(for: dayInfo))
                            .frame(width: 44, height: 44)
                        
                         Text(dayInfo.day)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(getTextColor(for: dayInfo))
                    }
                    .padding(.horizontal, -6)
                }
            }
        }
        .padding(.bottom, 55)
    }
    
 
    
    
    private func getCircleColor(for dayInfo: DayInfo) -> Color {
            let dayState = viewModel.getDayState(for: dayInfo.date)
             
            if dayState == .default {
                return dayInfo.isToday ? Color.orgMain : .clear
            }
             return dayState.circleSwiftUIColor
        }
 
    private func getTextColor(for dayInfo: DayInfo) -> Color {
            let dayState = viewModel.getDayState(for: dayInfo.date)
             
            if dayState == .default {
                return .white
            }
            return dayState.textSwiftUIColor
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
    CalendarView(viewModel: StreakViewModel(), showMonthYearPicker: .constant(false))
}
