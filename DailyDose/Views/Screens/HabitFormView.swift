//
//  HabitFormView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 03/06/2025.
//

import SwiftUI

struct HabitFormView: View {
    @State private var habitTitle: String = ""
    @State private var habitGoal: Int = 1
    @State private var habitPeriodicity: HabitPeriodicity = .daily(.days(5))
    @State private var unit: Unit = .minutes(0)
    @Binding var habits: [Habit]
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack {
                titleView
                periodicityView
                reccurenceAndGoalView
                Spacer()
            }
            .padding()
        }
    }
    
    
    //MARK: Title's View
    var titleView: some View {
        TextField("Title...", text: $habitTitle)
            .background(Color.clear)
            .foregroundColor(.blackCopy)
            .font(.custom("Syne-SemiBold", size: 40))
            .padding(.bottom, 20)
    }
    
    //MARK: Periodicity's View
    var periodicityView: some View {
        HStack {
            PeriodicityButton(
                title: "Daily",
                type: .daily,
                current: habitPeriodicity.kind,
                action: {
                    habitPeriodicity = .daily(unit)
                })
            
            PeriodicityButton(
                title: "Weekly",
                type: .weekly,
                current: habitPeriodicity.kind,
                action: {
                    habitPeriodicity = .weekly(unit)
                })
            
            PeriodicityButton(
                title: "Challenge",
                type: .challenge,
                current: habitPeriodicity.kind,
                action: {
                    habitPeriodicity = .challenge(unit)
                })
        }
        .padding(.bottom, 20)
    }
    
    //MARK: Recurrence and goal's View
    var reccurenceAndGoalView: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(.blackCopy)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .cornerRadius(50)
                    .opacity(0.1)
                
                VStack(alignment: .leading) {
                    Text("Track your \n progress in...")
                        .font(.custom("Syne-SemiBold", size: 20))
                    
                    RecurrenceCheckbox(
                        title: "Minutes",
                        action: {
                            unit = .minutes(habitGoal)
                        }
                    )
                    
                    RecurrenceCheckbox(
                        title: "Hours",
                        action: {
                            unit = .hours(habitGoal)
                        }
                    )
                    Spacer()
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                .frame(height: 250)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Rectangle()
                .fill(.blackCopy)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .cornerRadius(50)
                .opacity(0.1)
        }
    }
}


#Preview {
    HabitFormView(habits: .constant([Habit(title: "Learn EN words", progress: 0, objective: 5, periodicity: .daily(.custom(5, "words")))]))
}





//HStack {
//                    Button(action: {
//                        habitGoal -= 1
//                    }, label: {
//                        Image(systemName: "minus")
//                            .font(.system(size: 25))
//                            .foregroundColor(.blackCopy)
//                            .frame(width: 60, height: 60)
//                            .background(Circle().fill(Color.yellowButton))
//                            .padding(.horizontal, 20)
//                    })
//
//                    Text("\(habitGoal)")
//                        .frame(width: 150, height: 150)
//                        .background(Color.clear)
//                        .foregroundColor(Color.yellowButton)
//                        .font(.custom("Syne-ExtraBold", size: 45))
//                        .padding(.bottom, 20)
//
//                    Button(action: {
//                        habitGoal += 1
//                    }, label: {
//                        Image(systemName: "plus")
//                            .font(.system(size: 25))
//                            .foregroundColor(.blackCopy)
//                            .frame(width: 60, height: 60)
//                            .background(Circle().fill(Color.yellowButton))
//                            .padding(.horizontal, 20)
//                    })
//
//                }
