//
//  CustomRecurrenceSheet.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 09/07/2025.
//

import SwiftUI

struct CustomRecurrenceSheet: View {
    @Binding var customRecurrenceUnitsList: [String]
    @Binding var showCustomRecurrenceSheet: Bool
    @Binding var customUnitText: String
    @FocusState private var isTextFieldFocused: Bool
    @Binding var unit: Unit 
    @Binding var selectedRecurrenceUnit: String




    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ZStack {
                        TextField("Track your progress in...", text: $customUnitText)
                            .padding(20)
                            .background(Color.yellowButton)
                            .cornerRadius(50)
                            .foregroundColor(.blackCopy)
                            .font(.custom("Syne-SemiBold", size: 20))
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
                                dimissCustomRecurrenceSheet()
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
                .clipShape(
                    .rect(
                        topLeadingRadius: 30,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 30
                    )
                )
            }
        }

    }

    private func dimissCustomRecurrenceSheet() {
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
}

#Preview {
    CustomRecurrenceSheet(customRecurrenceUnitsList: .constant(["Steps"]), showCustomRecurrenceSheet: .constant(true), customUnitText: .constant("Steps"), unit: .constant(.minutes(0)), selectedRecurrenceUnit: .constant("Other"))
}
