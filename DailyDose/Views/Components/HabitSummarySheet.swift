//
//  HabitSummarySheet.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 27/10/2025.
//

import SwiftUI

struct HabitSummarySheet: View {
    let customHabitText: String
    let goalNumber: Int
    let selectedUnit: String
    let recurrence: String
    
    @Environment (\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            Color.yellowButton.ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                Text("You did it!")
                    .font(.custom("Syne-SemiBold", size: 28))
                    .foregroundColor(.blackCopy)
                    .padding(.bottom, 10)
                
                Text("Now check in—does it feel exciting, light, and doable?")
                    .font(.custom("Syne-medium", size: 20))
                    .foregroundColor(.blackCopy)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                
                Text("I will \(customHabitText), \(goalNumber) \(selectedUnit), \(recurrence) ")
                    .font(.custom("Syne-ExtraBold", size: 24))
                    .foregroundColor(.blackCopy)
                
                
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("CREATE HABIT")
                        .font(.custom("Syne-SemiBold", size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(.blackCopy)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .background(Color.yellowButton)
                        .cornerRadius(50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.blackCopy, lineWidth: 3)
                        }
                    
                })
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
            }
            .padding()
        }
    }
}

#Preview {
    HabitSummarySheet(customHabitText: "Practice english", goalNumber: 2, selectedUnit: "hours", recurrence: "daily")
}
