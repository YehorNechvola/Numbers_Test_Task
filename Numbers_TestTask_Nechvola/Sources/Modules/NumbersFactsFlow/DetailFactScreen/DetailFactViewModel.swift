//
//  DetailFactViewModel.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import Foundation

protocol DetailFactViewModelProtocol: ObservableObject {
    var numberFact: NumberFact { get }
}

final class DetailFactViewModel: DetailFactViewModelProtocol {
    
    // MARK: - Observed Properties
    var numberFact: NumberFact
    
    // MARK: - Init
    init(numberFact: NumberFact) {
        self.numberFact = numberFact
    }
}


