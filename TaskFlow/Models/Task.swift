//
//  Task.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var name: String
    var dueDate: Date
    var isCompleted: Bool
}
