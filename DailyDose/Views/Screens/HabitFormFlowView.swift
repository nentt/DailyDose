//
//  HabitFormFlowView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 12/08/2025.
//

import SwiftUI

enum SheetType {
    case habit
    case goal
}

struct HabitFormFlowView: View {
    @State private var showCustomHabitTextSheet = false
    @State private var customHabitText: String = ""
    @FocusState private var isHabitTextFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0
    private let doAppearance = UIPageControl.appearance()
    @State private var customGoalNumber: String = ""
    @State private var showCustomGoalNumberSheet = false
    @FocusState private var isGoalNumberFocused: Bool
    @State private var showRecurrencePicker: Bool = false
    @State private var selectedRecurrenceUnit: String = ""
    @State private var habitGoal: Int = 5
    @State private var unit: Unit = .minutes(0)
    @State private var showCustomRecurrenceSheet = false
    @FocusState private var isRecurrenceFocused: Bool



    
    
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack {
                TabView(selection: $currentPage) {
                    defineHabit
                        .tag(0)
                    schedule
                        .tag(1)
                    schedule
                        .tag(2)

                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                button
            }
            
            VStack {
                Spacer()
                if showCustomHabitTextSheet {
                    customHabitSheet
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                } else if showCustomGoalNumberSheet {
                    customGoalSheet
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                } else if showCustomRecurrenceSheet {
                    customRecurrenceSheet
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    if showCustomHabitTextSheet {
                        dismissCustomHabitTextSheet()
                    } else {
                        if currentPage == 0 {
                            dismiss()
                        } else if currentPage == 1 {
                            withAnimation(.easeInOut) {
                                currentPage -= 1
                            }
                        } else if currentPage == 2 {
                            withAnimation(.easeInOut) {
                                currentPage -= 1
                            }
                        }
                    }
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.blackCopy)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.yellowButton)
                            .rotationEffect(.degrees(showCustomHabitTextSheet ? -90 : 0))
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: showCustomHabitTextSheet)
                    }
                    .padding(.top, 20)
                    
                })
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack(alignment: .trailing) {
                   
                        Text("define your habit")
                            .font(.custom("Syne-SemiBold", size: 17))
                            .foregroundColor(.blackCopy.opacity(0.4))
                            .textCase(.uppercase)
                            .padding(.top, 30)
                            .opacity(showCustomHabitTextSheet ? 1 : 0)
                            .animation(.easeInOut(duration: 0.3), value: showCustomHabitTextSheet)
                        
                        Text("new habit")
                            .font(.custom("Syne-SemiBold", size: 17))
                            .foregroundColor(.blackCopy.opacity(0.4))
                            .textCase(.uppercase)
                            .padding(.top, 30)
                            .opacity(showCustomHabitTextSheet ? 0 : (currentPage == 1 ? 0 : 1))
                            .animation(.easeInOut(duration: 0.3), value: showCustomHabitTextSheet)
                    
                    if showCustomHabitTextSheet && currentPage == 0 {
                        Text("set goals")
                            .font(.custom("Syne-SemiBold", size: 17))
                            .foregroundColor(.blackCopy.opacity(0))
                            .textCase(.uppercase)
                            .padding(.top, 30)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.1), value: currentPage)
                    } else if !showCustomHabitTextSheet && currentPage == 1 {
                        Text("set goals")
                            .font(.custom("Syne-SemiBold", size: 17))
                            .foregroundColor(.blackCopy.opacity(0.4))
                            .textCase(.uppercase)
                            .padding(.top, 30)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.3), value: currentPage)
                    }
                }
            }
        }
    }
    
    
    
    //MARK: Define Habit
    var defineHabit: some View {
        HStack {
            Text("I will")
                .foregroundColor(.blackCopy.opacity(0.8))
                .font(.custom("Syne-SemiBold", size: 25))
            
            
            Text(customHabitText.isEmpty ? "habit" : customHabitText)
                .foregroundColor(isHabitTextFocused ? .blackCopy.opacity(0.2) : .blackCopy.opacity(0.4))
                .font(.custom("Syne-SemiBold", size: 25))
                .underline(true, color: .yellowButton)
                .onTapGesture {
                    showCustomHabitTextSheet = true
                    isHabitTextFocused = true
                }
        }
        .padding()
        
    }
    
    //MARK: Custom Habit Sheet
    var customHabitSheet: some View {
        ZStack {
            VStack {
                HStack {
                    ZStack {
                        TextField("i.e., medidate", text: $customHabitText)
                            .padding(20)
                            .background(Color.yellowButton)
                            .cornerRadius(50)
                            .foregroundColor(.blackCopy)
                            .font(.custom("Syne-SemiBold", size: 20))
                            .frame(maxWidth: .infinity)
                            .autocorrectionDisabled()
                            .focused($isHabitTextFocused)
                            .textInputAutocapitalization(.never)
                        
                        if !customHabitText.isEmpty {
                            Button(action: {
                                customHabitText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 240)
                        }
                        
                    }
                    
                    Spacer()
                    
                    if customHabitText.isEmpty {
                        Button(action: {
                            dismissCustomHabitTextSheet()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.yellowButton)
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blackCopy)
                                .clipShape(Circle())
                        }
                    } else {
                        Button(action: {
                            addCustomHabitText()
                        }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.yellowButton)
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blackCopy)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
                .frame(height: 100)
                .background(Color.mauveBackground)
                .clipShape(TopRoundedRectangle())
            }
        }
    }
    
    //MARK: Define goal, recurrence & periodicity
    var schedule: some View {
        VStack {
            
            Text(formattedNumber(customGoalNumber).isEmpty ? "5" : formattedNumber(customGoalNumber))
                .font(.custom("Syne-ExtraBold", size: 45))
                .foregroundColor(.yellowButton)
                .onTapGesture {
                    showCustomGoalNumberSheet = true
                    isGoalNumberFocused = true
                }
                .padding(.bottom, 20)
            
          
            
            HStack {
                
                Text(selectedRecurrenceUnit.lowercased().isEmpty ? "minutes" : selectedRecurrenceUnit.lowercased())
                    .foregroundColor(isHabitTextFocused ? .blackCopy.opacity(0.2) : .blackCopy.opacity(0.4))
                    .font(.custom("Syne-SemiBold", size: 25))
                    .underline(true, color: .yellowButton)
                    .onTapGesture {
                        showRecurrencePicker = true
                        showCustomRecurrenceSheet = true
                        isRecurrenceFocused = true
                    }
                
                Text("daily")
                    .foregroundColor(isHabitTextFocused ? .blackCopy.opacity(0.2) : .blackCopy.opacity(0.4))
                    .font(.custom("Syne-SemiBold", size: 25))
                    .underline(true, color: .yellowButton)
                    .onTapGesture {
                        showCustomGoalNumberSheet = true
                        isGoalNumberFocused = true
                    }
            }
            
            if showRecurrencePicker {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Pick from the list or type your own")
                            .font(.custom("Syne-SemiBold", size: 15))
                            .foregroundColor(.blackCopy.opacity(0.2))
                            .fontWeight(.bold)
                            .padding(.top, 40)
                        ScrollView(.vertical, showsIndicators: false) {
                            RecurrenceCheckbox(
                                title: "Minutes",
                                action: {
                                    unit = .minutes(habitGoal)
                                    selectedRecurrenceUnit = "Minutes"
                                },
                                isRecurrenceCheckboxSelected: .constant(selectedRecurrenceUnit == "Minutes")
                            )
                            
                            RecurrenceCheckbox(
                                title: "Hours",
                                action: {
                                    unit = .hours(habitGoal)
                                    selectedRecurrenceUnit = "Hours"
                                },
                                isRecurrenceCheckboxSelected: .constant(selectedRecurrenceUnit == "Hours")
                            )
                            
                            RecurrenceCheckbox(
                                title: "Days",
                                action: {
                                    unit = .days(habitGoal)
                                    selectedRecurrenceUnit = "Days"
                                },
                                isRecurrenceCheckboxSelected: .constant(selectedRecurrenceUnit == "Days")
                            )
                            
                            RecurrenceCheckbox(
                                title: "Months",
                                action: {
                                    unit = .months(habitGoal)
                                    selectedRecurrenceUnit = "Months"
                                },
                                isRecurrenceCheckboxSelected: .constant(selectedRecurrenceUnit == "Months")
                            )
                            
                            //                        ForEach(customRecurrenceUnitsList, id: \.self) { customUnitTitle in
                            //                            RecurrenceCheckbox(
                            //                                title: customUnitTitle,
                            //                                action: {
                            //                                    unit = .custom(habitGoal, customUnitTitle)
                            //                                    selectedRecurrenceUnit = customUnitTitle
                            //                                },
                            //                                isRecurrenceCheckboxSelected: .constant(selectedRecurrenceUnit == customUnitTitle)
                            //                            )
                            //                        }
                            
                            //                        RecurrenceCheckbox(
                            //                            title: "Other",
                            //                            action: {
                            //                                isTextFieldFocused = true
                            //                                showCustomRecurrenceSheet = true
                            //                                selectedRecurrenceUnit = "Other"
                            //                            },
                            //                            isRecurrenceCheckboxSelected: .constant(selectedRecurrenceUnit == "Other")
                            //                        )
                            .padding(.bottom, 30)
                            
                            Spacer()
                            
                        }
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
            }
        }
        .padding()
    }
    
    //MARK: Custom Goal Sheet
    var customGoalSheet: some View {
        ZStack {
            VStack {
                HStack {
                    ZStack {
                        TextField("5", text: $customGoalNumber)
                            .padding(20)
                            .background(Color.yellowButton)
                            .cornerRadius(50)
                            .foregroundColor(.blackCopy)
                            .font(.custom("Syne-SemiBold", size: 20))
                            .frame(maxWidth: .infinity)
                            .autocorrectionDisabled()
                            .focused($isGoalNumberFocused)
                            .keyboardType(.numberPad)
                        
                        if !customGoalNumber.isEmpty {
                            Button(action: {
                                customGoalNumber = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 240)
                        }
                        
                    }
                    
                    Spacer()
                    
                    if customGoalNumber.isEmpty {
                        Button(action: {
                            dismissCustomHGoalNumberSheet()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.yellowButton)
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blackCopy)
                                .clipShape(Circle())
                        }
                    } else {
                        Button(action: {
                            addCustomGoalNumber()
                        }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.yellowButton)
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blackCopy)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
                .frame(height: 100)
                .background(Color.mauveBackground)
                .clipShape(TopRoundedRectangle())
            }
        }
    }
    
    //MARK: Custom Recurrence Sheet
    var customRecurrenceSheet: some View {
        ZStack {
            VStack {
                HStack {
                    ZStack {
                        TextField("i.e., steps", text: $selectedRecurrenceUnit)
                            .padding(20)
                            .background(Color.yellowButton)
                            .cornerRadius(50)
                            .foregroundColor(.blackCopy)
                            .font(.custom("Syne-SemiBold", size: 20))
                            .frame(maxWidth: .infinity)
                            .autocorrectionDisabled()
                            .focused($isRecurrenceFocused)
                            .textInputAutocapitalization(.never)
                        
                        if !selectedRecurrenceUnit.isEmpty {
                            Button(action: {
                                selectedRecurrenceUnit = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 240)
                        }
                        
                    }
                    
                    Spacer()
                    
                    if selectedRecurrenceUnit.isEmpty {
                        Button(action: {
//                            dismissCustomHabitTextSheet()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.yellowButton)
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blackCopy)
                                .clipShape(Circle())
                        }
                    } else {
                        Button(action: {
//                            addCustomHabitText()
                        }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.yellowButton)
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blackCopy)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
                .frame(height: 100)
                .background(Color.mauveBackground)
                .clipShape(TopRoundedRectangle())
            }
        }
    }
    
    //MARK: Button
    var button: some View {
            HStack {
                Button(action: {
                    if currentPage == 0 {
                        showCustomHabitTextSheet = true
                        isHabitTextFocused = true
                    } else if currentPage == 1 {
                        showCustomGoalNumberSheet = true
                        isGoalNumberFocused = true
                    }
                }, label: {
                    if currentPage == 0 {
                        Text("DEFINE HABIT")
                            .font(.custom("Syne-SemiBold", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.blackCopy)
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                            .cornerRadius(50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.yellowButton, lineWidth: 3)
                            }
                        
                    } else if currentPage == 1 {
                        Text("SET GOALS")
                            .font(.custom("Syne-SemiBold", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(.blackCopy)
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                            .cornerRadius(50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.yellowButton, lineWidth: 3)
                            }
                    }
                })
                .padding(.horizontal, 5)

                Button {
                    if customHabitText.isEmpty {
                        
                    } else {
                    withAnimation {
                        if currentPage < 1 {
                            incrementPage()
                        } else if currentPage < 2 {
                            incrementPage()
                        }
                    }
                }
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 25))
                        .foregroundColor(.yellowButton)
                        .frame(width: 70, height: 70)
                        .background(Circle().fill(customHabitText.isEmpty ? Color.blackCopy.opacity(0.3) : Color.blackCopy))
                }
                

            }
            .padding(.horizontal, 30)

            .padding(.bottom, 25)
    }
    
    private func dismissCustomHabitTextSheet() {
        showCustomHabitTextSheet = false
        isHabitTextFocused = false
        
    }
    
    private func addCustomHabitText() {
        let trimmedVisionText = customHabitText.trimmingCharacters(in: .whitespacesAndNewlines)
        showCustomHabitTextSheet = false
        isHabitTextFocused = false
        customHabitText = trimmedVisionText
    }
    
    private func dismissCustomHGoalNumberSheet() {
        showCustomGoalNumberSheet = false
        isGoalNumberFocused = false
        
    }
    
    private func addCustomGoalNumber() {
        let trimmedVisionText = customGoalNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        showCustomGoalNumberSheet = false
        isGoalNumberFocused = false
        customGoalNumber = trimmedVisionText
    }
    
    private func incrementPage() {
        currentPage += 1
    }
    
    func formattedNumber(_ text: String) -> String {
        guard let number = Double(text) else { return text } // si ce n'est pas un nombre, on renvoie le texte tel quel
        return number.formatted(.number.grouping(.automatic))
    }
}

#Preview {
    HabitFormFlowView()
}
