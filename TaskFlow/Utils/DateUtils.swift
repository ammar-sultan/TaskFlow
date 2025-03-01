//
//  DateUtils.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//


import Foundation

// DateFormatter extension
extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

// DateUtils class with helper functions
class DateUtils {
    static func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    static func isTaskOverdue(task: Task) -> Bool {
        return task.dueDate < Date() && !task.isCompleted
    }
}
