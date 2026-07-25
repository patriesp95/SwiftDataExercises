//
//  ProductDetailView.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import SwiftUI

struct ProductDetailView: View {
    
    var name: String
    var description: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
            Text(description)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProductDetailView(name: Product.test.name, description: Product.test.description)
}
