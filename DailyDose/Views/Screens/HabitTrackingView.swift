//
//  HabitTrackingView.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 16/12/2025.
//

import SwiftUI

struct HabitTrackingView: View {
    let habit: Habit
    @State private var isTracking = false
    @State private var showEndButton = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var buttonOffset: CGFloat = 0
    @State private var elapsedSeconds: Int = 7350
    @State private var startDate: Date?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var stopTimer = false
    
    
    var hours: Int {
        elapsedSeconds / 3600
    }
    var minutes: Int {
        (elapsedSeconds % 3600) / 60
    }
    var seconds: Int {
        elapsedSeconds % 60
    }
    
    
    var body: some View {
        ZStack {
            switch habit.image {
            case .asset(let name):
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 15)
            case .user(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            case .none:
                Color(.blackCopy)
                    .ignoresSafeArea()
            }
            switch habit.unit {
            case.minutes(_), .hours(_):
                timeView
            default:
                otherUnits
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                VStack(alignment: .leading) {
                    Text("\(habit.title.uppercased())")
                        .font(.custom("Syne-Bold", size: 17))
                        .foregroundColor(.white)
                    Text("\(habit.unit.description)")
                        .font(.custom("Syne-Bold", size: 14))
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 12) {
                    Button {
                        // menu
                    } label: {
                        HStack(spacing: 4) {
                            Circle().stroke(lineWidth: 2).frame(width: 6, height: 6)
                            Circle().stroke(lineWidth: 2).frame(width: 6, height: 6)
                            Circle().stroke(lineWidth: 2).frame(width: 6, height: 6)
                        }
                    }
                    
                    Button {
                        // close
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                .foregroundColor(.white)
            }
        }
        .onReceive(timer) { _ in
            guard isTracking, let startDate else {
                return
            }
            elapsedSeconds = Int(Date().timeIntervalSince(startDate))
        }
    }
    
    //MARK: Minutes & Hours View
    
    var timeView: some View {
        VStack {
            
            VStack {
                
                Spacer()
                
                
                HStack {
                    TimeUnitText(
                        value: hours,
                        isActive: elapsedSeconds >= 3600
                    )
                    
                    TimeSeparator()
                    
                    TimeUnitText(
                        value: minutes,
                        isActive: elapsedSeconds >= 60
                    )
                    
                    TimeSeparator()
                    
                    TimeUnitText(
                        value: seconds,
                        isActive: true
                    )
                }
                
                
                Text("Finish in ")
                    .font(.custom("Syne-ExtraBold", size: 15))
                    .foregroundColor(.mauveBackground)
                Spacer()
                
                VStack {
                    Button {
                        if isTracking {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                isTracking = false
                                buttonScale = 1.5
                                buttonOffset = -100
                                showEndButton = true
                            }
                        } else {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                isTracking = true
                                buttonScale = 1.0
                                buttonOffset = 0
                                showEndButton = false
                            }
                        }
                        startDate = Date().addingTimeInterval(-Double(elapsedSeconds))
                    } label: {
                        Image(systemName: isTracking ? "pause.fill" : "play.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blackCopy)
                            .frame(width: 80, height: 80)
                            .background(Circle().fill(Color.yellowButton))
                            .overlay(
                                Circle()
                                    .stroke(Color.yellowButton.opacity(0.4), lineWidth: 10)
                                    .frame(width: 80, height: 80)
                            )
                            .padding(.horizontal, 5)
                    }
                    .scaleEffect(buttonScale)
                    .offset(y: buttonOffset)
                    .padding(.bottom, 20)
                    
                    if showEndButton {
                        HStack {
                            Button(action: {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    startDate = nil
                                    buttonScale = 1.0
                                    buttonOffset = 0
                                    showEndButton = false
                                    isTracking = false
                                }
                                elapsedSeconds = 0
                            }, label: {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 30))
                                    .foregroundColor(.blackCopy)
                                    .frame(width: 80, height: 80)
                                    .background(Circle().fill(Color.white))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white.opacity(0.4), lineWidth: 10)
                                            .frame(width: 80, height: 80)
                                    )
                                    .padding(.horizontal, 5)
                            })
                            .transition(.move(edge: .bottom))
                            
                            Button(action: {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    startDate = nil
                                    buttonScale = 1.0
                                    buttonOffset = 0
                                    showEndButton = false
                                    isTracking = false
                                }
                                withAnimation(.easeInOut(duration: 1.6)) {
                                    stopTimer = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    withAnimation(.easeInOut(duration: 1.6)) {
                                        stopTimer = false
                                    }
                                }
                            }, label: {
                                Image(systemName: "stop")
                                    .font(.system(size: 30))
                                    .foregroundColor(.blackCopy)
                                    .frame(width: 80, height: 80)
                                    .background(Circle().fill(Color.white))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white.opacity(0.4), lineWidth: 10)
                                            .frame(width: 80, height: 80)
                                    )
                                    .padding(.horizontal, 5)
                                
                            })
                            .transition(.move(edge: .bottom))
                            
                            
                        }
                        .padding()
                    }
                }
            }
        }
        .overlay(content: {
            if stopTimer && elapsedSeconds > 0 {
                VStack {
                    Text("\(timeFormatSentence())")
                        .font(.custom("Syne-ExtraBold", size: 24))
                        .foregroundStyle(.mauveBackground)
                        .padding(.bottom, 10)
                    Text("ADDED TO YOUR DAY!")
                        .font(.custom("Syne-Bold", size: 19))
                        .foregroundStyle(.yellowButton)
                        
                        .padding(.bottom, 70)
                }
                .frame(height: 30)
                .offset(y: 120)
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    )
                )
                
            }
        })
        .padding()
    }
    
    //MARK: Other Units View
    
    var otherUnits: some View {
        VStack {
            Text("hello")
        }
    }
    
    
    func timeFormatSentence() -> Text {
        if elapsedSeconds > 3600 {
            if hours > 0 && minutes == 0 {
                return Text(String(format: elapsedSeconds > 3600 && elapsedSeconds < 7200 ? "\(hours) HOUR" : "\(hours) HOURS", hours))
            } else {
                return Text(String(format: "\(hours)h\(String(format: "%02d", minutes))", minutes))
            }
        } else if elapsedSeconds > 60 && elapsedSeconds < 3600 {
            if seconds == 0 {
                return Text(String(format: "\(minutes) MIN", minutes))
            } else {
                return Text(String(format: "\(minutes):\(String(format: "%02d", seconds))", seconds))
            }
        } else {
            return Text(String(format: "\(seconds) SEC", seconds))
        }
    }
}


struct TimeUnitText: View {
    let value: Int
    let isActive: Bool
    
    var body: some View {
        Text(String(format: "%02d", value))
            .font(.custom("Syne-ExtraBold", size: 30))
            .foregroundColor(isActive ? .yellowButton : .yellowButton.opacity(0.3))
    }
}

struct TimeSeparator: View {
    
    var body: some View {
        Text(":")
            .font(.custom("Syne-ExtraBold", size: 30))
            .foregroundColor(.yellowButton.opacity(0.5))
            .padding(.horizontal, 4)
    }
}

#Preview {
    HabitTrackingView(habit: Habit(title: "Run", progress: 30, objective: 30, periodicity: .challenge(.days(30)), unit: .days(30), image: .asset("running")))
}
