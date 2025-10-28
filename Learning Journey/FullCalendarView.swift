import SwiftUI
import FSCalendar
 
struct FullCalendarView: View {
    @ObservedObject var viewModel: StreakViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            FSCalendarBridge(viewModel: viewModel)
                .navigationTitle("All activities")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            dismiss() })
                        {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.white)
                        }
                        
                    }
                    
                }
                .ignoresSafeArea(edges: .bottom)
        }
    }
}
 
#Preview {
    FullCalendarView(viewModel: StreakViewModel())
}
