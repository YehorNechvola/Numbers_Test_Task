//
//  DetailFactView.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import SwiftUI

struct DetailFactView: View {
    
    // MARK: - View Model
    @StateObject private var viewModel: DetailFactViewModel
    
    // MARK: - Init
    init(fact: NumberFact) {
        _viewModel = StateObject(wrappedValue: DependencyBuilder.createDetailFactViewModel(fact))
        
    }
    
    var body: some View {
        // MARK: - Detail Fact Text
        ScrollView {
            Text(viewModel.numberFact.fact)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(Constants.navigtionTitlePrefix + viewModel.numberFact.number)
    }
}
