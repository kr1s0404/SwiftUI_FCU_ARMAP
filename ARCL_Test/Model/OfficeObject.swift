//
//  OfficeObject.swift
//  ARCL_Test
//
//  Created by Kris on 3/14/22.
//

import SwiftUI

private enum CodingKeys: String, CodingKey {
    case name        = "name"
    case phone       = "phone"
    case office      = "office"
}

struct OfficeObject: Hashable {
    let name: String
    let phone: String
    let office: String
}

extension OfficeObject: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.office = try container.decode(String.self, forKey: .office)
    }
}
