//
//  CurrentDayView.swift
//  Learning Journey
//
//  Created by yumii on 20/10/2025.
//

import SwiftUI
 
struct CurrentDayView: View {
    @State private var showFullCalendar = false
    @State private var showMonthYearPicker = false
    @ObservedObject var viewModel: StreakViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isGoalCompleted = false
    @State private var showUpdateGoalSheet = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                headerView
                    .padding(.top,40)
                    .padding(.horizontal,40)
                
                CalendarView(viewModel: viewModel, showMonthYearPicker: $showMonthYearPicker)
                
                if !isGoalCompleted && !showMonthYearPicker {
                    LearningSwiftView
                        .padding(.vertical,-206)
                        .transition(.opacity)
                } else if showMonthYearPicker {
                 
                }
                
                if isGoalCompleted {
                    GoalCompletedView(
                        onSetNewGoal: { dismiss() },
                        onRestartGoal: {
                            viewModel.startNewGoalCycle()
                            isGoalCompleted = false
                        }
                    )
                 } else {
                    LearneButtonView
                        .transition(.opacity)
                }
            }
        }
        .fullScreenCover(isPresented: $showFullCalendar) {
            FullCalendarView(viewModel: viewModel)
        }
        .animation(.easeInOut(duration: 0.3), value: showMonthYearPicker)
        .animation(.easeInOut, value: isGoalCompleted)
        .sheet(isPresented: $showUpdateGoalSheet) {
            UpdateGoalView(viewModel: viewModel)
            
        .onReceive(viewModel.$goalAchieved) { achieved in
            self.isGoalCompleted = achieved
        }
        }
        .onAppear {
        }
    }
    
    
    //Header View
     var headerView: some View {
         HStack {
            Text("Activity")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
            
            Spacer()
            
            HStack (spacing: 12){
                Button (action:{
                    showFullCalendar = true })
                {
                    ZStack{
                        Image(systemName: "calendar")
                            .font(.system(size: 24))
                            .foregroundStyle(.grayy01)
                        
                    }
                }
                .buttonStyle(.glassProminent)
                .tint(.black03)
                
                Button (action:{
                    showUpdateGoalSheet = true })
                {
                    Image(systemName: "pencil.and.outline")
                        .font(.system(size: 24))
                        .foregroundStyle(.grayy01)
                }
                .buttonStyle(.glassProminent)
                .tint(.black03)
                 
            }
        }
    }
    
 
    //Learning View
     var LearningSwiftView: some View {
        VStack(spacing: 10) {
            
            Rectangle()
                .frame(width:332 ,height: 1)
                .foregroundColor(.black02)
                .padding(.top,10)
            
            Text("Learning \(viewModel.learningGoal)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 48)
            
            
            HStack(spacing: 13) {
                
                // Days Learned
                ZStack {
                    Rectangle()
                        .fill(Color.brownn01)
                        .frame(width: 160, height: 69)
                        .cornerRadius(100)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(Color.orange)
                            .font(.system(size: 15, weight: .bold))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(viewModel.streakData.totalLearnedDays)")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                            Text(viewModel.daysLearnedText)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                
                
                // Day Freezed
                ZStack {
                    Rectangle()
                        .fill(Color.darkBlue01)
                        .frame(width: 160, height: 69)
                        .cornerRadius(100)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "cube.fill")
                            .foregroundStyle(Color.bluee)
                            .font(.system(size: 15, weight: .bold))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(viewModel.streakData.freezesUsed)")                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                            Text(viewModel.daysFreezedText)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.white)
                            
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
        }
        .padding(.vertical,60)
        
    }
    
    
    //Log Buttons
    var LearneButtonView: some View {
        VStack (spacing: 30){
            
            // Log as Learned Button
            ZStack {
                Button (action:{
                    viewModel.logAsLearned() })
                {
                    Text(viewModel.learnedButtonText)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(viewModel.learnedButtonTextColor)
                        .frame(width: 274, height: 274)
                        .multilineTextAlignment(.center)
                }
                .buttonStyle(.glassProminent)
                .glassEffect(.clear)
                .tint(viewModel.learnedButtonColor)
                .disabled(!viewModel.canLogAsLearned())
            }
            
            // Log as Freezed Button
            ZStack {
                Button (action:{
                    viewModel.logAsFreezed() })
                {
                    Text("Log as Freezed")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 274, height: 48)
                    
                }
                .buttonStyle(.glassProminent)
                .tint(viewModel.freezedButtonColor)
                .disabled(!viewModel.freezedButtonEnabled)
            }
            Text(viewModel.freezeCounterText)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.black04)
                .padding(.vertical, -17)
            
        }
    }
}



#Preview {
    CurrentDayView(viewModel: StreakViewModel())
  }
