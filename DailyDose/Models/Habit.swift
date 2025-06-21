//
//  Habit.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 02/06/2025.
//

import Foundation

struct Habit: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let progress: Int
    let objective: Int
    let periodicity: HabitPeriodicity
}

enum HabitPeriodicity: Hashable {
    case daily(Unit)
    case weekly(Unit)
    case challenge(Unit)
    
    var description: String {
        switch self {
        case .daily(let time):
            return "\(time.description) daily"
        case .weekly(let time):
            return "\(time.description) weekly"
        case .challenge(let time):
            return "\(time.description) challenge"
        }
    }
}

enum Unit: Hashable {
    case minutes(Int)
    case hours(Int)
    case days(Int)
    case months(Int)
    case custom(Int, String)
    
    var description: String {
        switch self {
        case .minutes(let value):
            return value.pluralized("min")
        case .hours(let value):
            return value.pluralized("hour")
        case .days(let value):
            return value.pluralized("day")
        case .months(let value):
            return value.pluralized("month")
        case .custom(let value, let unit):
            return "\(value) \(unit)"
        }
    }
}

extension Int {
    func pluralized(_ word: String) -> String {
        return self == 1 ? "\(self) \(word)" : "\(self) \(word)s"
    }
}

extension HabitPeriodicity {
    enum Kind {
        case daily, weekly, challenge
    }
    
    var kind: Kind {
        switch self {
        case .daily: return .daily
        case .weekly: return .weekly
        case .challenge: return .challenge 
        }
    }
}


