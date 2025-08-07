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
    
//    @Binding var habitTitle: String 
//    @Binding var habitGoal: Int
//    @Binding var selectedRecurrenceUnit: String
//    @Binding var habitPeriodicity: HabitPeriodicity
    
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        path.append(Route.habitForm)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 25))
                            .foregroundColor(.yellowButton)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.blackCopy))
                            .padding(.horizontal, 20)
                    }
                }
                
                Text("Track Your \nHabits")
                    .font(.custom("Syne-SemiBold", size: 40))
                    .foregroundColor(.blackCopy)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, -10)
                
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(habits) { habit in
                            HabitCell(habit: habit)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                VStack {
                    Text("activity")
                        .font(.custom("Syne-Regular", size: 18))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color.white.opacity(0.3))
                .cornerRadius(15)
                .padding(.horizontal, 20)
                
                Spacer()
                
//                //MARK: Recap View
//                        VStack {(
//                            Text("I choose to ")
//                                .foregroundColor(.blackCopy.opacity(0.8))
//                                .font(.custom("Syne-SemiBold", size: 19))
//                
//                
//                            +
//                            Text("\(($habitTitle.isEmpty ? "meditate" : $habitTitle).lowercased())")
//                                .foregroundColor(.yellowButton)
//                                .fontWeight(.bold)
//                                .font(.custom("Syne-SemiBold", size: 30))
//                            +
//                            Text(", for ")
//                                .foregroundColor(.blackCopy.opacity(0.8))
//                                .font(.custom("Syne-SemiBold", size: 19))
//                
//                
//                            +
//                            Text("\($habitGoal) \(($selectedRecurrenceUnit.isEmpty ? "Minutes" : $selectedRecurrenceUnit).lowercased())")
//                                .foregroundColor(.yellowButton)
//                                .fontWeight(.bold)
//                                .font(.custom("Syne-SemiBold", size: 30))
//                
////                            +
////                            Text($habitPeriodicity.kind == .challenge ? " as part of a " : " ")
////                                .foregroundColor(.blackCopy.opacity(0.8))
////                                .font(.custom("Syne-SemiBold", size: 19))
////                
////                
////                            +
////                            Text("\($habitPeriodicity.kind.label)")
////                                .foregroundColor(.yellowButton)
////                                .fontWeight(.bold)
////                                .font(.custom("Syne-SemiBold", size: 30))
//                
//                            +
//                            Text(", so I can grow into who I’m meant to be.")
//                                .foregroundColor(.blackCopy.opacity(0.8))
//                                .font(.custom("Syne-SemiBold", size: 19))
//                            )
//                        .multilineTextAlignment(.center)
//                        }
//                        .padding(.top, 20)
                    
            }
            .background {
                Color("MauveBackground")
                    .ignoresSafeArea()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .habitForm:
                    HabitFormView(habits: $habits)
                }
            }
        }
        
    }
}

#Preview {
    MainView(/*habitTitle: .constant("Medidate"), habitGoal: .constant(5), selectedRecurrenceUnit: .constant("Minutes"), habitPeriodicity: .constant(.daily(.minutes(5)))*/)
}
