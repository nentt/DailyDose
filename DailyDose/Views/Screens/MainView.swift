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
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(Color.blackCopy))
                            .padding(.horizontal, 20)
                    }
                }
                
                Text("Track Your \nHabits")
                    .font(.custom("Syne-SemiBold", size: 37))
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
                            Button {
                                selectedHabit = habit
                            } label: {
                                HabitCell(habit: habit)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
//                VStack(alignment: .leading) {
//                    //                    Text(selectedHabit?.title.firstUppercased ?? "Select a habit")
//                    //                        .font(.custom("Syne-SemiBold", size: 28))
//                    //                        .frame(maxWidth: .infinity, alignment: .leading)
//                    //                        .padding()
//                    Spacer()
//                    
//                    VStack {
//                        HStack {
//                            Text("10")
//                                .font(.custom("Syne-ExtraBold", size: 80))
//                                .foregroundColor(.blackCopy.opacity(0.8))
//                                .overlay(alignment: .topTrailing) {
//                                    ZStack {
//                                        EightPointStar()
//                                            .fill(Color.yellowButton)
//                                            .frame(width: 55, height: 55)
//                                            .offset(x: 25, y: 5)
//                                        Image(systemName: "chevron.right")
//                                            .font(.custom("Syne-Bold", size: 15))
//                                            .foregroundColor(.blackCopy)
//                                            .offset(x: 25, y: 5)
//                                    }
//                                }
//                        }
//                        
//                        Text("let's get started!")
//                            .font(.custom("Syne-SemiBold", size: 16))
//                            .foregroundColor(.secondary)
//                    }
//                }
                
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
    
    struct EightPointStar: Shape {
        func path(in rect: CGRect) -> Path {
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let outerRadius = min(rect.width, rect.height) / 2
            let innerRadius = outerRadius * 0.45
            var path = Path()
            
            for i in 0..<16 { // 2 * 8 sommets
                let angle = (Double(i) * .pi) / 8
                let radius = i.isMultiple(of: 2) ? outerRadius : innerRadius
                let point = CGPoint(
                    x: center.x + CGFloat(cos(angle)) * radius,
                    y: center.y + CGFloat(sin(angle)) * radius
                )
                if i == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
            return path
        }
    }
}

#Preview {
    MainView()
}
