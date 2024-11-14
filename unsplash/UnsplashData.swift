//
//  UnsplashData.swift
//  unsplash
//
//  Created by Nursultan Turekulov on 13.11.2024.
//

import Foundation
struct UnsplashData: Decodable{
    let urls: URLS
}
struct URLS: Decodable{
    let thumb: String
}
