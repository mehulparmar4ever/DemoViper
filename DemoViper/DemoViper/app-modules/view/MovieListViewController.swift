//
//  MovieListViewController.swift
//  DemoViper
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController {

    var moviePresenter:ViewToPresenterMovieProtocol?

    @IBOutlet weak var tableView : UITableView!
    
    var arrMovieList = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Movie module"
        moviePresenter?.startFetchingMovie()
    }
}

extension MovieListViewController : PresenterToViewMovieProtocol {
    func onMovieResponseSuccess(movieList: [MovieModel]) {
        self.arrMovieList = movieList
        self.tableView.reloadData()
    }
    
    func onMovieResponseFailed(error: String) {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let model = arrMovieList[indexPath.row]
        cell.mTitle.text = model.title
        cell.mDescription.text = model.brief
        cell.mImageView.sd_setImage(with: URL(string: model.imagesource))
        return cell
    }

}

class MovieCell:UITableViewCell{
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDescription: UILabel!
}
