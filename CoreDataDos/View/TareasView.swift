//
//  TareasView.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

//vid 212
import SwiftUI

struct TareasView: View {
    
    @Environment(\.managedObjectContext) var context
    //Vid 211
    //@FetchRequest(entity: Tareas.entity(), sortDescriptors: []) var tareas: FetchedResults<Tareas>
    //Vid 210,relacion para el momento de guardar
    var meta : Metas
    //Vid 212 , para que las metas sean de la misma meta
    var tareas : FetchRequest<Tareas>
    //Vid 212,asi que hacemos un constructor ,el id de la meta debe ser al id de la meta
    init(meta: Metas){
        self.meta = meta
        tareas = FetchRequest<Tareas>(entity: Tareas.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idMeta == %@", meta.id!))
    }
    
    var body: some View {
        VStack{
            List{
                //Vid 211 y 212, le ponemos el wrappedValue
                ForEach(tareas.wrappedValue){ tarea in
                    //Vid 214
                    NavigationLink(destination: FotoView(tarea: tarea)){
                        VStack(alignment: .leading){
                            Text(tarea.tarea ?? "").font(.title)
                        }
                    }
                }
            }
            //Vid 211
            NavigationLink(destination: AddTareasView(meta: meta)){
                Image(systemName: "plus")
            }
        }.navigationBarTitle(meta.titulo ?? "")
    }
}

#Preview {
   ContentView()
}





