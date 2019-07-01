//
//  HomeViewController.swift
//  DemoViperWithAPI
//
//  Created by mp on 30/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    var presenter : ViewToPresenterHomeProtocol? = nil
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblList: UITableView!

    var arrUsers : [UserModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        tblList.tableFooterView = UIView(frame: CGRect.zero)
        tblList.tableHeaderView = UIView(frame: CGRect.zero)
        tblList.separatorStyle = .none
        
        arrUsers = [UserModel]()

        presenter?.fetchingBarberList(using: HomeModel(username: "", page: "0"))
    }
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        if let id : String = UserDetail.id {
            self.presenter?.logout(using: id)
        }
    }
}

extension HomeViewController: PresenterToViewHomeProtocol {
    func isLogout(isCompleted: Bool, message: String) {
        if isCompleted {
            UserStatus = UserType.Fresh.rawValue

            //Move to login screen
            let navController = UINavigationController(nibName: "navLogin", bundle: Bundle.main)
            navController.viewControllers = [LoginRouter.createLoginModule()]
            Constants.appDelegate.window?.rootViewController = navController
            Constants.appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    func onHomeResponseSuccess(arrUserDetail: [UserModel]) {
        self.arrUsers.append(contentsOf: arrUserDetail)
        self.tblList.reloadData()
    }
    
    func onHomeResponseFail(message: String) {
        CustomAlert().ShowAlert(message)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: MyEmployeeCell! = tableView.dequeueReusableCell(withIdentifier: "MyEmployeeCell") as? MyEmployeeCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "MyEmployeeCell", bundle: nil), forCellReuseIdentifier: "MyEmployeeCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "MyEmployeeCell") as? MyEmployeeCell
        }
        
        //        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        let model = self.arrUsers[indexPath.row]
        
        cell.lblName.text = model.username
        if let distance = model.distance {
            if distance.length > 0 {
                if distance == "0" {
                    cell.lblDistance.text = "0 km"
                }
                else if let distanceDb = Double(distance) {
                    cell.lblDistance.text = "\(distanceDb) km"
                } else {
                    cell.lblDistance.text = "-"
                }
            }
            else {
                cell.lblDistance.text = ""
            }
        }
        else {
            cell.lblDistance.text = ""
        }
        
        if let review_count = model.review_count {
            cell.lblReview.text = "(\(review_count))"
        }
        else {
            cell.lblReview.text = ""
        }
        
        if let workingTime = model.working_time {
            if workingTime.length > 0 {
                cell.lblWorkingTime.text = workingTime
            }
            else {
                cell.lblWorkingTime.text = ""
            }
        }
        else {
            cell.lblWorkingTime.text = ""
        }
        
        if let profilePic = model.profile_pic {
            cell.imgUser.sd_setImage(with: URL(string: profilePic))
        }
        
        if let average_rating = model.average_rating {
            cell.lblRatingBig.text = average_rating
        }
        else {
            cell.lblRatingBig.text = "0"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did selected at \(indexPath.row)")
//        selectedUser = self.arrUsers[indexPath.row]
//        self.performSegue(withIdentifier: "toProfileDetailVC", sender: self)
    }
}


