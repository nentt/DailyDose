//
//  CustomFrequencyPicker.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 14/10/2025.
//

import SwiftUI

enum Frequency: String, CaseIterable {
    case daily = "daily"
    case weekly = "weekly"
    case monthly = "monthly"
}

struct CustomFrequencyPicker: View {
    @Binding var selectedFrequency: Frequency
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Frequency.allCases, id: \.rawValue) { frequency in
                ZStack {
                    if selectedFrequency == frequency {
                        Capsule()
                            .fill(Color.yellowButton)
                            .matchedGeometryEffect(id: "frequencyBackground", in: animation)
                            .frame(height: 45)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: selectedFrequency)
                    }
                    
                    Text(frequency.rawValue.uppercased())
                        .frame(width: 100)
                        .font(.custom("Syne-Regular", size: 17))
                        .foregroundStyle(selectedFrequency == frequency ? .blackCopy : .blackCopy.opacity(0.5))
                        .bold(selectedFrequency == frequency)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                        selectedFrequency = frequency
                }
            }
        }
        .padding(6)
        .background(
            Capsule()
                .fill(Color.blackCopy.opacity(0.1))
        )
    }
}

#Preview {
    CustomFrequencyPicker(selectedFrequency: .constant(Frequency.daily))
}




