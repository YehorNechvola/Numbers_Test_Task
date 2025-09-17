//
//  DependencyBuilder.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import Foundation

final class DependencyBuilder {
    
    @MainActor
    static func createChooseNumberViewModel() -> ChooseNumberViewModel {
        let baseRequestService = BaseRequestService()
        let numberFactService = NumberFactService(baseRequestService: baseRequestService)
        let numbersDataBaseManager = NumbersDataBaseManager()
        
        return ChooseNumberViewModel(numberFactService: numberFactService,
                                     numberFactsDataBaseManager: numbersDataBaseManager)
    }
    
    static func createDetailFactViewModel(_ fact: NumberFact) -> DetailFactViewModel {
        return DetailFactViewModel(numberFact: fact)
    }
}
