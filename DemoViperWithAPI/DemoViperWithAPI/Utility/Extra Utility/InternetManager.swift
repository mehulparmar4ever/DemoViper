//
//  InternetManager.swift
//  Y5Lock
//
//  Created by mp on 01/06/19.
//  Copyright © 2019 Demo Project. All rights reserved.
//

import Foundation
import UIKit
import Reachability

public class InternetManager : NSObject {
    
    var reachability: Reachability!
    
    static let sharedInstance: InternetManager = { return InternetManager() }()
    
    override init() {
        super.init()
        
        reachability = Reachability()!
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    public func stopNotifier() -> Void {
        do {
            try (InternetManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    public func isReachable(completed: @escaping (InternetManager) -> Void) {
        if (InternetManager.sharedInstance.reachability).connection != .none {
            completed(InternetManager.sharedInstance)
        }
    }
    
    public func isUnreachable(completed: @escaping (InternetManager) -> Void) {
        if (InternetManager.sharedInstance.reachability).connection == .none {
            completed(InternetManager.sharedInstance)
        }
    }
    
    public func isReachableViaWWAN(completed: @escaping (InternetManager) -> Void) {
        if (InternetManager.sharedInstance.reachability).connection == .cellular {
            completed(InternetManager.sharedInstance)
        }
    }
    
    public func isReachableViaWiFi(completed: @escaping (InternetManager) -> Void) {
        if (InternetManager.sharedInstance.reachability).connection == .wifi {
            completed(InternetManager.sharedInstance)
        }
    }
}
