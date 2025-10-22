//
//  CurrentDayView.swift
//  Learning Journey
//
//  Created by yumii on 20/10/2025.
//

import SwiftUI


struct CurrentDayView: View {
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                    .padding(.top,40)
                    .padding(.horizontal,40)
                
                CalendarView()
                
                LearningSwiftView
                    .padding(.top,20)
                        
            Spacer()
                
            }
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
                    print("Calendar")
                }
                        
                ) {
                    ZStack{
                        Image(systemName: "calendar")
                            .font(.system(size: 24))
                            .foregroundStyle(.grayy01)
                        
                    }
                }
                .buttonStyle(.glassProminent)
                .tint(.black03)
                
                Button (action:{
                    print("Calendar")
                }
                        
                ) {
                    Image(systemName: "pencil.and.outline")
                        .font(.system(size: 24))
                        .foregroundStyle(.grayy01)
                }
                .buttonStyle(.glassProminent)
                .tint(.black03)
                
                
            }
            
        }
        
        
    }
    
    
    
    //Learning Swift View

    var LearningSwiftView: some View {
        VStack(spacing: 16) {
            Text("Learning Swift")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 40)
            
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
                            Text("3")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                            Text("Days Learned")
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
                            Text("1")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(Color.white)
                            
                            Text("Day Freezed")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
    }
}

         
#Preview {
    CurrentDayView()
}
