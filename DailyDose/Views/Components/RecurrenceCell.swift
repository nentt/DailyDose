//
//  PeriodicityCell.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 19/06/2025.
//

import SwiftUI

struct RecurrenceCell: View {
    let title: String
    let action: () -> Void
    @Binding var isRecurrenceCheckboxSelected: Bool
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.custom("Syne-Regular", size: 22))
                    .foregroundColor(.blackCopy.opacity(0.5))
                    .cornerRadius(50)
                    .padding(.vertical, 25)
                    .padding(.horizontal, 40)
                    .background(
                        Capsule()
                            .fill(Color.white)
                    )
                    
                Spacer()
            }
        }
    }
}

#Preview {
    RecurrenceCell(title: "Minutes", action: {}, isRecurrenceCheckboxSelected: .constant(false))
}
