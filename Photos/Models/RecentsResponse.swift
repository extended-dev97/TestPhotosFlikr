//
//  RecentsResponse.swift
//  Photos
//
//  Created by Ярослав Стрельников on 10.12.2020.
//

import Foundation
import RealmSwift

struct Response: Decodable {
    var photos: Photos
    var stat: String
}

struct Photos: Decodable {
    var photo: [Photo]
    var perpage, page, pages: Int
}

struct Photo: Decodable {
    var farm: Int
    var id, server: String
    var isfamily, isfriend, ispublic: Int
    var owner, title, secret: String
}

class PhotoObject: Object {
    @objc dynamic var farm: Int = 0
    @objc dynamic var id = "", server: String = ""
    @objc dynamic var isfamily = 0, isfriend = 0, ispublic: Int = 0
    @objc dynamic var owner = "", title = "", secret: String = ""
    
    convenience init(photo: Photo) {
        self.init()
        self.farm = photo.farm
        self.id = photo.id
        self.server = photo.server
        self.isfamily = photo.isfamily
        self.isfriend = photo.isfriend
        self.ispublic = photo.ispublic
        self.owner = photo.owner
        self.title = photo.title
        self.secret = photo.secret
    }
    
    var previewURL: URL? {
        let stringUrl = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(PhotoSize.preview.rawValue).jpg"
        return URL(string: stringUrl)
    }
    
    var fullSizeURL: URL? {
        let stringUrl = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(PhotoSize.fullSize.rawValue).jpg"
        return URL(string: stringUrl)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
