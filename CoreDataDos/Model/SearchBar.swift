//
//  SearchBar.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//
//Vid 216,se puede guardar para los snniperts
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
    //Vid 216, es una actualizacion de la vista
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text : String
        //Hacemos un constructor
        init(text: Binding<String>){
            _text = text
        }
        //Metodo textDid chaange
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
    }
    
}
