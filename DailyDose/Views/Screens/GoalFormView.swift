//
//  GoalFormView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 09/09/2025.
//

import SwiftUI

struct GoalFormView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.mauveBackground.ignoresSafeArea()
            VStack() {
                HStack(spacing: 0) {
                    Text("5")
                        .foregroundColor(.yellowButton.opacity(0.8))
                        .font(.custom("Syne-ExtraBold", size: 90))
                        .padding(.trailing, 20)
                    
                    VStack(alignment: .leading) {
                        Text("minutes")
                            .font(.custom("Syne-Regular", size: 17))
                            .foregroundColor(.primary)
                        
                        Text("daily")
                            .font(.custom("Syne-Regular", size: 17))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
                
                HStack {
                    Circle()
                        .fill(.blackCopy.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .fill(.blackCopy.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .fill(.blackCopy.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Circle()
                        .fill(.blackCopy.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Spacer()
                    
                    Circle()
                        .fill(.blackCopy.opacity(0.1))
                        .frame(width: 50, height: 50)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    ZStack {
                        Circle()
                            .fill(Color.blackCopy)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.yellowButton)
                    }
                    .padding(.top, 20)
                    
                })
                
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack(alignment: .trailing) {
                    
                    Text("set your goal")
                        .font(.custom("Syne-SemiBold", size: 17))
                        .foregroundColor(.blackCopy.opacity(0.4))
                        .textCase(.uppercase)
                        .padding(.top, 30)
                }
            }
        }
    }
}

#Preview {
    GoalFormView()
}
