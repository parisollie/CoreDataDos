//
//  Home.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import SwiftUI
//Vid 209, hacemos nuestro import de core data
import CoreData
//Vid 209
struct Home: View {
    //Vid209,usamos el contexto
    @Environment(\.managedObjectContext) var context
    //Vid 209 hacemos el FetchRequest y nuestra entidad
    //En FetchedResults ponemos nuestra Meta
    @FetchRequest(entity: Metas.entity(), sortDescriptors: []) var metas: FetchedResults<Metas>
    //Vid 213 ,mandamos a llamar el model ,para tarer eliminar 
    @ObservedObject var model = MetasViewModel()
    //Vid 218, es la variable que nos estara buscando en el buscador
    @State private var buscar = ""
    var body: some View {
        //Vid 209
        NavigationView{
            //Vid 210,ponemos nuestro VStack
            VStack{
                //Vid 216,ponemos el binding 
                SearchBar(text: $buscar)
                List{
                    //Vid209, hacemos nuestro Foreach
                    ForEach(metas.filter {
                        //Vid 216, ponemos las variables que queremos filtrar para nuestro buscador
                        buscar.isEmpty ? true : $0.titulo!.lowercased().contains(buscar.lowercased())
                    }){ meta in
                        //Vid 210 ,vamos a tareasVoew 
                        NavigationLink(destination: TareasView(meta:meta)){
                            //Vid 209
                            VStack(alignment: .leading){
                                Text(meta.titulo ?? "").font(.title)
                                Text(meta.desc ?? "").font(.headline)
                            }
                        }
                        //Vid 213,mandams para eliminar
                    }.onDelete{ (IndexSet) in
                        let borrarMeta = metas[IndexSet.first!]
                        model.deleteData(item: borrarMeta, context: context)
                    }
                }
                //Vid 210,ponemos nuestro navigationlik y nuestr destino es Add View
                NavigationLink(destination: AddMetaView()){
                    Image(systemName: "note")
                }
            }.navigationBarTitle("Metas")
        }
    }
}


#Preview(){
    Home()
}
