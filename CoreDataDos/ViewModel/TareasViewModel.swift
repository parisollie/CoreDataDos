//
//  TareasViewModel.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

//Vid 213
import Foundation
import CoreData
class TareasViewModel: ObservableObject {
    
    @Published var tarea = ""
   
    
    func saveData(context: NSManagedObjectContext, meta: Metas){
        let newTarea = Tareas(context: context)
        newTarea.tarea = tarea
        //Vid 211 ,ponemos nuestro id
        newTarea.id = UUID().uuidString
        newTarea.idMeta = meta.id
        //Vid 211 , nos pide la relacion que se tiene en core data y la ponemos tal cual y le ponemos el nuevo objeto 
        meta.mutableSetValue(forKey: "relationToTareas").add(newTarea)
        
        do {
            try context.save()
            print("Guardo")
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
}
