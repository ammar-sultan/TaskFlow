//
//  TaskDetailView.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI

struct TaskDetailView: View {
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerSection
            detailsCard
            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Task Details")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .foregroundColor(.primary)
            
            Divider()
                .padding(.vertical, 8)
        }
    }
    
    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            detailRow(icon: "text.book.closed", title: "TASK", value: task.name)
            detailRow(icon: "calendar", title: "DUE DATE", value: task.dueDate.formatted())
            statusBadge
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
    
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title.uppercased())
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
    }
    
    private var statusBadge: some View {
        HStack(spacing: 8) {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                .foregroundColor(task.isCompleted ? .green : .orange)
            
            Text(task.isCompleted ? "Completed" : "In Progress")
                .font(.system(.subheadline, design: .rounded))
                .bold()
                .foregroundColor(task.isCompleted ? .green : .orange)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            Capsule()
                .fill((task.isCompleted ? Color.green : Color.orange).opacity(0.1))
        )
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(name: "Test Task", dueDate: Date(), isCompleted: false))
    }
}
