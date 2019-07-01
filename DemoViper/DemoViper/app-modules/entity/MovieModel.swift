//
//  MovieModel.swift
//  DemoViper
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieModel: Mappable {
    private let ID = "id"
    private let TITLE = "title"
    private let BRIEF = "brief"
    private let IMAGESOURCE = "image_url"

    var id:String!
    var title:String!
    var brief:String!
    var imagesource:String!

    required init?(map: Map) {}
    
    // Mappable
    func mapping(map:Map){
        id <- map[ID]
        title <- map[TITLE]
        brief <- map[BRIEF]
        imagesource <- map[IMAGESOURCE]
    }
}
