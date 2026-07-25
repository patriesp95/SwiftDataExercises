//
//  ProductListView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var vm = ProductsVM()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.products) { product in
                    ProductRow(product: product)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Products")
        }
        .navigationLinkIndicatorVisibility(.hidden)
    }
}

#Preview {
    ProductListView()
}
