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
                TextField(Constants.enterNumberPlaceholder, text: $userInput)
                    .focused($isFocused)
                    .keyboardType(.numberPad)
                    .padding(Constants.textFieldPadding)
                    .background(Constants.textFieldBackground)
                    .cornerRadius(Constants.cornerRadius)
                    .padding()
                
                // MARK: - Get Fact Button
                Button {
                    isFocused = false
                    Task {
                        await viewModel.getFact(by: userInput)
                    }
                } label: {
                    Text(Constants.getFactTitle)
                        .foregroundStyle(Constants.buttonTextColor)
                        .frame(width: Constants.buttonWidth)
                        .padding(Constants.textFieldPadding)
                        .background(userInput.isEmpty ? Constants.disabledButtonColor : Constants.primaryButtonColor)
                        .cornerRadius(Constants.cornerRadius)
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
                        Text(Constants.getRandomFactTitle)
                            .foregroundStyle(Constants.buttonTextColor)
                            .frame(width: Constants.buttonWidth)
                            .padding(Constants.textFieldPadding)
                            .background(Constants.primaryButtonColor)
                            .cornerRadius(Constants.cornerRadius)
                    }
                }
                
                // MARK: - Loading Indicator
                ProgressView()
                    .padding(Constants.progressPadding)
                    .cornerRadius(Constants.cornerRadius)
                    .opacity(viewModel.isLoading ? 1 : 0)
                
                // MARK: - History Section
                List {
                    Section(header: viewModel.history.isEmpty ? nil : Text(Constants.historyTitle)
                        .font(.system(size: Constants.headerFontSize, weight: .bold))
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
            
            // MARK: - Show Errow
            .overlay(alignment: .top) {
                if viewModel.loadFailed {
                    showErrorBanner()
                }
            }
            .animation(.easeInOut(duration: Constants.animationDuration), value: viewModel.loadFailed)
        }
    }
    
    // MARK: - Private Methods
    @ViewBuilder
    private func showErrorBanner() -> some View {
        VStack {
            Text(Constants.errorMessage)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(Constants.cornerRadius)
                .padding()
                .onTapGesture {
                    withAnimation {
                        viewModel.loadFailed = false
                    }
                }
            Spacer()
        }
        .transition(.move(edge: .top))
    }
}
