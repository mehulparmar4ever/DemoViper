//
//  ModelManager.swift
//  TOYIN
//
//  Created by Mehul Parmar on 06/04/19.
//  Copyright © 2018 TOYIN. All rights reserved.
//  LinkedIn: https://www.linkedin.com/in/mehul-p-20268539/

import Foundation
import ObjectMapper


// MARK:
// MARK: ModelManager
class ModelManager: NSObject {
    static let sharedInstance = ModelManager()
    private override init() {}

    //# MARK: - Get ResponseDataModel  from Server response
    func getUserDataModel(_ dict: NSDictionary) -> UserDataModel {
        return Mapper<UserDataModel>().map(JSON: dict as! [String : Any])!
    }

    func getUserModelArray(_ arrData: NSArray) -> [UserModel] {
        return Mapper<UserModel>().mapArray(JSONObject: arrData)!
    }
    func getUserModel(_ dict: NSDictionary) -> UserModel {
        return Mapper<UserModel>().map(JSON: dict as! [String : Any])!
    }
    
    func getResponseDataModel(_ dict: NSDictionary) -> ResponseDataModel {
        return Mapper<ResponseDataModel>().map(JSON: dict as! [String : Any])!
    }
}

var UserStatus:String {
    get{
        return UserDefaults.standard.string(forKey: "KEY_UserStatus") ?? UserType.Fresh.rawValue
    }
    set(status){
        UserDefaults.standard.set(status, forKey: "KEY_UserStatus")
        UserDefaults.standard.synchronize()
    }
}

//Get user details from models
var UserDetail : UserDataModel {
    get{
        if let data = UserDefaults.standard.object(forKey: "KEY_UserDataModel") {
            return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! UserDataModel
        }
        else {
            return ModelManager.sharedInstance.getUserDataModel(["" : ""])
        }
    }
    
    set(data){
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: data), forKey: "KEY_UserDataModel")
        UserDefaults.standard.synchronize()
    }
}


class ResponseDataModel: Mappable {
    
    var code: String!
    var status: String!
    var message: String!
    var key: String!
    
    var data: Any?
    var errors: String!
    var page: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        code <- map["status"]
        status <- map["status"]
        message <- map["message"]
        key <- map["key"]
        
        data <- map["data"]
        errors <- map["errors"]
        page <- map["page"]
    }
}

class UserModel: Mappable {
    
    class func newInstance(map: Map) -> Mappable?{
        return UserModel(map: map)
    }
    
    required init?(map: Map) {
        
    }
    
    var id: String!
    var firebaseid : String?
    
    var username: String!
    var profile_pic: String!
    var user_type: String!
    var mobile_no: String!
    var postcode: String!
    
    var portfolio_image1: String!
    var portfolio_image2: String!
    var portfolio_image3: String!
    var portfolio_image4: String!
    var portfolio_image5: String!
    var portfolio_image6: String!
    
    var about_me: String!
    
    var businness_user_id: String!
    var businness_user_name: String!
    
    var working_time: String!
    var average_rating: String!
    var review_count: String!
    
    var latitude: String!
    var longitude: String!
    var distance: String!
    
    var city: String!
    var country: String!
    
    // Mappable
    func mapping(map: Map) {
        
        id <- map["id"]
        firebaseid <- map["firebaseid"]
        
        username <- map["username"]
        profile_pic <- map["profile_pic"]
        user_type <- map["user_type"]
        mobile_no <- map["mobile_no"]
        postcode <- map["postcode"]
        
        
        portfolio_image1 <- map["portfolio_image1"]
        portfolio_image2 <- map["portfolio_image2"]
        portfolio_image3 <- map["portfolio_image3"]
        portfolio_image4 <- map["portfolio_image4"]
        portfolio_image5 <- map["portfolio_image5"]
        portfolio_image6 <- map["portfolio_image6"]
        
        about_me <- map["about_me"]
        
        businness_user_id <- map["businness_user_id"]
        businness_user_name <- map["businness_user_name"]
        
        working_time <- map["working_time"]
        average_rating <- map["average_rating"]
        review_count <- map["review_count"]
        
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        distance <- map["distance"]
        
        city <- map["city"]
        country <- map["country"]        
    }
}

class UserDataModel : NSObject, NSCoding, Mappable{
    class func newInstance(map: Map) -> Mappable?{
        return UserDataModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    var id : String?
    var firebaseid : String?
    var businness_user_id : String?
    var firebase_token : String?
    var stripe_publishable_key : String?
    
    var username : String?
    var firstname : String?
    var lastname : String?
    var email : String?
    
    var user_type : String?
    var mobile_no : String?
    var postcode : String?
    
    var course_charge : String?
    var services_ids : String?
    var country_id : String?
    var city_id : String?
    var expertise_id : String?
    
    var profile_pic : String?
    var about_me : String?
    var average_rating : String?
    var review_count : String?
    var latitude : String?
    var longitude : String?
    
    
    //Registration response
    var portfolio_image1 : String?
    var portfolio_image2 : String?
    var portfolio_image3 : String?
    var portfolio_image4 : String?
    var portfolio_image5 : String?
    var portfolio_image6 : String?
    
    func mapping(map: Map) {
        id <- map["id"]
        firebaseid <- map["firebaseid"]
        businness_user_id <- map["businness_user_id"]
        firebase_token <- map["firebase_token"]
        stripe_publishable_key <- map["stripe_publishable_key"]
        
        username <- map["username"]
        firstname <- map["firstname"]
        lastname <- map["lastname"]
        email <- map["email"]
        
        user_type <- map["user_type"]
        mobile_no <- map["mobile_no"]
        postcode <- map["postcode"]
        profile_pic <- map["profile_pic"]
        about_me <- map["about_me"]
        average_rating <- map["average_rating"]
        review_count <- map["review_count"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        
        //Registration response
        
        portfolio_image1 <- map["portfolio_image1"]
        portfolio_image2 <- map["portfolio_image2"]
        portfolio_image3 <- map["portfolio_image3"]
        portfolio_image4 <- map["portfolio_image4"]
        portfolio_image5 <- map["portfolio_image5"]
        portfolio_image6 <- map["portfolio_image6"]
        
        //New added
        course_charge <- map["course_charge"]
        services_ids <- map["services_ids"]
        country_id <- map["country_id"]
        city_id <- map["city_id"]
        expertise_id <- map["expertise_id"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String
        firebaseid = aDecoder.decodeObject(forKey: "firebaseid") as? String
        businness_user_id = aDecoder.decodeObject(forKey: "businness_user_id") as? String
        firebase_token = aDecoder.decodeObject(forKey: "firebase_token") as? String
        stripe_publishable_key = aDecoder.decodeObject(forKey: "stripe_publishable_key") as? String
        
        username = aDecoder.decodeObject(forKey: "username") as? String
        firstname = aDecoder.decodeObject(forKey: "firstname") as? String
        lastname = aDecoder.decodeObject(forKey: "lastname") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        
        user_type = aDecoder.decodeObject(forKey: "user_type") as? String
        mobile_no = aDecoder.decodeObject(forKey: "mobile_no") as? String
        postcode = aDecoder.decodeObject(forKey: "postcode") as? String
        profile_pic = aDecoder.decodeObject(forKey: "profile_pic") as? String
        about_me = aDecoder.decodeObject(forKey: "about_me") as? String
        average_rating = aDecoder.decodeObject(forKey: "average_rating") as? String
        review_count = aDecoder.decodeObject(forKey: "review_count") as? String
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String
        
        portfolio_image1 = aDecoder.decodeObject(forKey: "portfolio_image1") as? String
        portfolio_image2 = aDecoder.decodeObject(forKey: "portfolio_image2") as? String
        portfolio_image3 = aDecoder.decodeObject(forKey: "portfolio_image3") as? String
        portfolio_image4 = aDecoder.decodeObject(forKey: "portfolio_image4") as? String
        portfolio_image5 = aDecoder.decodeObject(forKey: "portfolio_image5") as? String
        portfolio_image6 = aDecoder.decodeObject(forKey: "portfolio_image6") as? String
        
        course_charge = aDecoder.decodeObject(forKey: "course_charge") as? String
        services_ids = aDecoder.decodeObject(forKey: "services_ids") as? String
        country_id = aDecoder.decodeObject(forKey: "country_id") as? String
        city_id = aDecoder.decodeObject(forKey: "city_id") as? String
        expertise_id = aDecoder.decodeObject(forKey: "expertise_id") as? String
    }
    
    @objc func encode(with aCoder: NSCoder){
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if firebaseid != nil{
            aCoder.encode(firebaseid, forKey: "firebaseid")
        }
        if businness_user_id != nil{
            aCoder.encode(businness_user_id, forKey: "businness_user_id")
        }
        if firebase_token != nil{
            aCoder.encode(firebase_token, forKey: "firebase_token")
        }
        if stripe_publishable_key != nil{
            aCoder.encode(stripe_publishable_key, forKey: "stripe_publishable_key")
        }
        
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }
        if firstname != nil{
            aCoder.encode(firstname, forKey: "firstname")
        }
        if lastname != nil{
            aCoder.encode(lastname, forKey: "lastname")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        
        if user_type != nil{
            aCoder.encode(user_type, forKey: "user_type")
        }
        if mobile_no != nil{
            aCoder.encode(mobile_no, forKey: "mobile_no")
        }
        if postcode != nil{
            aCoder.encode(postcode, forKey: "postcode")
        }
        if profile_pic != nil{
            aCoder.encode(profile_pic, forKey: "profile_pic")
        }
        if about_me != nil{
            aCoder.encode(about_me, forKey: "about_me")
        }
        if average_rating != nil{
            aCoder.encode(average_rating, forKey: "average_rating")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if portfolio_image1 != nil{
            aCoder.encode(portfolio_image1, forKey: "portfolio_image1")
        }
        if portfolio_image2 != nil{
            aCoder.encode(portfolio_image2, forKey: "portfolio_image2")
        }
        if portfolio_image3 != nil{
            aCoder.encode(portfolio_image3, forKey: "portfolio_image3")
        }
        if portfolio_image4 != nil{
            aCoder.encode(portfolio_image4, forKey: "portfolio_image4")
        }
        if portfolio_image5 != nil{
            aCoder.encode(portfolio_image5, forKey: "portfolio_image5")
        }
        if portfolio_image6 != nil{
            aCoder.encode(portfolio_image6, forKey: "portfolio_image6")
        }
        
        if course_charge != nil{
            aCoder.encode(course_charge, forKey: "course_charge")
        }
        if services_ids != nil{
            aCoder.encode(services_ids, forKey: "services_ids")
        }
        if country_id != nil{
            aCoder.encode(country_id, forKey: "country_id")
        }
        if city_id != nil{
            aCoder.encode(city_id, forKey: "city_id")
        }
        if expertise_id != nil{
            aCoder.encode(expertise_id, forKey: "expertise_id")
        }
    }
}
