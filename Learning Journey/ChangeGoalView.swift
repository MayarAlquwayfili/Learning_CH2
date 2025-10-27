//
//  ChangeGoalView.swift
//  Learning Journey
//
//  Created by yumii on 23/10/2025.
//

import SwiftUI

struct ChangeGoalView: View {
    @State private var learningGoal = ""
    @State private var selectedDuration = "Month"
    let durations = ["Week", "Month", "Year"]
    
    var body: some View {
        
         VStack{
            
            Text("Learning Goal")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.white)
            
            
            VStack(alignment: .leading) {
                Text("I want to learn")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.white)
                
                TextField("Swift", text: $learningGoal)
                    .font(.system(size: 17))
                
                    .onSubmit {
                        print("learningGoal")
                    }
                
                Rectangle()
                    .frame(width:361 ,height: 1)
                    .foregroundColor(.gblack)
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 37)
            
            
            
            
            VStack(alignment: .leading) {
                Text("I want to learn it in a")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.white)
                    .padding(.top, 37)
                
                HStack(spacing: 8) {
                    ForEach(durations, id: \.self) { duration in
                        DurationButton(
                            title: duration,
                            isSelected: selectedDuration == duration
                        ) {
                            selectedDuration = duration
                        }
                    }
                    Spacer()
                }
                
                
                
            }
        }
    }
}

#Preview {
    ChangeGoalView()
}
