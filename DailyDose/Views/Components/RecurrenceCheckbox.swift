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
            HStack {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(Color.blackCopy)
                    .fontWeight(.bold)
                    .cornerRadius(50)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .fill(Color.white)
                    )
                    .overlay(
                        Capsule()
                            .stroke(Color.blackCopy.opacity(0.2), lineWidth: 0.5)
                    )
                Spacer()
            }
        }
    }
}

#Preview {
    RecurrenceCheckbox(title: "Minutes", action: {}, isRecurrenceCheckboxSelected: .constant(false))
}
