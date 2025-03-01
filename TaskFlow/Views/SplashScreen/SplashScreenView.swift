//
//  SplashScreenView.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI
import UIKit


struct SplashScreenView: View {
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.5
    @State private var textOpacity: Double = 0
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemTeal), Color(.systemIndigo)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if isActive {
                ContentView()
                    .transition(.opacity.combined(with: .scale))
            } else {
                VStack(spacing: 30) {
                    // Animated checklist icon
                    Image(systemName: "checklist")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .scaleEffect(logoScale)
                        .rotationEffect(.degrees(rotationAngle))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // Animated text
                    Text("TaskFlow")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(textOpacity)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
                }
                .padding()
            }
        }
        .onAppear {
            // Sequence animations
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                logoScale = 1.2
                rotationAngle = -5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    rotationAngle = 5
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    logoScale = 1.0
                    rotationAngle = 0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeIn(duration: 0.5)) {
                    textOpacity = 1
                }
            }
            
            // Transition to main content after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.isActive = true
                }
            }
        }
    }
}
