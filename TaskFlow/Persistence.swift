//
//  Persistence.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import CoreData
import Foundation

class Persistence {
    static let shared = Persistence()

    private init() {}
    
    func saveTasks(_ tasks: [Task]) {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "tasks")
        } catch {
            print("Error saving tasks: \(error)")
        }
    }

    func loadTasks() -> [Task] {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            do {
                return try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print("Error loading tasks: \(error)")
            }
        }
        return []
    }
}
