//
//  PeriodicityButton.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 24/06/2025.
//

import SwiftUI

struct PeriodicityButton: View {
    let title: String
    let type: HabitPeriodicity.Kind
    let current: HabitPeriodicity.Kind
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(current == type ? .custom("Syne-SemiBold", size: 18) : .custom("Syne-SemiBold", size: 14))
                .fontWeight(.bold)
                .foregroundColor(.yellowButton)
                .frame(width: 120, height: 60)
                .background(current == type ? Color.clear : Color.blackCopy)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(current == type ? .yellowButton : .blackCopy, lineWidth: 2)
                )
                .animation(.easeInOut(duration: 0.1), value: current)
        }
    }
}

#Preview {
    PeriodicityButton(title: "Daily", type: .daily, current: .daily, action: {})
}
