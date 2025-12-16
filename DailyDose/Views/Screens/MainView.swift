//
//  ContentView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 31/05/2025.
//

import SwiftUI

enum Route: Hashable {
    case habitForm
}
struct MainView: View {
    @State private var habits: [Habit] = Habit.sampleHabits
    @State private var path = NavigationPath()
    @State private var selectedHabit: Habit?
    @State private var dailyHabitsViewSelected: Bool = true
    @State private var overviewViewSelected: Bool = false
    
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    VStack {
                        Button(action: {
                            dailyHabitsViewSelected = true
                            overviewViewSelected = false
                        }, label: {
                            Text("Daily habits")
                                .font(.custom("Syne-Regular", size: 17))
                                .fontWeight(.bold)
                                .foregroundStyle(dailyHabitsViewSelected ? .blackCopy : .secondary)
                                .padding(.horizontal, 20)
                        })
                            Circle()
                                .frame(width: 4, height: 4)
                                .foregroundStyle(dailyHabitsViewSelected ? .blackCopy : .mauveBackground)
                    }
                    .padding(.top, 10)

                    
                    VStack {
                        Button {
                            overviewViewSelected = true
                            dailyHabitsViewSelected = false
                        } label: {
                            Text("Overview")
                                .font(.custom("Syne-Regular", size: 17))
                                .fontWeight(.bold)
                                .foregroundStyle(overviewViewSelected ? .blackCopy : .secondary)
                        }
                            Circle()
                                .frame(width: 4, height: 4)
                                .foregroundStyle(overviewViewSelected ? .blackCopy : .mauveBackground)
                    }
                    .padding(.top, 10)


                   
                    Spacer()
                    Button {
                        path.append(Route.habitForm)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 25))
                            .foregroundColor(.yellowButton)
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(Color.blackCopy))
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                }
                
//                VStack {
//                    Text("Track Your")
//                        .font(.custom("Syne-Bold", size: 34))
//                        .foregroundColor(.blackCopy)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 20)
//                        .padding(.top, -10)
//                    
//                    Text("Habits")
//                        .font(.custom("Syne-Bold", size: 34))
//                        .foregroundColor(.blackCopy)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 20)
//                        .padding(.top, -25)
//                }
                
                
                HStack {
                    VStack {
                        Text("5")
                            .font(.custom("Syne-ExtraBold", size: 45))
                            .foregroundColor(.yellowButton)
                        Text("daily")
                            .font(.custom("Syne-Regular", size: 14))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("habit")
                            .font(.custom("Syne-Regular", size: 14))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 30)
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.1))
                        .frame(width: 1, height: 40)
                        .padding(.vertical)
                    
                    VStack {
                        Text("3")
                            .font(.custom("Syne-ExtraBold", size: 45))
                            .foregroundColor(.yellowButton)
                        Text("weekly")
                            .font(.custom("Syne-Regular", size: 14))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("habit")
                            .font(.custom("Syne-Regular", size: 14))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 30)
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.1))
                        .frame(width: 1, height: 40)
                        .padding(.vertical, 20)
                    
                    
                    VStack {
                        Text("1")
                            .font(.custom("Syne-ExtraBold", size: 45))
                            .foregroundColor(.yellowButton)
                        Text("yearly")
                            .font(.custom("Syne-Regular", size: 14))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("challenge")
                            .font(.custom("Syne-Regular", size: 14))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 30)
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(habits) { habit in
                            Button {
                                selectedHabit = habit
                            } label: {
                                HabitCell(habit: habit)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                

                
                Spacer()
            }
            .background {
                Color("MauveBackground")
                    .ignoresSafeArea()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .habitForm:
                    HabitFormFlowView { newHabit in
                        habits.insert(newHabit, at: 0)
                        selectedHabit = newHabit
                        
                    }
                }
            }
            .onAppear {
                if selectedHabit == nil {
                    selectedHabit = habits.first
                }
            }
        }
        
    }
}

#Preview {
    MainView()
}
