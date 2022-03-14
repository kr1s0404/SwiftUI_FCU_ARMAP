//
//  LocationFactory.swift
//  ARCL_Test
//
//  Created by Kris on 3/10/22.
//

import SwiftUI

final class LocationViewModel {
    
    
    static func build() -> [LocationObject]
    {
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "json") else {
            
            print("\n\n\(#file) error with loading the json file\n\n")
            return Array()
            
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return Array() }
        
        guard let locations = try? JSONDecoder().decode([LocationObject].self, from: data) else { return Array() }
        
        
        return locations
    }
}
