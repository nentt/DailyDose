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
            }
            .background {
                Color("MauveBackground")
                    .ignoresSafeArea()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .habitForm:
                    HabitFormFlowView()
                }
            }
        }
        
    }
}

#Preview {
    MainView()
}
