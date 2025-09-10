//
//  GoalFormView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 09/09/2025.
//

import SwiftUI

struct GoalFormView: View {
    @Binding var habitText: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack {
                Text(habitText)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.blackCopy)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.yellowButton)
                    }
                    .padding(.top, 20)
                    
                })
                
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    dismiss()
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.blackCopy)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.yellowButton)
                    }
                    .padding(.top, 20)
                    
                })
                
            }
        }
    }
}

#Preview {
    GoalFormView(habitText: .constant("meditate"))
}
