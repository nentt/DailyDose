//
//  CustomRecurrenceSheet.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 09/07/2025.
//

import SwiftUI

struct CustomRecurrenceSheet: View {
    @State private var customUnitText = ""
    @FocusState private var showKeyboard: Bool
    @Environment(\.dismiss) var dismiss
    @Binding var customUnitList: [String]
    @Binding var selectedCustomUnit: Unit
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextField("Track your progress in...", text: $customUnitText)
                    .padding(20)
                    .background(Color.yellowButton)
                    .cornerRadius(50)
                    .foregroundColor(.blackCopy)
                    .font(.custom("Syne-SemiBold", size: 20))
                    .frame(maxWidth: .infinity)
                    .autocorrectionDisabled()
                    .focused($showKeyboard)
                
                
                Spacer()
                
                Button(action: {
                    addCustomUnit()
                    dismiss()
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
        .onAppear(perform: {
            showKeyboard = true
        })
    }
    
    private func addCustomUnit() {
        let trimmedUnit = customUnitText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedUnit.isEmpty && !customUnitList.contains(trimmedUnit) {
            customUnitList.append(trimmedUnit)
            selectedCustomUnit = .custom(0, trimmedUnit)
        }
    }
}

#Preview {
    CustomRecurrenceSheet(customUnitList: .constant(["words"]), selectedCustomUnit: .constant(Unit.custom(5, "words")))
}
