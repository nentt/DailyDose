//
//  HabitView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 02/06/2025.
//

import SwiftUI

struct HabitCell: View {
    let habit: Habit
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                switch habit.image {
                case.asset(let name):
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 45))
                case.user(let uiImage):
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 45))
                case.none:
                    Image(systemName: "photo")
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.blackCopy.opacity(0.4))
                }
                VStack {
                        HStack {
                            Spacer()
                        
                            Image(systemName: "arrow.up.right")
                                    .font(.system(size: 25))
                                    .foregroundColor(.blackCopy)
                                    .frame(width: 50, height: 50)
                                    .background(Circle().fill(Color.yellowButton))
                                    .padding(20)
                        }
                        Spacer()
                    }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(habit.title.firstUppercased)
                        .font(.custom("Syne-SemiBold", size: 19))
                    
                    Text(habit.periodicity.description)
                        .font(.custom("Syne-Regular", size: 14))
                        .foregroundColor(.blackCopy.opacity(0.8))
                }
                Spacer()
                Image(systemName: "circle")
                    .font(.system(size: 35, weight: .thin))
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .padding(.top, 5)
        .foregroundStyle(.blackCopy)
        .padding(10)
        .frame(maxWidth: .infinity)
        .frame(height: 450)
        .background(.blackCopy.opacity(0.05))
        .cornerRadius(50)
    }
}

extension String {
    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
}
#Preview {
    VStack {
        HabitCell(habit: Habit(title: "pilates", progress: 6, objective: 2, periodicity: .weekly(.hours(2)), unit: .hours(2), image: .asset("run")))
    }
    .padding()

}
