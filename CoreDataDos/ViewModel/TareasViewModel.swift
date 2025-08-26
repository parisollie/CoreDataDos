//
//  TareasViewModel.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import Foundation
import CoreData

// V-211 ,Paso 3.0
class TareasViewModel: ObservableObject {
    
    @Published var tarea = ""
   
    func saveData(context: NSManagedObjectContext, meta: Metas){
        let newTarea = Tareas(context: context)
        newTarea.tarea = tarea
        //ponemos nuestro id, para empezar hacer relaciones
        newTarea.id = UUID().uuidString
        //Aqui guardamos el id
        newTarea.idMeta = meta.id
        //Nos pide la relacion que se tiene en core data y la ponemos tal cual y le ponemos el nuevo objeto
        meta.mutableSetValue(forKey: "relationToTareas").add(newTarea)
        
        do {
            try context.save()
            print("Guardo")
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
}
