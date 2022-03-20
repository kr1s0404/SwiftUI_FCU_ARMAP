//
//  RenYanBuildingViewModel.swift
//  ARCL_Test
//
//  Created by Kris on 3/19/22.
//

import SwiftUI

final class RenYanBuildingViewModel {
    
    
    static func build() -> [OfficeObject]
    {
        guard let path = Bundle.main.path(forResource: "RenYanBuilding", ofType: "json") else {
            
            print("\n\n\(#file) error with loading the json file\n\n")
            return Array()
            
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return Array() }
        
        guard let locations = try? JSONDecoder().decode([OfficeObject].self, from: data) else { return Array() }
        
        
        return locations
    }
}
