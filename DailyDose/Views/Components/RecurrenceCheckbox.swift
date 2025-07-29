//
//  PeriodicityCell.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 19/06/2025.
//

import SwiftUI

struct RecurrenceCheckbox: View {
    let title: String
    let action: () -> Void
    @Binding var isRecurrenceCheckboxSelected: Bool
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isRecurrenceCheckboxSelected {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.blackCopy)
                        .cornerRadius(50)
                        .frame(height: 40)
                } else {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.yellowButton)
                        .cornerRadius(50)
                        .frame(height: 40)
                }
                
                HStack {
                    if isRecurrenceCheckboxSelected {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.yellowButton)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.blackCopy)
                            
                            Image(systemName: "checkmark")
                                .foregroundColor(.blackCopy)
                        }
                        
                    } else {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blackCopy, lineWidth: 1)
                            .frame(width: 20, height: 20)
                    }
                    
                    if isRecurrenceCheckboxSelected {
                        Text(title)
                            .font(.system(size: 14))
                            .foregroundColor(Color.yellowButton)
                            .fontWeight(.bold)
                            .cornerRadius(50)
                    } else {
                        Text(title)
                            .font(.system(size: 14))
                            .foregroundColor(Color.blackCopy)
                            .fontWeight(.bold)
                            .cornerRadius(50)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    RecurrenceCheckbox(title: "Minutes", action: {}, isRecurrenceCheckboxSelected: .constant(false))
}
