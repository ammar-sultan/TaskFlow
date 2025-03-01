//
//  ContentView.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI
import UIKit


struct ContentView: View {
    var body: some View {
        TaskListView()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
