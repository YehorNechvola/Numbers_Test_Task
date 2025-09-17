//
//  BaseRequestService.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import Foundation

// MARK: - Custom Error
enum CustomError: Error {
    case invalidURL
    case decodingError(String)
    case networkError(String)
}

// MARK: - BaseRequestServiceProtocol
protocol BaseRequestServiceProtocol {
    func getDataModel<DataModel: Decodable>(url: URL?, model: DataModel.Type) async -> Result<DataModel, CustomError>
}

// MARK: - BaseRequestService
class BaseRequestService: BaseRequestServiceProtocol {
    
    // MARK: - Protocol Methods
    func getDataModel<DataModel: Decodable>(url: URL?, model: DataModel.Type) async -> Result<DataModel, CustomError> {
        guard let url else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                return .failure(.networkError(String(httpResponse.statusCode)))
            }
            
            if DataModel.self == String.self {
                return decodeSimpleString(from: data, encoding: .utf8)
            } else {
                let decodedData = try JSONDecoder().decode(DataModel.self, from: data)
                return .success(decodedData)
            }
        } catch {
            return .failure(.networkError(error.localizedDescription))
        }
    }
    
    // MARK: - Private Methods
    private func decodeSimpleString<DataModel: Decodable>(from data: Data, encoding: String.Encoding,) -> Result<DataModel, CustomError> {
        if let text = String(data: data, encoding: encoding) as? DataModel {
            return .success(text)
        } else {
            return .failure(.decodingError("Error decoding data"))
        }
    }
}

