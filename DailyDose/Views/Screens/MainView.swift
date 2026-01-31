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
                
                GeometryReader { geo in
                    VStack {
                        Grid{
                            GridRow {
                                if let firstHabit = habits.first {
                                    NavigationLink(value: firstHabit) {
                                        FocusedHabitCell(habit: firstHabit, geoWidth: geo.size.width)
                                            .clipped()
                                            .cornerRadius(20)
                                    }
                                    .frame(maxWidth: .infinity)
                                } else if let randomHabit = Habit.sampleHabits.randomElement() {
                                    NavigationLink(value: randomHabit) {
                                        FocusedHabitCell(habit: randomHabit, geoWidth: geo.size.width)
                                            .clipped()
                                            .cornerRadius(20)
                                    }
                                }
                                
                                
                                VStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .gridCellColumns(1)
                                        .frame(height: 200)
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .gridCellColumns(1)
                                        .frame(height: 200)
                                }
                            }
                        }
                        .frame(width: geo.size.width)
                        
                        
                        Grid {
                            GridRow {
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .gridCellColumns(1)
                                    .frame(height: 200)
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .gridCellColumns(1)
                                    .frame(height: 200)
                                
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                
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
            .navigationDestination(for: Habit.self) { habit in
                HabitTrackingView(habit: habit)
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
