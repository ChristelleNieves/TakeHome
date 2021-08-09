//
//  API+Response.swift
//  Takehome
//
//  Created by Christelle Nieves on 8/8/21.
//

import Foundation

struct Response: Codable {
    var campaigns: [Campaign]
}

struct Campaign: Codable {
    var id: Int
    var campaign_name: String
    var campaign_icon_url: String
    var pay_per_install: String
    var medias: [Media]
}

struct Media: Codable {
    var cover_photo_url: String
    var download_url: String
    var tracking_link: String
    var media_type: String
}
