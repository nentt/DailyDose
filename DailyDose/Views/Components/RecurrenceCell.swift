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
    @Binding var isRecurrenceCellSelected: Bool
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.custom("Syne-Regular", size: 22))
                    .foregroundColor(.blackCopy.opacity(0.5))
                    .cornerRadius(50)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .background(
                        Capsule()
                            .fill(Color.white)
                    )
                    
            }
        }
    }
}

#Preview {
    RecurrenceCell(title: "Minutes", action: {}, isRecurrenceCellSelected: .constant(false))
        .background(Color.mauveBackground)
}
