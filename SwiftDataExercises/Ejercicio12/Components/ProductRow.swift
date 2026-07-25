//
//  ProductRow.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 24/07/2026.
//

import SwiftUI

struct ProductRow: View {
    var product: Product

    var body: some View {
        NavigationLink {
            ProductDetailView(name: product.name, description: product.description)
        } label: {
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(product.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)

            }
        }
    }
}

#Preview {
    ProductRow(product: .test)
}
