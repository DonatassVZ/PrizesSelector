//
//  ListPrizesVM.swift
//  PrizesSelector
//
//  Created by Vasiliy Munenko on 25.05.2021.
//

import Foundation
import Combine
import RealmSwift


class PrizesViewModel: ObservableObject {
    
    @Published var openAddPage = false
    let basketLimit = 100
    private var baseElement = 5 // base element for 1st start application
    
    @Published var sumPrize : Int = 0{
        didSet{
            print("Did set new value \(sumPrize)")
            if sumPrize > basketLimit{
                unselectedPrize()
            }
        }
    }
///Realm variable
   
    @Published var items = List<Prize>()
    
    @Published var prizesGroup : PrizeGroup? = nil
    
    var token : NotificationToken? = nil
    
    var realm : Realm?
    

    
    init() {
        initRealm()
        
        token =  prizesGroup?.items.observe({ (changes) in
             switch changes{
             case .error(_) : break
             case.initial(_): break
             case .update(_, deletions: _, insertions: _, modifications: _):
                self.objectWillChange.send()
                
                self.sumPrize = self.items.filter({ $0.selected == true }).map{Int($0.price)}.reduce(0,+)
             }
         })
        
        sumPrize = items.filter({ $0.selected == true }).map{Int($0.price)}.reduce(0,+)
    }
    
    
    func initRealm(){
        let realm = try? Realm()
        self.realm = realm
        
        if let group = realm?.objects(PrizeGroup.self).first{
            self.prizesGroup = group
      //      var items : List<Item> = group.items
            self.items = group.items
        }else{
            
            try? realm?.write({
                let group = PrizeGroup()
                realm?.add(group)
                //добавить пару-тройку простих призов
                for i in 0..<baseElement {
                group.items.append(Prize())
                }
                
            })
            initRealm()
        }
    }
    
//MARK: Function
    
    func addPrize( name : String , price : Int){
        if let realm = prizesGroup?.realm{
            let prize : Prize = Prize()
            if name != ""{
                prize.name = name
            }
            prize.price = price
            
            try? realm.write({
                prizesGroup?.items.append(prize)
            })
        }
    }
    
    
    func delete(at indexSet : IndexSet){
        if let index = indexSet.first , let realm = items[index].realm {
            try? realm.write({
                realm.delete(items[index])
            })
        }
    }
    
    
    func unselectedPrize()  {
        print(items)
        
        var lastItem = items.filter({ $0.selected == true }).sorted { $0.selectedDate!.timeIntervalSince1970 < $1.selectedDate!.timeIntervalSince1970}.first
        
        print("lastitem now" , lastItem)
        lastItem?.update(selected: false)
        
    }
    
}
