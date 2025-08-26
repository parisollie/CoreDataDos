//
//  MetasViewModel.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import Foundation
import CoreData

class MetasViewModel: ObservableObject {
    //Paso 1.1, ponemos nuestras variables.
    @Published var titulo = ""
    @Published var desc = ""
    //---------------------------- Add Metas -----------------------------------------------------------//
    
    //Paso 1.2, creamos nuestra funcion saveData con el contexto NSManagedObjectContext
    func saveData(context: NSManagedObjectContext){
        let newMeta = Metas(context: context)
        //El titulo que viene del published
        newMeta.titulo = titulo
        newMeta.desc = desc
        /*
          id único para cada registro ponemos el uuidString
          que sera alfanúmerico para cada registro
        */
        newMeta.id = UUID().uuidString
        
        //Hacemos nuestro do catch
        do {
            try context.save()
            print("Guardo")
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
    
    //---------------------------- Eliminar Metas -----------------------------------------------------------//
    
    
    //V-213, paso 5.0
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
