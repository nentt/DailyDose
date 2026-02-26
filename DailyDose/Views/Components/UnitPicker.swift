//
//  CustomUnitPicker.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 23/02/2026.
//

import SwiftUI

enum UnitName: String, CaseIterable {
    case timer = "timer"
    case multiSteps = "multi-steps"
    case simple = "simple"
}


struct UnitPicker: View {
    @Binding var selectedUnit: UnitName
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(UnitName.allCases, id: \.rawValue) { unit in
                ZStack {
                    if selectedUnit == unit {
                        Capsule()
                            .fill(Color.yellowButton)
                            .matchedGeometryEffect(id: "unitBackground", in: animation)
                            .frame(height: 45)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: selectedUnit)
                    }
                    
                    Text(unit.rawValue.uppercased())
                        .frame(width: 120)
                        .font(.custom("Syne-Regular", size: 14))
                        .foregroundStyle(selectedUnit == unit ? .blackCopy.opacity(0.5) : .blackCopy.opacity(0.5))
                        .bold(selectedUnit == unit)
                    
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedUnit = unit
                }
            }
        }
        .padding(6)
        .background(
            Capsule()
                .fill(Color.blackCopy.opacity(0.1))
            )
        .padding(.horizontal, 10)

    }
}


#Preview {
    UnitPicker(selectedUnit: .constant(UnitName.multiSteps))
}
