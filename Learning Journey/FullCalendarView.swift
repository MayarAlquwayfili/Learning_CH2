import SwiftUI
import FSCalendar
 
struct FullCalendarView: View {
    @ObservedObject var viewModel: StreakViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            FSCalendarViewRepresentable(viewModel: viewModel)
                .navigationTitle("All activities")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.white)
                        }
                    }
                }
               .ignoresSafeArea(edges: .bottom)
        }
     }
}
 

struct FSCalendarViewRepresentable: UIViewRepresentable {
    
    @ObservedObject var viewModel: StreakViewModel
    
     func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
         
        calendar.allowsSelection = false
        calendar.pagingEnabled = false
        calendar.rowHeight = 44
 
        calendar.scope = .month
        
        calendar.scrollDirection = .vertical
         
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 17, weight: .semibold)
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.headerTitleAlignment = .left
        calendar.appearance.headerSeparatorColor = .black02
         
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .white
 
        let placeholderColor = UIColor(named: "black02") ?? .gray
        calendar.appearance.titlePlaceholderColor = placeholderColor.withAlphaComponent(0.5)
        
         calendar.appearance.titleTodayColor = .white
         calendar.appearance.todayColor = UIColor(named: "orgMain") ?? .orange
         calendar.appearance.selectionColor = .clear
         
 
         calendar.appearance.titleFont = .systemFont(ofSize: 24, weight: .medium)
         calendar.appearance.weekdayFont = .systemFont(ofSize: 13, weight: .semibold)
         calendar.appearance.weekdayTextColor = UIColor(named: "black02") ?? .white

         
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
            self.viewModel = viewModel
        }

 
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
                    
                    let state = viewModel.getDayState(for: date)
                    
                    switch state {
                    case .learned:
                        return UIColor(named: "brownn") ?? .brown
                    case .freezed:
                        return UIColor(named: "darkBlue01") ?? .blue
                    case .default:
                        if Calendar.current.isDateInToday(date) {
                            return UIColor(named: "orgMain") ?? .orange
                        }
                        return .clear
                    }
                }
        
         func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
                    
                    let dayState = viewModel.getDayState(for: date)
                     
                     if calendar.scope == .month && !Calendar.current.isDate(date, equalTo: calendar.currentPage, toGranularity: .month) {
                        let placeholderColor = UIColor(named: "black02") ?? .gray
                        return placeholderColor.withAlphaComponent(0.5)
                    }
                      if dayState == .default {
                        return .white
                    }
                      return dayState.textUIColor
                }
    }
}
 
#Preview {
    FullCalendarView(viewModel: StreakViewModel())
}
