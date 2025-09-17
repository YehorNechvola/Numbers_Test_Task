//
//  ChooseNumberViewModel.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import Foundation

@MainActor
protocol ChooseNumberViewModelProtocol: ObservableObject {
    func getFact(by userInput: String) async
    func getRandomFact() async
    func numberFactTapped(_ item: NumberFact)
}

@MainActor
final class ChooseNumberViewModel: ChooseNumberViewModelProtocol {
    
    // MARK: - Navigation
    enum Route: Hashable {
        case detail(NumberFact)
    }
    
    // MARK: - Properties
    private let numberFactService: NumberFactServiceProtocol
    private let numberFactsDataBaseManager: LocalDataStorable
    private var hideErrorTask: Task<Void, Never>? = nil
    
    // MARK: - Observed Properties
    @Published var isLoading: Bool = false
    @Published var loadFailed: Bool = false
    @Published var history: [NumberFact] = []
    @Published var path: [Route] = []
    
    // MARK: - Init
    init(numberFactService: NumberFactServiceProtocol, numberFactsDataBaseManager: LocalDataStorable) {
        self.numberFactService = numberFactService
        self.numberFactsDataBaseManager = numberFactsDataBaseManager
        history = numberFactsDataBaseManager.allFacts().reversed()
    }
    
    // MARK: - Protocol Methods
    func getFact(by userInput: String) async {
        guard let userInputNumber = Int(userInput) else { return }
        loadFailed = false
        isLoading = true
        let result = await numberFactService.getFact(for: userInputNumber)
        handleResult(result)
    }
    
    func getRandomFact() async {
        loadFailed = false
        isLoading = true
        let result = await numberFactService.getRandomFact()
        handleResult(result)
    }
    
    func numberFactTapped(_ item: NumberFact) {
        path.append(.detail(item))
    }
    
    // MARK: - Private Methods
    private func handleResult(_ result: Result<String, CustomError>) {
        switch result {
        case .success(let fact):
            loadFailed = false
            let numberString = extractLeadingNumber(from: fact) ?? ""
            numberFactsDataBaseManager.addNumberFact(number: numberString, fact: fact)
            history = numberFactsDataBaseManager.allFacts().reversed()
        case .failure(let error):
            hideErrorTask?.cancel()
            loadFailed = true
            createErrorTask()
            
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    private func extractLeadingNumber(from string: String) -> String? {
        guard let numberString = string.split(separator: " ").first else {
            return nil
        }
        return String(numberString)
    }
    
    private func createErrorTask() {
        hideErrorTask = Task {
            do {
                try await Task.sleep(nanoseconds: 3_000_000_000)
                try Task.checkCancellation()
                
                await MainActor.run {
                    loadFailed = false
                }
            } catch {
                print("Task was canceled")
            }
        }
    }
}
