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
    @State private var unit: Unit = .days(0)
    @Binding var habits: [Habit]
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack {
                TextField("Title...", text: $habitTitle)
                    .background(Color.clear)
                    .foregroundColor(.blackCopy)
                    .font(.custom("Syne-SemiBold", size: 40))
                    .padding(.bottom, 20)
                
                HStack {
                    Button(action: {
                        habitPeriodicity = .daily(unit)
                        
                    }, label: {
                        Text("Daily")
                            .font(habitPeriodicity.kind == .daily ? .custom("Syne-SemiBold", size: 18) : .custom("Syne-SemiBold", size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(.yellowButton)
                            .frame(width: 120, height: 60)
                            .background(habitPeriodicity.kind == .daily ? Color.clear : Color.blackCopy)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(habitPeriodicity.kind == .daily ? .yellowButton : .blackCopy, lineWidth: 2)
                            )
                            .animation(.easeInOut(duration: 0.1), value: habitPeriodicity.kind)
                    })
                    
                    Button(action: {
                        habitPeriodicity = .weekly(unit)
                        
                    }, label: {
                        Text("Weekly")
                            .font(habitPeriodicity.kind == .weekly ? .custom("Syne-SemiBold", size: 18) : .custom("Syne-SemiBold", size: 14))                            .fontWeight(.bold)
                            .foregroundColor(.yellowButton)
                            .frame(width: 120, height: 60)
                            .background(habitPeriodicity.kind == .weekly ? Color.clear : Color.blackCopy)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(habitPeriodicity.kind == .weekly ? .yellowButton : .blackCopy, lineWidth: 2)
                            )
                            .animation(.easeInOut(duration: 0.1), value: habitPeriodicity.kind)
                    })
                    
                    Button(action: {
                        habitPeriodicity = .challenge(unit)
                        
                    }, label: {
                        Text("Challenge")
                            .font(habitPeriodicity.kind == .challenge ? .custom("Syne-SemiBold", size: 18) : .custom("Syne-SemiBold", size: 14))                            .fontWeight(.bold)
                            .foregroundColor(.yellowButton)
                            .frame(width: 120, height: 60)
                            .background(habitPeriodicity.kind == .challenge ? Color.clear : Color.blackCopy)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(habitPeriodicity.kind == .challenge ? .yellowButton : .blackCopy, lineWidth: 2)
                            )
                            .animation(.easeInOut(duration: 0.1), value: habitPeriodicity.kind)
                    })
                }
                .padding(.bottom, 20)
                
                
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
                            
                            
                            
                            
                            Button(action: {
                                unit = .minutes(habitGoal)
                                
                            }, label: {
                                ZStack {
                                    Rectangle()
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(Color.yellowButton)
                                        .cornerRadius(50)
                                        .frame(height: 40)
                                    
                                    
                                    
                                    HStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.blackCopy, lineWidth: 1)
                                            .frame(width: 20, height: 20)
                                        
                                        
                                        Text("Minutes")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.blackCopy)
                                            .fontWeight(.bold)
                                            .cornerRadius(50)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                }
                            })
                            
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color.yellowButton)
                                    .cornerRadius(50)
                                    .frame(height: 40)
                                Button(action: {
                                    unit = .minutes(habitGoal)
                                    
                                }, label: {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.blackCopy, lineWidth: 1)
                                            .frame(width: 20, height: 20)
                                        
                                        
                                        Text("Hours")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.blackCopy)
                                            .fontWeight(.bold)
                                            .cornerRadius(50)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    
                                })
                            }
                            
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
                
                HStack {
                    Button(action: {
                        habitGoal -= 1
                    }, label: {
                        Image(systemName: "minus")
                            .font(.system(size: 25))
                            .foregroundColor(.blackCopy)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.yellowButton))
                            .padding(.horizontal, 20)
                    })
                    
                    Text("\(habitGoal)")
                        .frame(width: 150, height: 150)
                        .background(Color.clear)
                        .foregroundColor(Color.yellowButton)
                        .font(.custom("Syne-ExtraBold", size: 45))
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        habitGoal += 1
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 25))
                            .foregroundColor(.blackCopy)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.yellowButton))
                            .padding(.horizontal, 20)
                    })
                    
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HabitFormView(habits: .constant([Habit(title: "Learn EN words", progress: 0, objective: 5, periodicity: .daily(.custom(5, "words")))]))
}
