//
//  FotoView.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

import SwiftUI
//V-214,paso 6.0
struct FotoView: View {
    
    @Environment(\.managedObjectContext) var context
    //paso 6.1,es el mismo codigo de los pasados ,solo que ponemos la Tarea y las fotos
    var tarea : Tareas
    var fotos : FetchRequest<Fotos>
    init(tarea: Tareas){
        self.tarea = tarea
        fotos = FetchRequest<Fotos>(entity: Fotos.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idTarea == %@", tarea.id!))
    }
    
    //Paso 6.4
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    // ⚠️ para mostrar alerta si no se selecciona foto
    @State private var mostrarAlerta = false
    
    //V-215,paso 7.0 para una grid al salvar las fotos
    let gridItem : [GridItem] = Array(repeating: .init(.flexible(maximum: 100)), count: 3)
    
    //---------------------------- salvar fotos -----------------------------------------------------------//
    //Paso 6.2
    func save(imagen: Data){
        let newFoto = Fotos(context: context)
        newFoto.foto = imagen
        //  Necesitamos el id de la foto
        newFoto.idTarea = tarea.id
        // Ponemos la relacion
        tarea.mutableSetValue(forKey: "relationToFotos").add(newFoto)
        
        do {
            try context.save()
            print("guardo foto")
        } catch let error as NSError {
            print("error", error.localizedDescription)
        }
    }
    
    var body: some View {
        //Paso 6.5
        NavigationView{
            VStack{
                // Ponemos el navigation que manda a llamar la libreria
                NavigationLink(destination: ImagePicker(show: self.$imagePicker, image: self.$imageData, source: self.source), isActive: self.$imagePicker) {
                    Text("")
                }.navigationBarTitle("")
                    .navigationBarHidden(true)
                
                //Paso 7.1, ScrollView para item
                ScrollView(){
                    //Le pasamos el párametro
                    LazyVGrid(columns: gridItem, spacing: 10){
                        ForEach(fotos.wrappedValue){ foto in
                            // ⚠️ Validamos que la foto tenga data válida antes de crear UIImage
                            if let data = foto.foto, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .aspectRatio(contentMode: .fit)
                            } else {
                                // Si no hay imagen mostramos un placeholder
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }//:SCROLL
                //Paso 6.6
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
                        // ⚠️ Si no hay imagen seleccionada mostramos alerta
                        if imageData.isEmpty {
                            mostrarAlerta = true
                        } else {
                            save(imagen: imageData)
                            // limpiamos el imageData después de guardar
                            imageData = Data()
                        }
                    }){
                        Text("Guardar imagen")
                    }
                    // ⚠️ Alert si no se selecciona foto
                    .alert(isPresented: $mostrarAlerta) {
                        Alert(
                            title: Text("Advertencia"),
                            message: Text("Debes seleccionar una foto antes de guardar."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }//:H-STACK
            }//:V-STACK
        }//:NavigationView
    }
}


#Preview {
    let controller = PersistenceController.preview
    let context = controller.container.viewContext

    let ejemploTarea: Tareas = {
        let tarea = Tareas(context: context)
        tarea.id = UUID().uuidString
        tarea.idMeta = "meta-123"
        tarea.tarea = "Tarea de ejemplo para Preview"
        return tarea
    }()

    return FotoView(tarea: ejemploTarea)
        .environment(\.managedObjectContext, context)
}

