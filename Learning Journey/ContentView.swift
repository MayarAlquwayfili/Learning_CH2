//
//  ContentView.swift
//  Learning Journey
//
//  Created by yumii on 19/10/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var learningGoal = ""
    @State private var selectedDuration = "Month"
     let durations = ["Week", "Month", "Year"]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                ZStack {
                    Circle()
                        .fill(Color.brownn)
                        .frame(width: 109, height: 109)
                        .glassEffect(.clear)

                    Image(systemName: "flame.fill")
                        .foregroundStyle(Color.orange)
                        .font(.system(size: 36))
                }
                .padding(.top, 90)
                .padding(.bottom, 50)

                VStack(alignment: .leading) {
                    Text("Hello Learner")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)

                    Text("This app will help you learn everyday!")
                        .font(.system(size: 17))
                        .foregroundStyle(Color.grayy)
                }
                .padding(.horizontal, -190)

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
                    
                    
                   
                    Button (action:{
                        print("Start learning")
                    }
                    
                    ) {
                        Text("Start learning")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 182, height: 48)

                    }
                    .buttonStyle(.glassProminent)
                    .tint(.orgMain)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom,56)
                    .padding(.top,223)
                    
                    
                   }
                .padding(.horizontal, 10)

            }
        }
    }
}

struct DurationButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 97, height: 48)
          
        }
        .buttonStyle(.glassProminent)
        .tint(isSelected ? .orgMain : .clear)
     }
}

#Preview {
    ContentView()
}
