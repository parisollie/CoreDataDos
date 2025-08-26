//
//  AddTareasView.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import SwiftUI

struct AddTareasView: View {
    //Paso 3.1,formulario para guardar las tareas
    //Se copia al de metas que hicimos previamente
    @Environment(\.managedObjectContext) var context
    @ObservedObject var model = TareasViewModel()
    var meta : Metas
    
    var body: some View {
        VStack{
            TextField("tarea", text: $model.tarea)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action:{
                //Traemos el contexto y la meta
                model.saveData(context: context, meta: meta)
            }){
                Text("guardar")
            }
        }.padding()
    }
}

struct TareasView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.shared.container.viewContext
        
        // Crear una meta de ejemplo
        let exampleMeta = Metas(context: previewContext)
        // Aquí lo convertimos a String
        exampleMeta.id = UUID().uuidString
        exampleMeta.titulo = "Ejemplo de Meta"
        
        // Crear una tarea de ejemplo
        let exampleTarea = Tareas(context: previewContext)
        exampleTarea.id = UUID().uuidString
        exampleTarea.tarea = "Ejemplo de Tarea"
        // Ahora es un String
        exampleTarea.idMeta = exampleMeta.id
        
        do {
            try previewContext.save()
        } catch {
            fatalError("No se pudo guardar los datos de prueba: \(error)")
        }

        return TareasView(meta: exampleMeta)
            .environment(\.managedObjectContext, previewContext)
    }
}



