//
//  FlikrError.swift
//  Photos
//
//  Created by Ярослав Стрельников on 11.12.2020.
//

import Foundation
import SwiftyJSON

extension Error {
    func toFlikr() -> FlikrError {
        if let vkError = self as? FlikrError {
            return vkError
        }
        else if let apiError = self as? ApiError {
            return .api(apiError)
        }
        else {
            return .unknown(self)
        }
    }
}

public indirect enum FlikrError: Error {
    case unknown(Error)
    case api(ApiError)
    case notParsedJSON(String)
    
    func toApi() -> ApiError? {
        switch self {
        case let .api(error):
            return error
        default:
            return nil
        }
    }
}

public struct ApiError: Equatable {
    public let stat: String
    /// Error code
    public let code: Int
    /// Error message
    public let message: String
    
    init?(_ json: JSON) {
        guard let stat = json["stat"].string else {
            return nil
        }
        
        guard let code = json["code"].int else {
            return nil
        }
        
        guard let message = json["message"].string else {
            return nil
        }
        
        self.stat = stat
        self.code = code
        self.message = message
    }
    
    var toFlikr: FlikrError {
        return .api(self)
    }
}
