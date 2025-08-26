//
//  AddMetaView.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//


import SwiftUI

struct AddMetaView: View {
    //V-210,paso 2.0 usamos el contexto
    @Environment(\.managedObjectContext) var context
    // Usamos el ObservedObject o el State
    @ObservedObject var model = MetasViewModel()
    
    // Usamos nuestro formulario
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
