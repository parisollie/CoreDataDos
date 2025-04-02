//
//  FotoView.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import SwiftUI
//Vid 214
struct FotoView: View {
    
    @Environment(\.managedObjectContext) var context
    //Vid 214, es el mismo codigo de los pasados ,solo que ponemos la Tarea y las fotos
    var tarea : Tareas
    var fotos : FetchRequest<Fotos>
    init(tarea: Tareas){
        self.tarea = tarea
        fotos = FetchRequest<Fotos>(entity: Fotos.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idTarea == %@", tarea.id!))
    }
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    //Vid 215,para una grid al salvar las fotos
    let gridItem : [GridItem] = Array(repeating: .init(.flexible(maximum: 100)), count: 3)
    
    //---------------------------- salvar fotos -----------------------------------------------------------//
    //Vid 214
    func save(imagen: Data){
        let newFoto = Fotos(context: context)
        newFoto.foto = imagen
        //vid 214, necesitamos el id de la foto
        newFoto.idTarea = tarea.id
        //Ponemos la relacion 
        tarea.mutableSetValue(forKey: "relationToFotos").add(newFoto)
        
        do {
            try context.save()
            print("guardo foto")
        } catch let error as NSError {
            print("error", error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                //Ponemos el navigation que manda a llamar la libreria
                NavigationLink(destination: ImagePicker(show: self.$imagePicker, image: self.$imageData, source: self.source), isActive: self.$imagePicker) {
                    Text("")
                }.navigationBarTitle("")
                    .navigationBarHidden(true)
                
                //Vid 215, scroll view para item
                ScrollView(){
                    //Le pasamos el parametro
                    LazyVGrid(columns: gridItem, spacing: 10){
                        ForEach(fotos.wrappedValue){ foto in
                            Image(uiImage: UIImage(data: foto.foto ?? Data())!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                
                HStack(alignment: .center, spacing: 60){
                    Button(action:{
                        self.mostrarMenu.toggle()
                    }){
                        Image(systemName: "camera")
                    }.actionSheet(isPresented: self.$mostrarMenu) {
                        ActionSheet(title: Text("Menu"), message: Text("Selecciona una opción"), buttons: [
                            .default(Text("Camara"), action: {
                                self.source = .camera
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Libreria"), action: {
                                self.source = .photoLibrary
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Cancelar"))
                        ])
                    }
                    Button(action:{
                        save(imagen: imageData)
                    }){
                        Text("Guardar imagen")
                    }
                }
            }
        }
    }
}



