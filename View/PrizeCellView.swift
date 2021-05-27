//
//  PrizeCellView.swift
//  PrizesSelector
//
//  Created by Vasiliy Munenko on 27.05.2021.
//

import SwiftUI

struct PrizeCellView: View {
    
    var item : Prize
 
    private var isSelected : Binding<Bool>{  //Binding - maybe will toggleUI
        Binding<Bool>{
            item.selected
        } set: { value in
            item.update(selected: value)
        }
    }
    
    
    var body: some View {
        HStack{
            ZStack{
                Image(systemName: "square")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor( isSelected.wrappedValue ? Color.green : Color.blue)
                if item.selected {
                    Image(systemName: "checkmark")
                }
            }
            .frame(width: 30, height: 30, alignment: .center)
            .onTapGesture {
                withAnimation{
                    isSelected.wrappedValue.toggle()
                }
            }
            
            HStack{
                Text("\(item.name)")
                Text("\(item.price)$")
                    .font(.headline)
                    .bold()
            }
        }
        
    }
}


struct PrizeCellView_Previews: PreviewProvider {
    static var previews: some View {
        PrizeCellView(item: Prize())
    }
}
