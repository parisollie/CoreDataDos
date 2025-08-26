//
//  Home.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import SwiftUI
import CoreData


struct Home: View {
    // Paso 1.3 usamos el contexto
    @Environment(\.managedObjectContext) var context
    
    /*
      Hacemos el FetchRequest y nuestra entidad
      En FetchedResults ponemos nuestra Meta
    */
    @FetchRequest(entity: Metas.entity(), sortDescriptors: []) var metas: FetchedResults<Metas>
    
    // Paso 5.1 ,mandamos a llamar el model ,para traer eliminar.
    @ObservedObject var model = MetasViewModel()
    
    // Paso 8.1, es la variable que nos estará buscando en el buscador
    @State private var buscar = ""
    
    var body: some View {
        // Paso 1.5
        NavigationView{
            // Paso 2.1,ponemos nuestro VStack
            VStack{
                // Paso 8.2,ponemos el binding
                SearchBar(text: $buscar)
                List{
                    // Paso 1.6, hacemos nuestro Foreach
                    ForEach(metas.filter {
                        // Paso 8.3, ponemos las variables que queremos filtrar para nuestro buscador, yo quiero filtrar la de titulo y la hacemos minuscula
                        buscar.isEmpty ? true : $0.titulo!.lowercased().contains(buscar.lowercased())
                    }){ meta in
                        // Paso 2.4,vamos a tareasView
                        NavigationLink(destination: TareasView(meta:meta)){
                            //Paso 1.7
                            VStack(alignment: .leading){
                                Text(meta.titulo ?? "").font(.title)
                                Text(meta.desc ?? "").font(.headline)
                            }//:V-STACK
                        }//:NavigationLink
                    }
                    //Paso 5.2,mandamos para eliminar
                    .onDelete{ (IndexSet) in
                        let borrarMeta = metas[IndexSet.first!]
                        model.deleteData(item: borrarMeta, context: context)
                    }
                }//:List
                //Paso 2.2,ponemos nuestro navigationlik y nuestro destino es Add View
                NavigationLink(destination: AddMetaView()){
                    Image(systemName: "note")
                }//:NavigationLink
            }.navigationBarTitle("Metas")//:V-STACK
        }//:NavigationView
    }
}


#Preview(){
    Home()
}
