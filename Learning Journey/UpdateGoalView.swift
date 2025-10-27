//
//  UpdateGoalView.swift
//  Learning Journey
//
//  Created by yumii on 26/10/2025.
//

import SwiftUI



struct UpdateGoalView: View {
    @ObservedObject var viewModel: StreakViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showUpdateConfirmAlert = false
    @State private var tempLearningGoal: String
    @State private var tempSelectedDuration: StreakViewModel.LearningDuration
    init(viewModel: StreakViewModel) {
        self.viewModel = viewModel
        self._tempLearningGoal = State(initialValue: viewModel.learningGoal)
        self._tempSelectedDuration = State(initialValue: viewModel.selectedDuration)
    }
    var body: some View {
            NavigationStack {
                ZStack {
                    
                    VStack(spacing: 40) {
                        
                         VStack(alignment: .leading) {
                            Text("I want to learn")
                                .font(.system(size: 22))
                                .foregroundStyle(Color.white)

                             TextField("Enter your goal", text: $tempLearningGoal)
                                .font(.system(size: 17))
                                .foregroundStyle(.white)
                                .tint(.orgMain)

                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.black02)
                        }

                         VStack(alignment: .leading) {
                            Text("I want to learn it in a")
                                .font(.system(size: 22))
                                .foregroundStyle(Color.white)

                            HStack(spacing: 8) {
                                ForEach(StreakViewModel.LearningDuration.allCases, id: \.self) { duration in
                                    DurationButton(
                                        title: duration.rawValue,
                                         isSelected: tempSelectedDuration == duration
                                    ) {
                                        tempSelectedDuration = duration
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.top, 30)

                     if showUpdateConfirmAlert {
                        Color.black.opacity(0.7).ignoresSafeArea()
                            .onTapGesture { showUpdateConfirmAlert = false }
                        
                        UpdateView(
                            isPresented: $showUpdateConfirmAlert,
                            onUpdate: {
                                viewModel.updateLearningGoal(tempLearningGoal)
                                viewModel.updateDuration(tempSelectedDuration)
 
                                 dismiss()
                            }
                        )
                        .frame(width: 300, height: 184)
                        .background(Color.black01)
                        .cornerRadius(20)
                    }
                }
                .navigationTitle("Learning Goal")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                     ToolbarItem(placement: .cancellationAction) {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                        }
                    }
                     ToolbarItem(placement: .confirmationAction) {
                        Button {
                             showUpdateConfirmAlert = true
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 17))
                                .foregroundStyle(.white)
                            
                        }
                        .buttonStyle(.glassProminent)
                        .tint(.orgMain)
                         }
                    }
                }
                 .animation(.easeInOut, value: showUpdateConfirmAlert)
            }
        }

     #Preview {
        UpdateGoalView(viewModel: StreakViewModel())
    }
