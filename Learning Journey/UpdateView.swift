//
//  UpdateView.swift
//  Learning Journey
//
//  Created by yumii on 23/10/2025.
//

import SwiftUI

struct UpdateView: View {
    @Binding var isPresented: Bool
    let onUpdate: () -> Void
    
    var body: some View {
        
        VStack{
            
            VStack (alignment: .leading, spacing: 15){
                Text("Update Learning goal")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.top, 20)
                
                Text("If you update now, your streak \n will start over.")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.grayy03)
                
            }
            
            HStack (spacing: -8){
                
                Button (action:{
                    isPresented = false
                }
                        
                ) {
                    Text("Dismiss")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 110, height: 40)
                    
                }
                .buttonStyle(.glassProminent)
                .tint(.grayy04)
                .frame(maxWidth: .infinity)
                
                Button (action:{
                    onUpdate()
                    isPresented = false
                }
                        
                ) {
                    Text("Update")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 110, height: 40)
                    
                }
                .buttonStyle(.glassProminent)
                .tint(.orgMain)
                .frame(maxWidth: .infinity)
                
            }
            .padding(.top,15)
            .padding(.bottom,10)
            
            
        }
        .frame(width: 300, height: 190)
        .background(Color.black)
        .cornerRadius(35)
        .shadow(color: .white.opacity(0.4), radius: 10)
        .padding(.vertical)
    }
}

#Preview {
    UpdateView(
        isPresented: .constant(true),
        onUpdate: { }
    )
}
