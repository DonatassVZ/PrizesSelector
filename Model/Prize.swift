//
//  Prize.swift
//  PrizesSelector
//
//  Created by Vasiliy Munenko on 25.05.2021.
//

import Foundation
import RealmSwift


final class Prize: Object , ObjectKeyIdentifiable {
    
    @objc dynamic var _id = ObjectId.generate()
    
    @objc dynamic var name : String  = Prize.randomPrize()
    @objc dynamic var price : Int = Int.random(in: 10...45)
    
    @objc dynamic var selected : Bool = false
    @objc dynamic var selectedDate : Date? = nil
    
    
    // backlink to PrizeGroup
    var group = LinkingObjects(fromType: PrizeGroup.self , property: "items")
   
    // ovveride primarykey
    override class func primaryKey() -> String? {
            "_id"
    }
    
    static func randomPrize() -> String {
        let randomNames = ["lambo", "monitor", "tea", "coffe", "ice-cream", "bread" , "pencil" , "coca-cola"]
        return randomNames.randomElement() ?? "new item"
    }
    
    
    
    func update(selected : Bool ) {
        if let realm = self.realm {
            try? realm.write{
                self.selected = selected
                
                if selected == true {
                    self.selectedDate = Date()
                }else{
                    self.selectedDate = nil
                }
            }
        }else{
            self.selected = selected
            
            if selected == true {
                self.selectedDate = Date()
            }else{
                self.selectedDate = nil
            }
        }
    }
    
    
}
