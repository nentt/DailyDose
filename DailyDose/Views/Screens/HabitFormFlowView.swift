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
    @State private var currentPage = 0
    private let doAppearance = UIPageControl.appearance()
    
    
    
    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack {
                TabView(selection: $currentPage) {
                    defineHabit
                        .tag(0)
                    schedule
                        .tag(1)

                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                
                button
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
                    if currentPage == 0 {
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
                    } else if currentPage == 1 {
                        Text("set goals")
                            .font(.custom("Syne-SemiBold", size: 17))
                            .foregroundColor(.blackCopy.opacity(0.4))
                            .textCase(.uppercase)
                            .padding(.top, 30)
                            .opacity(currentPage == 1 ? 1 : 0)
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
        HStack {
            
            Text(customHabitText.isEmpty ? "3" : customHabitText)
                .foregroundColor(isHabitTextFocused ? .blackCopy.opacity(0.2) : .blackCopy.opacity(0.4))
                .font(.custom("Syne-SemiBold", size: 25))
                .underline(true, color: .yellowButton)
                .onTapGesture {
                    showCustomHabitTextSheet = true
                    isHabitTextFocused = true
                }
            
            Text(customHabitText.isEmpty ? "minutes" : customHabitText)
                .foregroundColor(isHabitTextFocused ? .blackCopy.opacity(0.2) : .blackCopy.opacity(0.4))
                .font(.custom("Syne-SemiBold", size: 25))
                .underline(true, color: .yellowButton)
                .onTapGesture {
                    showCustomHabitTextSheet = true
                    isHabitTextFocused = true
                }
            
            Text(customHabitText.isEmpty ? "daily" : customHabitText)
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
    
    //MARK: Button
    var button: some View {
            HStack {
                Button(action: {
                    showCustomHabitTextSheet = true
                    isHabitTextFocused = true
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
                    }
                })
                .padding(.horizontal, 5)

                Button {
                    withAnimation {
                        if currentPage < 1 {
                            incrementPage()
                        }
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 25))
                        .foregroundColor(.yellowButton)
                        .frame(width: 70, height: 70)
                        .background(Circle().fill(Color.blackCopy))
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
    
    private func incrementPage() {
        currentPage += 1
    }
}

#Preview {
    HabitFormFlowView()
}
