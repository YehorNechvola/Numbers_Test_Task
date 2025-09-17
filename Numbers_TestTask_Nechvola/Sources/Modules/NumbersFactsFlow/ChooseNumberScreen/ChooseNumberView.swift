//
//  ChooseNumberView.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import SwiftUI

// MARK: - Main View
struct ChooseNumberView: View {
    
    // MARK: - ViewModel
    @StateObject private var viewModel = DependencyBuilder.createChooseNumberViewModel()
    
    // MARK: - State Properties
    @State private var userInput = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack(alignment: .center) {
                
                // MARK: - Number Input Field
                TextField(ChooseNumberConstants.enterNumberPlaceholder, text: $userInput)
                    .focused($isFocused)
                    .keyboardType(.numberPad)
                    .padding(ChooseNumberConstants.textFieldPadding)
                    .background(ChooseNumberConstants.textFieldBackground)
                    .cornerRadius(ChooseNumberConstants.cornerRadius)
                    .padding()
                
                // MARK: - Get Fact Button
                Button {
                    isFocused = false
                    Task {
                        await viewModel.getFact(by: userInput)
                    }
                } label: {
                    Text(ChooseNumberConstants.getFactTitle)
                        .foregroundStyle(ChooseNumberConstants.buttonTextColor)
                        .frame(width: ChooseNumberConstants.buttonWidth)
                        .padding(ChooseNumberConstants.textFieldPadding)
                        .background(userInput.isEmpty ? ChooseNumberConstants.disabledButtonColor : ChooseNumberConstants.primaryButtonColor)
                        .cornerRadius(ChooseNumberConstants.cornerRadius)
                        .disabled(userInput.isEmpty)
                }
                
                // MARK: - Get Random Fact Button
                Button {
                    isFocused = false
                    Task {
                        await viewModel.getRandomFact()
                    }
                } label: {
                    HStack {
                        Text(ChooseNumberConstants.getRandomFactTitle)
                            .foregroundStyle(ChooseNumberConstants.buttonTextColor)
                            .frame(width: ChooseNumberConstants.buttonWidth)
                            .padding(ChooseNumberConstants.textFieldPadding)
                            .background(ChooseNumberConstants.primaryButtonColor)
                            .cornerRadius(ChooseNumberConstants.cornerRadius)
                    }
                }
                
                // MARK: - Loading Indicator
                ProgressView()
                    .padding(ChooseNumberConstants.progressPadding)
                    .cornerRadius(ChooseNumberConstants.cornerRadius)
                    .opacity(viewModel.isLoading ? 1 : 0)
                
                // MARK: - History Section
                List {
                    Section(header: viewModel.history.isEmpty ? nil : Text(ChooseNumberConstants.historyTitle)
                        .font(.system(size: ChooseNumberConstants.headerFontSize, weight: .bold))
                    ) {
                        ForEach(viewModel.history, id: \.self) { item in
                            Text(item.fact)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .onTapGesture {
                                    viewModel.numberFactTapped(item)
                                }
                        }
                    }
                }
                .listStyle(.plain)
                
                Spacer()
            }
            
            // MARK: - Navigation to Detail Screen
            .navigationDestination(for: ChooseNumberViewModel.Route.self) { route in
                switch route {
                case .detail(let fact):
                    DetailFactView(fact: fact)
                }
            }
        }
    }
}
