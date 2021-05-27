//
//  ListPrizesView.swift
//  PrizesSelector
//
//  Created by Vasiliy Munenko on 25.05.2021.
//

import SwiftUI
import RealmSwift

struct ListPrizesView: View {
 
    @StateObject var modelData = PrizesViewModel()

    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Text("Sum of all prize = \(modelData.sumPrize)")
                        .font(.title2)
                    Text("(max=\(modelData.basketLimit))")
                        .font(.caption)
                }
                    .padding()
               
                List{
                    ForEach(modelData.items.freeze(), id: \.self) { item in
                       PrizeCellView(item: modelData.realm!.resolve(ThreadSafeReference(to: item))!)
                    }.onDelete(perform: { indexSet in
                        modelData.delete(at: indexSet)
                    })
                }
            }
            .navigationTitle("My Prize")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    
                    Button(action: {
                            modelData.openAddPage.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    })
                }
            })
            .sheet(isPresented: $modelData.openAddPage, content: {
                AddPrizeView()
                    .environmentObject(modelData)
            })
            
            
        }
    }
}

struct ListPrizes_Previews: PreviewProvider {
    static var previews: some View {
        ListPrizesView()
    }
}




