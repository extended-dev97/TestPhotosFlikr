//
//  FlikrApi.swift
//  Photos
//
//  Created by Ярослав Стрельников on 10.12.2020.
//

import Foundation
import UIKit
import Alamofire
import PromiseKit
import SwiftyJSON

enum PhotoSize: String {
    case preview = "q"
    case fullSize = "b"
}

struct Api {
    static func getRecentPhotos() -> Promise<Photos> {
        let apiUrl = "https://api.flickr.com/services/rest/?"
        let parameters: Parameters = [
            "method" : "flickr.photos.getRecent",
            "api_key" : "da9d38d3dee82ec8dda8bb0763bf5d9c",
            "per_page" : 20,
            "format" : "json",
            "nojsoncallback" : 1
        ]
        
        return firstly {
            Alamofire.request(apiUrl, method: .get, parameters: parameters, encoding: URLEncoding.default).responseData(queue: DispatchQueue.global(qos: .background))
        }.compactMap {
            if let apiError = ApiError(JSON($0.data)) {
                throw FlikrError.api(apiError)
            }
            guard let decodePhotosJSON = decodeJSON(to: Response.self, from: $0.data) else { throw FlikrError.notParsedJSON("JSON not parsed") }
            return decodePhotosJSON.photos
        }
    }
}

extension Api {
    static func decodeJSON<T: Decodable>(to decodable: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let data = data,
            let response = try? decoder.decode(decodable.self, from: data)
        else { return nil }
        return response
    }
}
