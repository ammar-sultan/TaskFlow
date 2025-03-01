//
//  AddTaskView.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI

struct AddTaskView: View {
    @State private var taskName: String = ""
    @State private var dueDate: Date = Date().endOfDay
    @ObservedObject var viewModel: TaskViewModel
    @State private var taskNameError: String? = nil
    @State private var dueDateError: String? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    inputFields
                    addButton
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.body.weight(.medium))
                }
            }
        }
    }
    
    // MARK: - View Components
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("New Task")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
            
            Divider()
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var inputFields: some View {
        VStack(spacing: 20) {
            nameField
            dateField
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
    
    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "text.book.closed")
                    .foregroundColor(.secondary)
                TextField("Task Name", text: $taskName)
                    .font(.system(.body, design: .rounded))
                    .autocapitalization(.sentences)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            
            if let error = taskNameError {
                errorLabel(text: error)
            }
        }
    }
    
    private var dateField: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.secondary)
                DatePicker(selection: $dueDate, in: Date().endOfDay..., displayedComponents: .date) {
                    Text("Due Date")
                        .font(.system(.body, design: .rounded))
                }
                .datePickerStyle(.compact)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            .onChange(of: dueDate) { newDate in
                dueDate = newDate.endOfDay
            }
            
            if let error = dueDateError {
                errorLabel(text: error)
            }
        }
    }
    
    private func errorLabel(text: String) -> some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.orange)
            Text(text)
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.orange)
        }
        .padding(.horizontal)
    }
    
    private var addButton: some View {
        Button {
            validateInputs()
        } label: {
            HStack {
                Text("Add Task")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                Image(systemName: "plus.circle.fill")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isFormValid ? Color.blue : Color.gray.opacity(0.3))
            )
            .foregroundColor(.white)
            .shadow(color: isFormValid ? Color.blue.opacity(0.4) : Color.clear, radius: 8, x: 0, y: 4)
        }
        .disabled(!isFormValid)
        .animation(.easeInOut, value: isFormValid)
    }
    
    // MARK: - Logic
    private var isFormValid: Bool {
        !taskName.isEmpty && taskNameError == nil && dueDateError == nil
    }
    
    private func validateInputs() {
        taskNameError = nil
        dueDateError = nil
        
        // Validate task name
        if taskName.isEmpty {
            taskNameError = "Please enter a task name."
        }
        
        // Validate due date
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let dueDateStart = calendar.startOfDay(for: dueDate)
        
        if dueDateStart < todayStart {
            dueDateError = "Due date cannot be in the past."
        }
        
        if taskNameError == nil && dueDateError == nil {
            viewModel.addTask(name: taskName, dueDate: dueDate)
            dismiss()
        }
    }
}

// MARK: - Date Extension
extension Date {
    var endOfDay: Date {
        Calendar.current.startOfDay(for: self).addingTimeInterval(86399)
    }
}

// MARK: - Preview
struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddTaskView(viewModel: TaskViewModel())
            AddTaskView(viewModel: TaskViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
