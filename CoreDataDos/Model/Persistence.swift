//
//  Persistence.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import SwiftUI
import CoreData

//V-207 ,Paso 0.0 archivo por defecto
struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataDos")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    //Preview
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        // Creamos una tarea dummy
        let tarea = Tareas(context: viewContext)
        tarea.id = UUID().uuidString
        tarea.idMeta = "meta-456"
        tarea.tarea = "Tarea de ejemplo preview"
        
        // Opcional: agregamos una foto dummy
        let foto = Fotos(context: viewContext)
        foto.idTarea = tarea.id
        foto.foto = UIImage(systemName: "star.fill")?.pngData()
        
        tarea.mutableSetValue(forKey: "relationToFotos").add(foto)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return controller
    }()
    
}







