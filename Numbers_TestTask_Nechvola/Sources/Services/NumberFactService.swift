//
//  NumberFactService.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import Foundation


protocol NumberFactServiceProtocol {
    func getFact(for number: Int) async -> Result<String, CustomError>
    func getRandomFact() async -> Result<String, CustomError>
}

final class NumberFactService: NumberFactServiceProtocol {
    
    // MARK: - Path
    private enum Path {
        case factByNumber(Int)
        case randomNumberFact
        
        var path: String {
            switch self {
            case .factByNumber(let number):
                return "http://numbersapi.com/\(number)"
            case .randomNumberFact:
                return "http://numbersapi.com/random/math"
            }
        }
    }
    
    // MARK: - Properties
    private let baseRequestService: BaseRequestServiceProtocol
    
    // MARK: - Init
    init(baseRequestService: BaseRequestServiceProtocol) {
        self.baseRequestService = baseRequestService
    }
    
    // MARK: - Protocol Methods
    func getFact(for number: Int) async -> Result<String, CustomError> {
        let url = URL(string: Path.factByNumber(number).path)
        
        return await baseRequestService.getDataModel(url: url, model: String.self)
    }
    
    func getRandomFact() async -> Result<String, CustomError> {
        let url = URL(string: Path.randomNumberFact.path)
        
        return await baseRequestService.getDataModel(url: url, model: String.self)
    }
}
