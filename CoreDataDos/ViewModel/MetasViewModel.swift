//
//  MetasViewModel.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//
//Vid209
import Foundation
import CoreData
class MetasViewModel: ObservableObject {
    //Vid209, hacemos el importe de core data
    @Published var titulo = ""
    @Published var desc = ""
    //---------------------------- Add Metas -----------------------------------------------------------//
    
    //Vid209, creamos nuestra funcion saveData con el contexto NSManagedObjectContext
    func saveData(context: NSManagedObjectContext){
        let newMeta = Metas(context: context)
        //Vid 209 titulo que viene del published
        newMeta.titulo = titulo
        newMeta.desc = desc
        //Vid209 ,id unico para cada registro ponemos el uuidString
        //que sera alfanumerico para cada registro
        newMeta.id = UUID().uuidString
        //Vid 209, hacemos nuestro do catch 
        do {
            try context.save()
            print("Guardo")
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
    
    //---------------------------- Eliminar Metas -----------------------------------------------------------//
    
    
    //Vid 213
    func deleteData(item: Metas, context: NSManagedObjectContext){
        context.delete(item)
        do {
            try context.save()
            print("elimino")
        } catch let error as NSError {
            print("No elimino", error.localizedDescription)
        }
    }
    
}
