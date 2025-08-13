//
//  HabitFormFlowView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 12/08/2025.
//

import SwiftUI

struct HabitFormFlowView: View {
    @State private var showCustomHabitTextSheet = false
    @State private var customHabitText: String = ""
    @FocusState private var isHabitTextFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack {
                defineHabit
            }
            
            VStack {
                Spacer()
                if showCustomHabitTextSheet {
                    customHabitSheet
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if showCustomHabitTextSheet {
                        dismissCustomHabitTextSheet()
                    } else {
                        dismiss()
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
                        .opacity(showCustomHabitTextSheet ? 0 : 1)
                        .animation(.easeInOut(duration: 0.3), value: showCustomHabitTextSheet)
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
    
    
}

#Preview {
    HabitFormFlowView()
}
