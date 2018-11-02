//
//  TwitterLoginHelper.swift
//  Snax
//
//  Created by Darshit Vadodaria on 01/11/18.
//  Copyright © 2018 Simfrom Solutions. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit


public struct TwitterUserData {
    let firstName: String
    let lastName: String
    let email: String
    let userID: Int
    let profilePicURL:String?
    let dateOfBirth:Date?
}

public class TwitterLoginHelper: NSObject {
    
    public static let sharedInstance : TwitterLoginHelper = {
        let instance = TwitterLoginHelper()
        return instance
    }()
    
    private var lastUser:String? = ""
    
    
    public func twitterStartwith(consumerKey: String, consumerSecret: String) {
        TWTRTwitter.sharedInstance().start(withConsumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    
    public func twitterConfigurationWithOptions(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
    public func doLoginWithTwitter(completion:@escaping (_ isSuccess: Bool, _ error: Error?) -> ()) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (session != nil) {
                self.lastUser = session?.userID
                completion(true, nil)
            } else {
                print("error: \(error?.localizedDescription ?? "")")
                completion(false, error)
            }
        }
    }
    
    public func getLoggedInUserDetailswith(permission: [String: Any] = TwitterDefaultPermission.userPermission, completion:@escaping (_ userData: TwitterUserData?, _ error: Error?) -> ()) {
        let store = TWTRTwitter.sharedInstance().sessionStore
        if store.session(forUserID: self.lastUser!) != nil   {
            let client = TWTRAPIClient.withCurrentUser()
            let request = client.urlRequest(withMethod: "GET", urlString: TwitterURL.VerifyCredentails, parameters: permission , error: nil)
            
            client.sendTwitterRequest(request, completion: { (response, data, error) in
                print("\n\(String(describing: data)) \(String(describing: response)) \(String(describing: error))\n\n")
                if data != nil {
                    if let jsonData = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        let responseData = TwitterUserData(firstName: jsonData["name"] as? String ?? "", lastName: "", email: jsonData["email"]  as? String ?? "", userID: jsonData["id"] as? Int ?? 0, profilePicURL: jsonData["profile_image_url"] as? String ?? "", dateOfBirth: nil)
                        completion(responseData, nil)
                    }
                    else {
                        completion(nil,TwitterError.ParsingError)
                    }
                }
                else {
                    completion(nil, error)
                }
            })
            
        } else {
            completion(nil, TwitterError.UserUnauthorized)
        }
    }
    
    func logoutFromTwitter() {
        
        let url:URL = URL.init(string: TwitterURL.Logout)!
        let cookies = HTTPCookieStorage.shared.cookies(for: url)
        for cookie in cookies! {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
        TWTRTwitter.sharedInstance().sessionStore.logOutUserID(lastUser!)
    }
}
