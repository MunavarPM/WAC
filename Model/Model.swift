//
//  Model.swift
//  WAC Task
//
//  Created by MUNAVAR PM on 16/03/24.
//

import Foundation


struct Banner: Identifiable {
    let id = UUID()
    let image_url: String
    
    init?(content: Content) {
        guard let image_url = content.image_url else { return nil }
        self.image_url = image_url
    }
}

struct Product: Identifiable {
    let id = UUID()
    let content: Content
    init?(content: Content) {
        guard let product_name = content.product_name, let product_image = content.product_image else { return nil }
        self.content = content
    }
}

struct Category: Identifiable {
    let id = UUID()
    let title: String
    let image_url: String
    
    init?(content: Content) {
        guard let title = content.title, let image_url = content.image_url else { return nil }
        self.title = title
        self.image_url = image_url
    }
}

struct Section: Codable {
    let type: String
    let title: String
    let contents: [Content]?
    let image_url: String?
    let id: String
}

struct Content: Codable {
    let title: String?
    let image_url: String?
    let sku: String?
    let product_name: String?
    let product_image: String?
    let product_rating: Int?
    let actual_price: String?
    let offer_price: String?
    let discount: String?
}

struct BannerSingle: Codable {
    let title: String
    let image_url: String
}


