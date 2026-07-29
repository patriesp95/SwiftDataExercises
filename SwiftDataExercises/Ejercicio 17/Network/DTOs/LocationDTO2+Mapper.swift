//
//  LocationDTO+Mapper.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

extension LocationDTO2 {
    func toDomain() -> Location2 {
        Location2(
            name: name,
            locationURL: URL(string: url)
        )
    }
}
