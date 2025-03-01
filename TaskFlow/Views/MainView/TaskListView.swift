//
//  TaskListView.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.tasks.isEmpty {
                    emptyStateView
                } else {
                    taskList
                }
            }
            .navigationTitle("TaskFlow")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    addButton
                }
                // Adding a button for Team Info
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: TeamInfoView()) {
                        Text("About Team")
                            .font(.headline)
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
    
    private var taskList: some View {
        List {
            ForEach(viewModel.tasks) { task in
                NavigationLink(destination: TaskDetailView(task: task)) {
                    TaskCell(task: task)
                        .padding(.vertical, 8)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        viewModel.markTaskAsCompleted(task)
                    } label: {
                        Label(task.isCompleted ? "Undo" : "Complete",
                              systemImage: task.isCompleted ? "arrow.uturn.backward" : "checkmark")
                    }
                    .tint(task.isCompleted ? .orange : .green)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        deleteTask(task)
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
            }
        }
        .listStyle(.plain)
        .background(Color(.systemGroupedBackground))
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checklist")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            Text("No Tasks Found")
                .font(.title2)
                .foregroundColor(.secondary)
            Text("Tap the + button to add your first task")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var addButton: some View {
        Button {
            showingAddTask.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.title2)
                .symbolRenderingMode(.hierarchical)
        }
    }
    
    private func deleteTask(_ task: Task) {
        withAnimation {
            if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                viewModel.deleteTask(at: IndexSet([index]))
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

