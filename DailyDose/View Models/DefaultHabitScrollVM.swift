//
//  DefaultHabitScrollVM.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 26/11/2025.
//

import Foundation

class DefaultHabitScrollVM: ObservableObject {
    @Published var defaultHabits: [DefaultHabit] = [
        DefaultHabit(title: "Run", image: "running"),
        DefaultHabit(title: "Stop sugar", image: "stop sugar"),
        DefaultHabit(title: "Eat proteins", image: "protein"),
        DefaultHabit(title: "Drink water", image: "drink water"),
        DefaultHabit(title: "Do Pilates", image: "pilates"),
        DefaultHabit(title: "Stretch", image: "stretch"),
        DefaultHabit(title: "Hit the gym", image: "workout")
    ]
}
