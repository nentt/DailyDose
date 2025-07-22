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
    @State private var isTitleConfirmed = false
    @State private var isShowingCustomRecurrenceSheet = false
    @State private var customRecurrenceUnitsList: [String] = []
    @Binding var habits: [Habit]
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack {
                titleView
                habitName
                periodicityView
                reccurenceAndGoalView
                Spacer()
            }
            .padding()
            .overlay(alignment: .bottom) {
                CustomRecurrenceSheet(
                    customUnitList: $customRecurrenceUnitsList,
                    selectedCustomUnit: $unit
                )
                .offset(y: isShowingCustomRecurrenceSheet ? 0 : UIScreen.main.bounds.height)
            }
        }
    }
    
    //MARK: Title's View
    var titleView: some View {
        VStack {
            Text("Habits aren’t goals")
                .font(.custom("Syne-SemiBold", size: 30))
                .foregroundColor(.blackCopy)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
                .padding(.top, -10)
            
            Text("they’re proof you’re showing up.")
                .font(.custom("Syne-SemiBold", size: 20))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

        }
    }
    //MARK: Habit name's View
    var habitName: some View {
            HStack {
                TextField("Habit name...", text: $habitTitle)
                    .padding(20)
                    .background(isTitleConfirmed ? Color.clear : Color.yellowButton)
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(isTitleConfirmed ? Color.yellowButton : Color.clear, lineWidth: 2)
                    )
                    .foregroundColor(.blackCopy)
                    .font(.custom("Syne-SemiBold", size: 20))
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
                    
                
                Spacer()

                Button(action: {
                    if isTitleConfirmed {
                        habitTitle = ""
                    }
                    isTitleConfirmed.toggle()
                }) {
                    Image(systemName: isTitleConfirmed ? "xmark" : "checkmark")
                        .foregroundColor(.yellowButton)
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blackCopy)
                        .clipShape(Circle())
                    
                }
                .padding(.bottom, 20)
            }
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
                    
                    ScrollView(.vertical, showsIndicators: false) {
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
                        
                        RecurrenceCheckbox(
                            title: "Days",
                            action: {
                                unit = .days(habitGoal)
                            }
                        )
                        
                        RecurrenceCheckbox(
                            title: "Months",
                            action: {
                                unit = .months(habitGoal)
                            }
                        )
                        
                        ForEach(customRecurrenceUnitsList, id: \.self) { customUnitTitle in
                            RecurrenceCheckbox(
                                title: customUnitTitle,
                                action: {
                                    unit = .custom(habitGoal, customUnitTitle)
                                }
                            )
                        }
                        
                        RecurrenceCheckbox(
                            title: "Other",
                            action: {
                                isShowingCustomRecurrenceSheet = true 
                            }
                        )
                        .padding(.bottom, 30)
                        Spacer()
                        
                    }
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black, location: 0.0),
                                .init(color: .black, location: 0.7),
                                .init(color: .black.opacity(0), location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                .frame(height: 250)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ZStack {
                Rectangle()
                    .fill(.blackCopy)
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .cornerRadius(50)
                    .opacity(0.1)
            }
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
