//
//  AddPrizeView.swift
//  PrizesSelector
//
//  Created by Vasiliy Munenko on 25.05.2021.
//

import SwiftUI

struct AddPrizeView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var modelData : PrizesViewModel
    
    @State var  prizeName : String = ""
    @State var prizeSum : String = ""
    @State var showingAlert : Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
 
                VStack(alignment: .leading){
                    Text("Prize Name")
                    
                    TextField("name", text: $prizeName)
                }
                VStack(alignment: .leading){
                    Text("Prize Sum ")
                    
                    TextField("sum", text: $prizeSum)
                        .keyboardType(.numberPad)
                }
                
                Button(action: {
                    // add prize action
                    if  let sum = Int(prizeSum) {
                        if sum > modelData.basketLimit{
                            showingAlert.toggle()
                        }else{
                            modelData.addPrize(name: prizeName, price: sum)
                            presentation.wrappedValue.dismiss()
                        }
                        
                    }else{
                        presentation.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    Text("Add")
                        .font(.title)
                        .padding()
                })
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add new Prize")
            .toolbar(content: {
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("Close")
                })
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Current recomendation"), message: Text("Please set price low then \(modelData.basketLimit)$ "), dismissButton: .default(Text("Okey")))
                   }
        }
    }
}

struct AddPrizeView_Previews: PreviewProvider {
    static var previews: some View {
        AddPrizeView(showingAlert: false)
    }
}
