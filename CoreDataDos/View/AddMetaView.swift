//
//  AddMetaView.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//


import SwiftUI

struct AddMetaView: View {
    //Vid210,usamos el contexto
    @Environment(\.managedObjectContext) var context
    //Vid 210,usamos el ObservedObject
    @ObservedObject var model = MetasViewModel()
    //Vid 210,usamos nuestro formulario 
    var body: some View {
        VStack{
            TextField("Titulo", text: $model.titulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Descripcion", text: $model.desc)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action:{
                model.saveData(context: context)
            }){
                Text("Guardar")
            }
            Spacer()
        }.padding()
    }
}

#Preview{
    AddMetaView()
}
