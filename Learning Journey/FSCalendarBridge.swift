//
//  FSCalendarBridge.swift
//  Learning Journey
//
//  Created by yumii on 28/10/2025.
//

import SwiftUI
import FSCalendar
  
struct FSCalendarBridge: UIViewRepresentable {
    @ObservedObject var viewModel: StreakViewModel
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        
        calendar.allowsSelection = false
        calendar.pagingEnabled = false
        calendar.scrollDirection = .vertical
        
        calendar.scope = .month
        
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 17, weight: .semibold)
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.headerTitleAlignment = .left
        calendar.appearance.headerTitleOffset = CGPoint(x: 20, y: 0)
        calendar.appearance.headerSeparatorColor = UIColor.clear
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .white
        
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.todayColor = UIColor(named: "orgMain") ?? .orgMain
        
        
        calendar.appearance.titleFont = .systemFont(ofSize: 24, weight: .medium)
        calendar.rowHeight = 44
        calendar.appearance.weekdayFont = .systemFont(ofSize: 13, weight: .semibold)
        calendar.appearance.weekdayTextColor = UIColor(named: "black02") ?? .black02
        
        calendar.appearance.selectionColor = .clear
        calendar.placeholderType = .none
        
        return calendar
    }
    
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
     
    
    class Coordinator: NSObject, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
        var viewModel: StreakViewModel
        init(viewModel: StreakViewModel) {
            self.viewModel = viewModel   }
        
        //Circle Color
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
             let state = viewModel.getDayState(for: date)
            
            switch state {
            case .learned:
                return UIColor(named: "brownn") ?? .brownn
            case .freezed:
                return UIColor(named: "darkBlue01") ?? .darkBlue01
            case .default:
                if Calendar.current.isDateInToday(date) {
                    return UIColor(named: "orgMain") ?? .orgMain
                }
                return .clear
            }
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
             if calendar.scope == .month && !Calendar.current.isDate(date, equalTo: calendar.currentPage, toGranularity: .month) {
                return .clear
            }
            let dayState = viewModel.getDayState(for: date)
            if dayState == .default {
                return .white
            }
            return dayState.textUIColor
        }
    }
}
 
