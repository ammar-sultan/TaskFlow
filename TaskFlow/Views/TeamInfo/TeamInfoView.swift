//
//  TeamInfoView.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI

struct TeamInfoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header Section
                VStack(spacing: 15) {
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                    
                    Text("Team Information")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                }
                .padding(.top, 30)
                
                // Team Members Section
                InfoCardView(
                    icon: "person.fill",
                    title: "Team Members",
                    content: VStack(alignment: .leading, spacing: 12) {
                        MemberRow(name: "Ammar Sultan", studentID: "101296759")
                        MemberRow(name: "Qinxi Liu", studentID: "101415216")
                    }
                )
                
                // Course Information Section
                InfoCardView(
                    icon: "book.fill",
                    title: "Course Details",
                    content: VStack(alignment: .leading, spacing: 8) {
                        DetailRow(label: "Course:", value: "COMP 3097")
                        DetailRow(label: "CRN:", value: "50492")
                    }
                )
                
                // Project Description Section
                InfoCardView(
                    icon: "doc.text.fill",
                    title: "Project Description",
                    content: Text("TTask Flow is a simple, yet effective to-do list application designed to help users manage their tasks efficiently.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(5)
                )
                
                // Version Info
                Text("TaskFlow v1.0.0")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top)
            }
            .padding(.horizontal)
        }
        .navigationTitle("About the Team")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

// MARK: - Custom Views

struct InfoCardView<Content: View>: View {
    let icon: String
    let title: String
    let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .imageScale(.large)
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct MemberRow: View {
    let name: String
    let studentID: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "person.crop.circle.fill")
                .foregroundColor(.blue)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(studentID)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct TeamInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TeamInfoView()
        }
    }
}
