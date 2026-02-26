//
//  MultiStepsPicker.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 23/02/2026.
//

import SwiftUI

enum Side {
    case minus
    case plus
}

struct MultiStepsPicker: View {
    @Binding var goalNumber: Int
    @State private var selectedSide: Side = .plus
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(Color.mauveBackground)
                .frame(height: 45)
            
            HStack {
                Image(systemName: "minus")
                    .font(.custom("Syne-Regular", size: 20))
                    .foregroundColor(selectedSide == .minus ? .blackCopy : .blackCopy.opacity(0.2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if goalNumber > 1 {
                            selectedSide = .minus
                            goalNumber -= 1
                        }
                    }
                
                Text("\(goalNumber)")
                    .frame(width: 120)
                    .font(.custom("Syne-Regular", size: 25))
                    .padding(.bottom, 5)
                
                VStack {
                    Image(systemName: "plus")
                        .font(.custom("Syne-Regular", size: 20))
                        .foregroundStyle(selectedSide == .plus ? .blackCopy : .blackCopy.opacity(0.2))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedSide = .plus
                            goalNumber += 1
                        }
                }
                .frame(height: 50)
            }
            
        }
        .frame(height: 60)
    }
}

#Preview {
    MultiStepsPicker(goalNumber: .constant(5))
}
