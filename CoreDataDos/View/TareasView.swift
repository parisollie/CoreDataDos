//
//  TareasView.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import SwiftUI

struct TareasView: View {
    
    @Environment(\.managedObjectContext) var context
    // Paso 2.3,relación para el momento de guardar
    var meta : Metas
    //V-212,paso 4.0 para que las metas sean de la misma meta
    var tareas : FetchRequest<Tareas>
    
    // Así que hacemos un constructor ,el id de la meta debe ser al id de la meta
    init(meta: Metas){
        self.meta = meta
        tareas = FetchRequest<Tareas>(entity: Tareas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idMeta == %@", meta.id!))
    }
    
    var body: some View {
        // Paso 3.2
        VStack{
            List{
                // Paso 4.1, le ponemos el wrappedValue
                ForEach(tareas.wrappedValue){ tarea in
                    // Paso 6.7,ponemos el navigation
                    NavigationLink(destination: FotoView(tarea: tarea)){
                        VStack(alignment: .leading){
                            Text(tarea.tarea ?? "").font(.title)
                        }
                    }
                }
            }//:List
            // Paso 3.3
            NavigationLink(destination: AddTareasView(meta: meta)){
                Image(systemName: "plus")
            }
        }//:V-STACK
        .navigationBarTitle(meta.titulo ?? "")
    }
}

#Preview {
   ContentView()
}





