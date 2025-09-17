//
//  NumbersDataBaseManager.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//

import Foundation
import CoreData

protocol LocalDataStorable: AnyObject {
    func addNumberFact(number: String, fact: String)
    func allFacts() -> [NumberFact]
}

final class NumbersDataBaseManager: LocalDataStorable {
    // MARK: - Properties
    private let coreDataStack = CoreDataStackImplementation.shared
    
    private(set) lazy var backgroundManagedContext = coreDataStack.persistentContainer.newBackgroundContext()
    
    // MARK: - Initialization
    init() {
        backgroundManagedContext.automaticallyMergesChangesFromParent = true
        backgroundManagedContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    // MARK: - Protocol Method(s)
    func addNumberFact(number: String, fact: String) {
        backgroundManagedContext.performAndWait {
            let numberFactObject = NumberFact(context: backgroundManagedContext)
            numberFactObject.number = number
            numberFactObject.fact = fact
            saveBackgroundManagedContext()
        }
    }
    
    func allFacts() -> [NumberFact] {
        var numberFacts = [NumberFact]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NumberFact")
        
        backgroundManagedContext.performAndWait {
            do {
                let fetchedObjects = try backgroundManagedContext.fetch(request) as? [NumberFact]
                numberFacts = fetchedObjects ?? [NumberFact]()
            } catch {
                print(error)
            }
        }
        
        return numberFacts
    }
    
    // MARK: - Private Methods
    private func saveBackgroundManagedContext() {
        if backgroundManagedContext.hasChanges {
            do {
                try backgroundManagedContext.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
