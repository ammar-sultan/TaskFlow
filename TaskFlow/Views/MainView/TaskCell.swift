//
//  TaskCell.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI

struct TaskCell: View {
    var task: Task
    
    var body: some View {
        HStack(spacing: 16) {
            statusIcon
            taskDetails
            Spacer()
            dueDateLabel
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal, 8)
        .opacity(task.isCompleted ? 0.6 : 1)
    }
    
    private var statusIcon: some View {
        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
            .foregroundColor(task.isCompleted ? .green : .orange)
            .font(.title2)
    }
    
    private var taskDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(task.name)
                .font(.system(.body, design: .rounded))
                .foregroundColor(task.isCompleted ? .secondary : .primary)
                .strikethrough(task.isCompleted, color: .secondary)
            
            Text("Due \(task.dueDate.formatted(.relative(presentation: .named)))")
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.gray)
        }
    }
    
    private var dueDateLabel: some View {
        Text(task.dueDate, style: .date)
            .font(.system(.caption, design: .rounded))
            .foregroundColor(.secondary)
            .padding(8)
            .background(
                Capsule()
                    .fill(Color(.systemGray5))
            )
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: Task(name: "Test Task", dueDate: Date(), isCompleted: false))
            .previewLayout(.sizeThatFits)
    }
}
