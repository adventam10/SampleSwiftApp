//
//  CityData.swift
//  Models
//
//  Created by am10 on 2020/06/27.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public struct CityData {
    public let area: Int
    public let cityId: String
    public let name: String
}

extension CityData: Decodable {
}
