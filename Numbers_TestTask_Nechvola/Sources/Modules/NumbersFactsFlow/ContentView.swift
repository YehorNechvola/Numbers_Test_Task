//
//  ContentView.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import SwiftUI

struct ContentView: View {
    
    private let numbersService = NumberFactService(baseRequestService: BaseRequestService())
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
               let result = await numbersService.getRandomFact()
                switch result {
                    
                case .success(let value):
                    print("ResultValue \(value)")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
