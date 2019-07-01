//
//  MovieInteractor.swift
//  DemoViper
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MovieInteractor: PresenterToInteractorMovieProtocol {
    var presenter: InteractorToPresenterMovieProtocol?
    
    func fetchMovies() {
        
        SVProgressHUD.show(withStatus: "Please wait while fetching movie list")
        
        Alamofire.request(API_MOVIE_LIST).responseJSON { (jsonResponse) in
            
            SVProgressHUD.dismiss()
            
            if jsonResponse.result.isSuccess {
                
                if let result = jsonResponse.result.value {
                    let jsonResult = JSON(result)
                    let responseModel : ResponseDataModel  = (ModelManager.sharedInstance.getResponseDataModel(jsonResult.dictionaryObject! as NSDictionary))
                    if responseModel.success {
                        if let movieList = responseModel.movie_list as? NSArray {
                            
                            let arrMovieModel: [MovieModel] = ModelManager.sharedInstance.getMovieModelArray(movieList)
                            self.presenter?.onMovieFetchSuccess(movieList: arrMovieModel)
                        }
                        else {
                            self.presenter?.onMovieFetchFailed()
                        }
                    }
                    else {
                        self.presenter?.onMovieFetchFailed()
                    }
                }
                else {
                    self.presenter?.onMovieFetchFailed()
                }
            }
            else {
                self.presenter?.onMovieFetchFailed()
            }
        }
    }
}
