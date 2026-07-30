//
//  LocationDTO+Mapper.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

extension LocationDTO3 {
    func toDomain() -> Location3 {
        Location3(
            name: name,
            locationURL: URL(string: url)
        )
    }
}
