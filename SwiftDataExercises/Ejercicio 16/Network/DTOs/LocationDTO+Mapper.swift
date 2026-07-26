//
//  LocationDTO+Mapper.swift
//  SwiftDataExercises
//
//  Created by Patricia M Espert on 25/07/2026.
//

import Foundation

extension LocationDTO {
    func toDomain() -> Location {
        Location(
            name: name,
            locationURL: URL(string: url)
        )
    }
}
