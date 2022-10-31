//
//  ResponseData.swift
//  dataCase
//
//  Created by Toygun Çil on 31.10.2022.
//

import Foundation

struct ResponseData: Codable {
    let data: [ResultItem]?
}

struct ResultItem: Codable {
    let CustomViewType: String?
    let Properties: Properties?
}

struct Properties: Codable {
    let Header: String?
    let Code: String?
    let Text: String?
}
