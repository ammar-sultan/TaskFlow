//
//  TaskViewModel.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        loadTasks()
    }
    
    func addTask(name: String, dueDate: Date) {
        let newTask = Task(name: name, dueDate: dueDate, isCompleted: false)
        tasks.append(newTask)
        saveTasks()
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func markTaskAsCompleted(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
            saveTasks()
        }
    }
    
    func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "tasks")
        } catch {
            print("Failed to save tasks: \(error)")
        }
    }
    
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            do {
                tasks = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print("Failed to load tasks: \(error)")
            }
        }
    }
}
