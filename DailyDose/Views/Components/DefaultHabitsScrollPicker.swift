//
//  DefaultHabitsScrollPicker.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 26/11/2025.
//

import SwiftUI

struct DefaultHabitsScrollPicker: View {
    @StateObject private var defaultHabitVM = DefaultHabitScrollVM()
    @Binding var selectedHabit: DefaultHabit?
    var onHabitSelected: (DefaultHabit) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(defaultHabitVM.defaultHabits) { habit in
                    ZStack {
                        Image(habit.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .onTapGesture {
                                onHabitSelected(habit)
                            }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    return DefaultHabitsScrollPicker(selectedHabit: .constant(nil), onHabitSelected: { _ in })
}
