//
//  NumberFact+CoreDataProperties.swift
//  Numbers_TestTask_Nechvola
//
//  Created by Rush_user on 16.09.2025.
//
//

import Foundation
import CoreData


extension NumberFact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NumberFact> {
        return NSFetchRequest<NumberFact>(entityName: "NumberFact")
    }

    @NSManaged public var number: String
    @NSManaged public var fact: String

}

extension NumberFact : Identifiable {

}
