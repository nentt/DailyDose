//
//  PeriodicityCell.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 19/06/2025.
//

import SwiftUI

struct UnitCell: View {
    let title: String
    let action: () -> Void
    let isUnitCellSelected: Bool
    var backgroundColor: Color = .white
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.custom("Syne-Regular", size: 20))
                    .foregroundColor(.blackCopy.opacity(0.5))
                    .cornerRadius(50)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .fill(isUnitCellSelected ? Color.yellowButton : backgroundColor)
                    )
                    
            }
        }
    }
}

#Preview {
    UnitCell(title: "Minutes", action: {}, isUnitCellSelected: false)
        .background(Color.mauveBackground)
}
