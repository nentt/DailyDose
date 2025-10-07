//
//  HabitFormView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 03/06/2025.
//

import SwiftUI

struct HabitFormView: View {
    @Binding var habits: [Habit]
    
    @State private var habitTitle: String = ""
    @State private var habitGoal: Int = 5
    @State private var habitPeriodicity: HabitPeriodicity = .daily(.minutes(1))
    @State private var unit: Unit = .minutes(0)
    @State private var isTitleConfirmed = false
    @State private var showTitleAlerte = false
    
    @State private var customRecurrenceUnitsList: [String] = []
    @State private var showCustomRecurrenceSheet = false
    @State private var customUnitText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var selectedRecurrenceUnit: String = "Minutes"
    
    @State private var visionText: String = "type of person I want to be."
    @State private var showCustomVisionSheet = false
    @State private var customVisionText: String = ""
    @FocusState private var isvisionTextFocused: Bool
    @State private var showReminderView: Bool = true
    
    @Environment(\.dismiss) var dismiss
    
    //    @State private var customUnitList: [String] = []
    //    @State private var selectedCustomUnit: Unit = .minutes(0)
    
    
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            ScrollView {
                VStack {
                    titleView
                    habitName
                    periodicityView
                    reccurenceAndGoalView
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .frame(height: 0.2)
                        .padding(.vertical)
                    reminderView
                    Spacer()
 

                    createHabitButton
                    
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(.system(size: 25))
                            .foregroundColor(.yellowButton)
                    })
                }
            }
            .navigationBarBackButtonHidden(true)
            
            if showCustomRecurrenceSheet {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(1)
            }
            
            if showCustomVisionSheet {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(1)
            }
            
            VStack {
                Spacer()
                if showCustomRecurrenceSheet {
                    customRecurrenceSheet
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .zIndex(2)
            
//            VStack {
//                Spacer()
//                if showCustomVisionSheet {
//                    personTypeSheet
//                        .transition(.move(edge: .bottom).combined(with: .opacity))
//                }
//            }
//            .zIndex(2)
            
            
        }
        
    }
    
    //MARK: Title's View
    var titleView: some View {
        VStack {
            Text("Start a new habit")
                .font(.custom("Syne-SemiBold", size: 19))
                .foregroundColor(.blackCopy)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
                .padding(.top, -5)
            
            Text("Even tiny ones build real change.")
                .font(.custom("Syne-SemiBold", size: 14))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            
        }
    }
    //MARK: Habit name's View
    var habitName: some View {
        HStack {
            TextField("Habit name...", text: $habitTitle)
                .padding(20)
                .background(isTitleConfirmed && !habitTitle.isEmpty ? Color.clear : Color.yellowButton)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(isTitleConfirmed && !habitTitle.isEmpty ? Color.yellowButton : Color.clear, lineWidth: 2)
                )
                .foregroundColor(.blackCopy)
                .font(.custom("Syne-SemiBold", size:19))
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 1)
            
            
            Spacer()
            
            Button(action: {
                if isTitleConfirmed {
                    habitTitle = ""
                } else if habitTitle.isEmpty {
                    showTitleAlerte = true
                }
                isTitleConfirmed.toggle()
            }) {
                Image(systemName: isTitleConfirmed && !habitTitle.isEmpty ? "xmark" : "checkmark")
                    .foregroundColor(.yellowButton)
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color.blackCopy)
                    .clipShape(Circle())
                
            }
            .padding(.bottom, 20)
            .alert("Give your habit a name", isPresented: $showTitleAlerte) {
                Button("Ok", role: .cancel) {}
                
                
            } message: {
                Text("It’s the first step to make it real!")
            }
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
        .padding(.horizontal, 1)
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
                    .opacity(0.04)
                
                VStack(alignment: .leading) {
                    Text("Track your \n progress in...")
                        .font(.custom("Syne-Medium", size: 19))
                    
//                    ScrollView(.vertical, showsIndicators: false) {
//                        UnitCell(
//                            title: "Minutes",
//                            action: {
//                                unit = .minutes(habitGoal)
//                                selectedRecurrenceUnit = "Minutes"
//                            },
//                            isUnitCellSelected: .constant(selectedRecurrenceUnit == "Minutes")
//                        )
//                        
//                        UnitCell(
//                            title: "Hours",
//                            action: {
//                                unit = .hours(habitGoal)
//                                selectedRecurrenceUnit = "Hours"
//                            },
//                            isUnitCellSelected: .constant(selectedRecurrenceUnit == "Hours")
//                        )
//                        
//                        UnitCell(
//                            title: "Days",
//                            action: {
//                                unit = .days(habitGoal)
//                                selectedRecurrenceUnit = "Days"
//                            },
//                            isUnitCellSelected: .constant(selectedRecurrenceUnit == "Days")
//                        )
//                        
//                        UnitCell(
//                            title: "Months",
//                            action: {
//                                unit = .months(habitGoal)
//                                selectedRecurrenceUnit = "Months"
//                            },
//                            isUnitCellSelected: .constant(selectedRecurrenceUnit == "Months")
//                        )
//                        
//                        ForEach(customRecurrenceUnitsList, id: \.self) { customUnitTitle in
//                            UnitCell(
//                                title: customUnitTitle,
//                                action: {
//                                    unit = .custom(habitGoal, customUnitTitle)
//                                    selectedRecurrenceUnit = customUnitTitle
//                                },
//                                isUnitCellSelected: .constant(selectedRecurrenceUnit == customUnitTitle)
//                            )
//                        }
//                        
//                        UnitCell(
//                            title: "Other",
//                            action: {
//                                isTextFieldFocused = true
//                                showCustomRecurrenceSheet = true
//                                selectedRecurrenceUnit = "Other"
//                            },
//                            isUnitCellSelected: .constant(selectedRecurrenceUnit == "Other")
//                        )
//                        .padding(.bottom, 30)
//                        
//                        Spacer()
//                        
//                    }
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
            
//            GoalSetterCard(habitGoal: $habitGoal)
        }
    }
    
//    //MARK: Vision View
//    var visionView: some View {
//        VStack{
//            (
//                Text("I want to become ")
//                    .font(.custom("Syne-SemiBold", size: 25))
//                    .foregroundColor(.gray)
//                +
//                Text(visionText)
//                    .font(.custom("Syne-SemiBold", size: 25))
//                    .foregroundColor(.yellowButton)
//                    .underline(true, color: .blackCopy.opacity(0.2))
//                
//            )
//            .frame(maxWidth: .infinity, alignment: .center)
//            .padding(.top, 20)
//            .multilineTextAlignment(.center)
//            .onTapGesture {
//                showCustomVisionSheet = true
//                isvisionTextFocused = true
//            }
//        }
//    }
    
    
    
    //MARK: Custom Recurrence Sheet
    var customRecurrenceSheet: some View {
        ZStack {
            VStack {
                HStack {
                    ZStack {
                        TextField("Track your progress in...", text: $customUnitText)
                            .padding(20)
                            .background(Color.yellowButton)
                            .cornerRadius(50)
                            .foregroundColor(.blackCopy)
                            .font(.custom("Syne-SemiBold", size: 19))
                            .frame(maxWidth: .infinity)
                            .autocorrectionDisabled()
                            .focused($isTextFieldFocused)
                            .onChange(of: customUnitText, {
                                customUnitText = String(customUnitText.prefix(6))
                            })
                        if !customUnitText.isEmpty {
                            Button(action: {
                                customUnitText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 240)
                        }
                        
                    }
                    
                    Spacer()
                    
                    if customUnitText.isEmpty {
                        Button(action: {
                            dismissCustomRecurrenceSheet()
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
                            addCustomUnit()
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
            }
        }
    }
    
    
    //MARK: Repeat View
    var reminderView: some View {
        VStack {
            HStack {
                Text("Set reminder")
                    .font(.custom("Syne-SemiBold", size: 19))
                
                Spacer()
                
                Toggle("", isOn: $showReminderView)
            }
            .padding(2)
            HStack {
                if showReminderView {
                    HStack {
                        Text("Repeat")
                            .font(.custom("Syne-SemiBold", size: 19))
                        
                        Spacer()
                        
                        Text("Choose a moment")
                            .font(.custom("Syne-Regular", size: 19))
                        
                        
                    }
                }
            }
        }
    }
    
    //MARK: Create Habit Button
    var createHabitButton: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Text("Create habit")
                    .font(.custom("Syne-SemiBold", size: 19))
                    .fontWeight(.bold)
                    .foregroundColor(.yellowButton)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.blackCopy)
                    .cornerRadius(50)
            })

        }
    }

    
    
//    //MARK: 'Type of person' sheet
//    var personTypeSheet: some View {
//        ZStack {
//            VStack {
//                HStack {
//                    ZStack {
//                        TextField("i.e., a mindful ...", text: $customVisionText)
//                            .padding(20)
//                            .background(Color.yellowButton)
//                            .cornerRadius(50)
//                            .foregroundColor(.blackCopy)
//                            .font(.custom("Syne-SemiBold", size: 20))
//                            .frame(maxWidth: .infinity)
//                            .autocorrectionDisabled()
//                            .focused($isvisionTextFocused)
//                            .textInputAutocapitalization(.never)
//                        //                                .onChange(of: customUnitText, {
//                        //                                    customUnitText = String(customUnitText.prefix(6))
//                        //                                })
//                        if !customVisionText.isEmpty {
//                            Button(action: {
//                                customVisionText = ""
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .foregroundColor(.gray)
//                            }
//                            .padding(.leading, 240)
//                        }
//                        
//                    }
//                    
//                    Spacer()
//                    
//                    if customVisionText.isEmpty {
//                        Button(action: {
//                            dismissPersonTypeSheet()
//                        }) {
//                            Image(systemName: "xmark")
//                                .foregroundColor(.yellowButton)
//                                .frame(width: 24, height: 24)
//                                .padding()
//                                .background(Color.blackCopy)
//                                .clipShape(Circle())
//                        }
//                    } else {
//                        Button(action: {
//                            addPersonTypeVision()
//                        }) {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.yellowButton)
//                                .frame(width: 24, height: 24)
//                                .padding()
//                                .background(Color.blackCopy)
//                                .clipShape(Circle())
//                        }
//                    }
//                }
//                .padding()
//                .frame(height: 100)
//                .background(Color.mauveBackground)
//                .clipShape(TopRoundedRectangle())
//            }
//        }
//    }
//    
    
    
    
    
    
    private func dismissCustomRecurrenceSheet() {
        showCustomRecurrenceSheet = false
        isTextFieldFocused = false
        
    }
    private func addCustomUnit() {
        let trimmedUnit = customUnitText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedUnit.isEmpty && !customRecurrenceUnitsList.contains(trimmedUnit) {
            customRecurrenceUnitsList.append(trimmedUnit)
            unit = .custom(0, trimmedUnit)
            showCustomRecurrenceSheet = false
            isTextFieldFocused = false
            customUnitText = ""
            selectedRecurrenceUnit = trimmedUnit
        }
    }
    
    private func dismissPersonTypeSheet() {
        showCustomVisionSheet = false
        isvisionTextFocused = false
        
    }
    private func addPersonTypeVision() {
        let trimmedVisionText = customVisionText.trimmingCharacters(in: .whitespacesAndNewlines)
        showCustomVisionSheet = false
        isvisionTextFocused = false
        visionText = trimmedVisionText
        customUnitText = ""
    }
    
}





#Preview {
    HabitFormView(habits: .constant([Habit(title: "Learn EN words", progress: 0, objective: 5, periodicity: .daily(.custom(5, "words")))]))
}


