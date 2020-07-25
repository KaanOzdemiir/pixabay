//
//  ImageResponse.swift
//  pixabay
//
//  Created by Kaan Ozdemir on 25.07.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - ImageResponse
class ImageResponse: Mappable {
    var total, totalHits: Int
    var hits: [HitData]
    var errorCode: String
    var message: String

    init(
        total: Int = 0,
        totalHits: Int = 0,
        hits: [HitData] = [],
        errorCode: String = "",
        message: String = ""
    ) {
        self.total = total
        self.totalHits = totalHits
        self.hits = hits
        self.errorCode = errorCode
        self.message = message
    }
    
    required init?(map: Map) {
        self.total = 0
        self.totalHits = 0
        self.hits = []
        self.errorCode = ""
        self.message = ""
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        totalHits <- map["totalHits"]
        hits <- map["hits"]
    }
}

// MARK: - HitData
class HitData: Mappable {
    var id: Int
    var pageURL: String
    var type: String
    var tags: String
    var previewURL: String
    var previewWidth, previewHeight: Int
    var webformatURL: String
    var webformatWidth, webformatHeight: Int
    var largeImageURL: String
    var imageWidth, imageHeight, imageSize, views: Int
    var downloads, favorites, likes, comments: Int
    var userid: Int
    var user: String
    var userImageURL: String

    init(
        id: Int,
        pageURL: String,
        type: String,
        tags: String,
        previewURL: String,
        previewWidth: Int,
        previewHeight: Int,
        webformatURL: String,
        webformatWidth: Int,
        webformatHeight: Int,
        largeImageURL: String,
        imageWidth: Int,
        imageHeight: Int,
        imageSize: Int,
        views: Int,
        downloads: Int,
        favorites: Int,
        likes: Int,
        comments: Int,
        userid: Int,
        user: String,
        userImageURL: String
    ) {
        self.id = id
        self.pageURL = pageURL
        self.type = type
        self.tags = tags
        self.previewURL = previewURL
        self.previewWidth = previewWidth
        self.previewHeight = previewHeight
        self.webformatURL = webformatURL
        self.webformatWidth = webformatWidth
        self.webformatHeight = webformatHeight
        self.largeImageURL = largeImageURL
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.imageSize = imageSize
        self.views = views
        self.downloads = downloads
        self.favorites = favorites
        self.likes = likes
        self.comments = comments
        self.userid = userid
        self.user = user
        self.userImageURL = userImageURL
    }
    
    required init?(map: Map) {
        self.id = 0
        self.pageURL = ""
        self.type = ""
        self.tags = ""
        self.previewURL = ""
        self.previewWidth = 0
        self.previewHeight = 0
        self.webformatURL = ""
        self.webformatWidth = 0
        self.webformatHeight = 0
        self.largeImageURL = ""
        self.imageWidth = 0
        self.imageHeight = 0
        self.imageSize = 0
        self.views = 0
        self.downloads = 0
        self.favorites = 0
        self.likes = 0
        self.comments = 0
        self.userid = 0
        self.user = ""
        self.userImageURL = ""
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        pageURL <- map["pageURL"]
        type <- map["type"]
        tags <- map["tags"]
        
        previewURL <- map["previewURL"]
        previewWidth <- map["previewWidth"]
        previewHeight <- map["previewHeight"]
        webformatURL <- map["webformatURL"]
        
        webformatWidth <- map["webformatWidth"]
        webformatHeight <- map["webformatHeight"]
        largeImageURL <- map["largeImageURL"]
        imageWidth <- map["imageWidth"]
        
        imageHeight <- map["imageHeight"]
        imageSize <- map["imageSize"]
        views <- map["views"]
        downloads <- map["downloads"]
        
        favorites <- map["favorites"]
        likes <- map["likes"]
        comments <- map["comments"]
        userid <- map["user_id"]
        
        user <- map["user"]
        userImageURL <- map["userImageURL"]
    }
}
