//
//  GoalFormView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 09/09/2025.
//

import SwiftUI

struct GoalFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var goalNumber: Int = 5
    @FocusState private var isGoalNumberKeyboardFocused: Bool
    @State private var showCustomGoalValidationButton = false
    private let numberGoalLimit = 10000
    
    @State private var unit: Unit = .minutes(5)
    @State private var selectedRecurrenceUnit: String = "Minutes"
    @State private var customRecurrenceUnitsList: [String] = []
    @State private var isTextFieldFocused: Bool = false
    @State private var showCustomRecurrenceSheet: Bool = false
    @State private var habitGoal: Int = 5
    @State private var currentPage = 0
    
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            
            VStack {
                goalView
                
                TabView(selection: $currentPage) {
                    VStack {
                        Spacer()
                        goalSettings
                            .padding(.top, 50)
                            .padding(.bottom, 50)
                        Spacer()
                        goalDescription
                    }
                    .tag(0)
                    .background(Color.mauveBackground)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 8) {
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(index == currentPage ? Color.yellowButton : Color.blackCopy.opacity(0.1))
                            .frame(height: 4)
                            .cornerRadius(2)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
            }
            .padding(.top, 50)
            
            TextField("", value: $goalNumber, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .focused($isGoalNumberKeyboardFocused)
                .opacity(0)
            
            VStack {
                Spacer()
                if showCustomGoalValidationButton {
                    customGoalValidationButton
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.blackCopy)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.yellowButton)
                    }
                    .padding(.top, 20)
                })
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack(alignment: .trailing) {
                    Text("set your goal")
                        .font(.custom("Syne-SemiBold", size: 17))
                        .foregroundColor(.blackCopy.opacity(0.4))
                        .textCase(.uppercase)
                        .padding(.top, 30)
                }
            }
        }
    }
    
    
    //MARK: Goal view
    var goalView: some View {
        VStack {
            HStack(spacing: 0) {
                Text(goalNumber.roundedWithAbbreviations)
                    .foregroundColor(.yellowButton.opacity(0.8))
                    .font(.custom("Syne-ExtraBold", size: 90))
                    .padding(.trailing, 20)
                    .onChange(of: goalNumber) { oldValue, newValue in
                        if newValue > numberGoalLimit {
                            goalNumber = numberGoalLimit
                        }
                        habitGoal = goalNumber
                    }
                
                VStack(alignment: .leading) {
                    Text("steps")
                        .font(.custom("Syne-Regular", size: 17))
                        .foregroundColor(.primary)
                    
                    Text("daily")
                        .font(.custom("Syne-Regular", size: 17))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
            }
        }
    }
    
    //MARK: Define your goal
    var goalSettings: some View {
        HStack {
            Button {
                goalNumber = 5
                isGoalNumberKeyboardFocused = false
                showCustomGoalValidationButton = false
                
                
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                    
                    Text("5")
                        .font(.custom("Syne-Regular", size: 22))
                        .foregroundColor(.blackCopy.opacity(0.5))
                        .padding(.top, -5)
                }
            }
            
            Button {
                goalNumber = 10
                isGoalNumberKeyboardFocused = false
                showCustomGoalValidationButton = false
                
                
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                    
                    Text("10")
                        .font(.custom("Syne-Regular", size: 22))
                        .foregroundColor(.blackCopy.opacity(0.5))
                        .padding(.top, -5)
                }
            }
            
            Button {
                goalNumber = 15
                isGoalNumberKeyboardFocused = false
                showCustomGoalValidationButton = false
                
                
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                    
                    Text("15")
                        .font(.custom("Syne-Regular", size: 22))
                        .foregroundColor(.blackCopy.opacity(0.5))
                        .padding(.top, -5)
                }
            }
            
            Button {
                goalNumber = 30
                isGoalNumberKeyboardFocused = false
                showCustomGoalValidationButton = false
                
                
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                    
                    Text("30")
                        .font(.custom("Syne-Regular", size: 22))
                        .foregroundColor(.blackCopy.opacity(0.5))
                        .padding(.top, -5)
                }
            }
            
            Button {
                goalNumber = 60
                isGoalNumberKeyboardFocused = false
                showCustomGoalValidationButton = false
                
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)
                    
                    Text("60")
                        .font(.custom("Syne-Regular", size: 22))
                        .foregroundColor(.blackCopy.opacity(0.5))
                        .padding(.top, -3)
                }
            }
            Spacer()
            
            Button {
                goalNumber = 0
                isGoalNumberKeyboardFocused = true
                showCustomGoalValidationButton = true
            } label: {
                ZStack {
                    Circle()
                        .fill(.blackCopy.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "circle.grid.3x3.fill")
                        .font(.custom("Syne-Regular", size: 22))
                        .foregroundColor(.blackCopy.opacity(0.5))
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    //MARK: Custom goal validation
    var customGoalValidationButton: some View {
        HStack {
            Spacer()
            Button(action: {
                isGoalNumberKeyboardFocused = false
                showCustomGoalValidationButton = false
                
                
            }) {
                Image(systemName: "checkmark")
                    .foregroundColor(.yellowButton)
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.blackCopy)
                    .clipShape(Circle())
                    .padding()
                    .frame(height: 100)
                    .background(Color.mauveBackground)
            }
        }
    }
    
    //MARK: Goal description
    var goalDescription: some View {
        HStack {
            Text("Decide how big your next streak should be.")
                .frame(width: 250, height: 130)
                .foregroundColor(.blackCopy)
                .font(.custom("Syne-SemiBold", size: 30))
                .padding(.leading, 20)
            Spacer()
        }
            
        
    }
}

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        
        if thousand >= 1 {
            let truncated = floor(thousand * 10) / 10  // tronque au lieu d’arrondir
            return truncated.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(truncated))k"
            : String(format: "%.1fk", truncated)
        } else {
            return "\(self)"
        }
    }
}


#Preview {
    GoalFormView()
}
