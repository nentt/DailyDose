////
////  CustomRecurrenceSheet.swift
////  DailyDose
////
////  Created by Audrey Penninckx on 09/07/2025.
////
//
//import SwiftUI
//
//struct CustomRecurrenceSheet: View {
//    @State private var customUnitText = ""
//    @FocusState private var isTextFieldFocused: Bool
//    @Environment(\.dismiss) var dismiss
//    @Binding var customUnitList: [String]
//    @Binding var selectedCustomUnit: Unit
//    @Binding var show: Bool
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                Spacer()
//                ScrollView {
//                    Spacer()
//                    HStack {
//                        TextField("Track your progress in...", text: $customUnitText)
//                            .padding(20)
//                            .background(Color.yellowButton)
//                            .cornerRadius(50)
//                            .foregroundColor(.blackCopy)
//                            .font(.custom("Syne-SemiBold", size: 20))
//                            .frame(maxWidth: .infinity)
//                            .autocorrectionDisabled()
//                            .focused($isTextFieldFocused)
//                        
//                        
//                        Spacer()
//                        
//                        Button(action: {
//                            addCustomUnit()
//                            dismiss()
//                        }) {
//                            Image(systemName: "checkmark")
//                                .foregroundColor(.yellowButton)
//                                .frame(width: 24, height: 24)
//                                .padding()
//                                .background(Color.blackCopy)
//                                .clipShape(Circle())
//                            
//                        }
//                    }
//                    .padding()
//                    .frame(height: 100)
//                    .background(Color.mauveBackground)
//                    .clipShape(
//                        .rect(
//                            topLeadingRadius: 30,
//                            bottomLeadingRadius: 0,
//                            bottomTrailingRadius: 0,
//                            topTrailingRadius: 30
//                        )
//                    )
//                }
//            }
//
//        }
//    }
//    
//    private func addCustomUnit() {
//        let trimmedUnit = customUnitText.trimmingCharacters(in: .whitespacesAndNewlines)
//        if !trimmedUnit.isEmpty && !customUnitList.contains(trimmedUnit) {
//            customUnitList.append(trimmedUnit)
//            selectedCustomUnit = .custom(0, trimmedUnit)
//        }
//    }
//}
//
//#Preview {
//    CustomRecurrenceSheet(customUnitList: .constant(["words"]), selectedCustomUnit: .constant(Unit.custom(5, "words")), show: .constant(true))
//}
