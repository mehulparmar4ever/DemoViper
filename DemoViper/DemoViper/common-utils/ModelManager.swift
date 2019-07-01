//
//  ModelManager.swift
//  DemoViper
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import UIKit
import ObjectMapper

class ModelManager: NSObject {
    static let sharedInstance = ModelManager()
    private override init() {}

    func getMovieModel(_ dict: NSDictionary) -> MovieModel {
        return Mapper<MovieModel>().map(JSON: dict as! [String : Any])!
    }
    func getMovieModelArray(_ arrData: NSArray) -> [MovieModel] {
        return Mapper<MovieModel>().mapArray(JSONObject: arrData)!
    }
    
    func getResponseDataModel(_ dict: NSDictionary) -> ResponseDataModel {
        return Mapper<ResponseDataModel>().map(JSON: dict as! [String : Any])!
    }
}

class ResponseDataModel: Mappable {
    var success: Bool!
    var movie_list: Any?

    var error: String!
    var statusCode: Int!
    var message: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        movie_list <- map["movie_list"]
        success <- map["success"]
        
        error <- map["error"]
        statusCode <- map["statusCode"]
        message <- map["message"]
    }
}
