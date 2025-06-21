//
//  HabitView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 02/06/2025.
//

import SwiftUI

struct HabitCell: View {
    let habit: Habit
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "circle")
                    .font(.system(size: 35, weight: .thin))
                    .multilineTextAlignment(.leading)
                Text(habit.title)
                    .font(.custom("Syne-SemiBold", size: 19))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            Text(habit.periodicity.description)
                .font(.custom("Syne-Regular", size: 14))
                .foregroundColor(.blackCopy.opacity(0.8))
        }
        .foregroundStyle(.blackCopy)
        .padding(10)
        .frame(width: 180, height: 90)
        .background(.yellowButton)
        .cornerRadius(15)
    }
}

#Preview {
    HabitCell(habit: Habit(title: "pilates", progress: 6, objective: 2, periodicity: .weekly(.hours(2))))
}
