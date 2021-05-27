//
//  PrizeGroup.swift
//  PrizesSelector
//
//  Created by Vasiliy Munenko on 27.05.2021.
//

import Foundation
import RealmSwift

final class PrizeGroup : Object ,  ObjectKeyIdentifiable {
    
    @objc dynamic var _id = ObjectId.generate()
    
    override class func primaryKey() -> String? {
            "_id"
    }
    
    var items = RealmSwift.List<Prize>()
    
}
