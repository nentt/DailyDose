//
//  HabitProgressCell.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 31/01/2026.
//

import SwiftUI

struct HabitProgressCell: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.yellowButton)
            .gridCellColumns(1)
            .frame(height: 200)
            .overlay(alignment: .topLeading){
                Text("YOUR\nPROGRESS")
                    .font(.custom("Syne-Bold", size: 14))
                    .foregroundStyle(.blackCopy)
                    .padding()

            }
            .overlay(alignment: .bottomLeading){
                Text("90%")
                    .font(.custom("Syne-ExtraBold", size: 30))
                    .foregroundStyle(.blackCopy)
                    .padding()
                
            }
    }
}

#Preview {
    HabitProgressCell()
        .frame(width: 200, height: 200)
}
