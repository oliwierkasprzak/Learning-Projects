//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Oliwier Kasprzak on 26/11/2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
