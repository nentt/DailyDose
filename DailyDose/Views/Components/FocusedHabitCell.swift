//
//  FocusedHabitCell.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 25/01/2026.
//

import SwiftUI

struct FocusedHabitCell: View {
    let habit: Habit
    let geoWidth: Double
    
    var body: some View {
        ZStack {
            VStack {
                switch habit.image {
                case.asset(let name):
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(
                            LinearGradient(
                                colors: [
                                    Color.white,
                                    Color.black.opacity(0.0)
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
//                        .overlay(
//                            LinearGradient(
//                                colors: [
//                                    Color.gray,
//                                    Color.black.opacity(0.0)
//                                ],
//                                startPoint: .bottom,
//                                endPoint: .center
//                            )
//                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                case.user(let uiImage):
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 410)
                        .clipShape(RoundedRectangle(cornerRadius: 45))
                case.none:
                    Image(systemName: "photo")
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.blackCopy.opacity(0.4))
                }
            }
            VStack {
                VariableBlurView(maxBlurRadius: 20)
            }
        }
        .frame(height: 410)
        .frame(width: geoWidth / 2 - 4)
        .overlay(alignment: .topLeading){
            Text("KEEP TRACKING")
                .font(.custom("Syne-SemiBold", size: 14))
                .foregroundStyle(.blackCopy)
                .frame(width: 100)
                .multilineTextAlignment(.leading)
                .padding(.top, 10)
                .padding(.leading, 5)
            
        }
        .overlay(alignment: .topTrailing){
            Image(systemName: "arrow.up.right")
                .font(.system(size: 25))
                .foregroundColor(.blackCopy)
                .padding(.top, 10)
                .padding(.trailing, 10)
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading) {
                Text(habit.title.firstUppercased)
                    .font(.custom("Syne-Bold", size: 33))
                    .foregroundColor(.yellowButton)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 10)
                
                Text(habit.periodicity.description)
                    .font(.custom("Syne-Regular", size: 14))
                    .foregroundColor(.yellowButton)
                    .multilineTextAlignment(.leading) 
                    .padding(.leading, 10)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    FocusedHabitCell(habit: Habit(title: "Drink water", progress: 6, objective: 2, periodicity: .weekly(.hours(2)), unit: .hours(2), image: .asset("drink water")), geoWidth: 700)
}

