//
//  GoalCompletedView.swift
//  Learning Journey
//
//  Created by yumii on 23/10/2025.
//

import SwiftUI

struct GoalCompletedView: View {
    let onSetNewGoal: () -> Void
    let onRestartGoal: () -> Void
    
    var body: some View {
        
        ZStack {
                    Color.black.ignoresSafeArea()
            
            VStack(spacing: 16) {
            Spacer()
            Image(systemName: "hands.and.sparkles.fill")
                .font(.system(size: 40, weight: .thin))
                .foregroundStyle(.orgMain)
            
            Text("Well done!")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
            
            Text("Goal completed! start learning again or set new learning goal")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button (action:{
                onSetNewGoal()
            }
                    
            ) {
                Text("Set new learning goal")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 246, height: 48)
                
                
            }
            .buttonStyle(.glassProminent)
            .tint(.orgMain)
            .frame(maxWidth: .infinity)
            .padding(.bottom,24)
            .padding(.top,118)
            
            
            Button(action: {
                onRestartGoal()
            }) {
                Text("Set same learning goal and duration")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.orgMain)
            }
            .padding(.bottom, 50)
            
            
        }
    }
}
}

#Preview {
    GoalCompletedView(
            onSetNewGoal: { print("Preview: Set New Goal") },
            onRestartGoal: { print("Preview: Restart Goal") })
}
