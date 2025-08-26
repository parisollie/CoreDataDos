//
//  SearchBar.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//

//V-216,paso 8.0 ,BUSCADOR se puede guardar para los snippets
import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text : String
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    // Es una actualizacion de la vista
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text : String
        // Hacemos un constructor
        init(text: Binding<String>){
            _text = text
        }
        // Método textDid change
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
    }
    
}
