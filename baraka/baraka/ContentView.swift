//
//  ContentView.swift
//  baraka
//
//  Created by Ivan Volnov on 25.03.2022.
//

import SwiftUI

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> HomeViewController {
        HomeViewController()
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {}
}
