//
//  Habit.swift
//  DailyDose
//
//  Created by Audrey Penninckx on 02/06/2025.
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let progress: Int
    let objective: Int
    let periodicity: HabitPeriodicity
    let image: HabitImage = .none
    
    static let sampleHabits: [Habit] = [
        Habit(title: "No sugar", progress: 6, objective: 30, periodicity: .challenge(.months(1))),
        Habit(title: "Read book", progress: 2, objective: 4, periodicity: .weekly(.hours(1))),
        Habit(title: "News podcast", progress: 2, objective: 4, periodicity: .daily(.minutes(15))),
        Habit(title: "75 Hard challenge", progress: 2, objective: 4, periodicity: .challenge(.days(75))),
        Habit(title: "Learn EN words", progress: 5, objective: 50, periodicity: .weekly(.custom(5, "words")))
    ]
        
    
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
    case weeks(Int)
    case months(Int)
    case times(Int)
    case custom(Int, String)
    
    var description: String {
        switch self {
        case .minutes(let recurrence):
            return recurrence.pluralized("min")
        case .hours(let recurrence):
            return recurrence.pluralized("hour")
        case .days(let recurrence):
            return recurrence.pluralized("day")
        case .weeks(let recurrence):
            return recurrence.pluralized("weeks")
        case .months(let recurrence):
            return recurrence.pluralized("month")
        case .times(let recurrence):
            return recurrence.pluralized("times")
        case .custom(let recurrence, let unit):
            return "\(recurrence) \(unit)"
        }
    }
    
    var recurrenceCell: String {
        switch self {
        case .minutes:
            return "minutes"
        case .hours:
            return "hours"
        case .days:
            return "days"
        case .weeks:
            return "weeks"
        case .months:
            return "months"
        case .times:
            return "times"
        case .custom:
            return "other"
        }
    }
}

enum HabitImage: Hashable {
    case asset(String)
    case user(UIImage)
    case none
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

extension HabitPeriodicity.Kind {
    var label: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .challenge: return "challenge"

        }
    }
}

extension Unit {
    static var allDefaults: [Unit] {
        [.minutes(5), .hours(1), .days(7), .weeks(3), .months(1), .times(1)]
    }
}


