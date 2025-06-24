//
//  PeriodicityCell.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 19/06/2025.
//

import SwiftUI

struct RecurrenceCell: View {
    let title: String
    let action: () -> Void
    @State private var habitGoal: Int = 1
    @State private var unit: Unit = .days(0)


    
    var body: some View {
        Button(action: {
            unit = .minutes(habitGoal)
            
        }, label: {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.yellowButton)
                    .cornerRadius(50)
                    .frame(height: 40)
                
                
                
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.blackCopy, lineWidth: 1)
                        .frame(width: 20, height: 20)
                    
                    
                    Text("Minutes")
                        .font(.system(size: 14))
                        .foregroundColor(Color.blackCopy)
                        .fontWeight(.bold)
                        .cornerRadius(50)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        })    }
}

#Preview {
    RecurrenceCell(title: "Minutes", action: {})
}
