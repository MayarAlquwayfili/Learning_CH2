//
//  ContentView.swift
//  Learning Journey
//
//  Created by yumii on 19/10/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
        
             
            
       
        
        VStack {
            
            Text ("Hello Learner")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(Color.white)
            
            Image("On")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                
        }
        .padding(.horizontal,100)
    }
 
 
    }
}
#Preview {
    ContentView()
}
