//
//  HabitSummarySheet.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 27/10/2025.
//

import SwiftUI

struct HabitSummarySheet: View {
    let customHabitText: String
    let selectedDefaultHabit: DefaultHabit?
    let goalNumber: Int
    let selectedUnit: String
    let recurrence: String
    let onCreateHabit: (Habit) -> Void
    var habitText: String {
        if !customHabitText.isEmpty {
            return customHabitText.lowercased()
        } else {
            return selectedDefaultHabit?.title.lowercased() ?? ""
        }
    }
    @State private var selectedUserImage: UIImage? = nil

    var habitImage: HabitImage {
        if let userImage = selectedUserImage {
            return .user(userImage)
        } else if let defaultHabit = selectedDefaultHabit {
            return .asset(defaultHabit.image)
        } else {
            return .none
        }
    }
    
    @Environment (\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            Color.yellowButton.ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                Text("You did it!")
                    .font(.custom("Syne-SemiBold", size: 22))
                    .foregroundColor(.blackCopy)
                    .padding(.bottom, 10)
                
                Text("Now check in—does it feel exciting, light, and doable?")
                    .font(.custom("Syne-medium", size: 17))
                    .foregroundColor(.blackCopy)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                
                Text("I will \(habitText), \(goalNumber.roundedWithAbbreviations) \(goalNumber.pluralizedUnit(selectedUnit)), \(recurrence == "challenge" ? "as a growth challenge" : recurrence).")
                    .font(.custom("Syne-ExtraBold", size: 19))
                    .foregroundColor(.blackCopy)
                
                
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                Spacer()
                
                Button(action: {
                    let unit: Unit
                        switch selectedUnit.lowercased() {
                        case "minutes":
                            unit = .minutes(goalNumber)
                        case "hours":
                            unit = .hours(goalNumber)
                        case "days":
                            unit = .days(goalNumber)
                        case "months":
                            unit = .months(goalNumber)
                        case "times":
                            unit = .times(goalNumber)
                        default:
                            unit = .custom(goalNumber, selectedUnit)
                        }
                    
                    let periodicity: HabitPeriodicity
                        switch recurrence {
                        case "daily":
                            periodicity = .daily(unit)
                        case "weekly":
                            periodicity = .weekly(unit)
                        case "monthly":
                            periodicity = .monthly(unit)
                        case "challenge":
                            periodicity = .challenge(unit)
                        default:
                            periodicity = .daily(unit)
                        }
                    
                    let newHabit = Habit(
                            title: habitText,
                            progress: 0,
                            objective: goalNumber,
                            periodicity: periodicity, 
                            unit: unit,
                            image: habitImage
                        )
                    
                    onCreateHabit(newHabit)
                                        
                }, label: {
                    Text("CREATE HABIT")
                        .font(.custom("Syne-SemiBold", size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(.blackCopy)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(Color.yellowButton)
                        .cornerRadius(50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.blackCopy, lineWidth: 3)
                        }
                    
                })
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
            }
            .padding()
        }
    }
}

#Preview {
    HabitSummarySheet(customHabitText: "Practice english", selectedDefaultHabit: DefaultHabit(title: "Run", image: "run"), goalNumber: 2, selectedUnit: "hours", recurrence: "challenge", onCreateHabit: { _ in })
}
