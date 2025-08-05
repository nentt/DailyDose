//
//  GoalSetterCard.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 05/08/2025.
//

import SwiftUI

struct GoalSetterCard: View {
    @Binding var habitGoal: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blackCopy)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .cornerRadius(50)
                .opacity(0.1)
            
            VStack(alignment: .leading) {
                Text("Define your goal:")
                    .font(.custom("Syne-SemiBold", size: 20))
                    .padding(.horizontal, 20)
                    .padding(.top, 35)

                Spacer(minLength: 10)

                VStack {
                    Text("\(habitGoal)")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.yellowButton)
                        .font(.custom("Syne-ExtraBold", size: 35))

                    HStack {
                        Button(action: {
                            if habitGoal > 1 {
                                habitGoal -= 1
                            }
                        }) {
                            Image(systemName: "minus")
                                .font(.system(size: 25))
                                .foregroundColor(.blackCopy)
                                .frame(width: 50, height: 50)
                                .background(Circle().fill(Color.yellowButton))
                                .padding(.horizontal, 10)
                        }

                        Button(action: {
                            if habitGoal < 100 {
                                habitGoal += 1
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 25))
                                .foregroundColor(.blackCopy)
                                .frame(width: 50, height: 50)
                                .background(Circle().fill(Color.yellowButton))
                                .padding(.horizontal, 10)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .padding(.bottom, 20)

                Spacer(minLength: 10)
            }
            .frame(height: 250)  
        }
    }
}

#Preview {
    GoalSetterCard(habitGoal: .constant(1))
}
