//
//  TwitterConstant.swift
//  TwitterDemo
//
//  Created by Darshit Vadodaria on 02/11/18.
//  Copyright © 2018 Simfrom Solutions. All rights reserved.
//

import Foundation

public struct TwitterError {
    static let UserUnauthorized:NSError = NSError(domain: "ShiploopHttpResponseErrorDomain", code:401 , userInfo: [NSLocalizedDescriptionKey:"Unauthorized",                                                                                                              NSLocalizedFailureReasonErrorKey:"User not logged in"])
    static let ParsingError:NSError = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 422, userInfo: [NSLocalizedDescriptionKey:"Parsing Error",                                                                                                         NSLocalizedFailureReasonErrorKey:"User data parsing error"])
}


public struct TwitterURL {
    static let VerifyCredentails = "https://api.twitter.com/1.1/account/verify_credentials.json"
    static let Logout = "https://api.twitter.com"
}

public enum ReadPermissions :String {
    case includeEmail          =  "include_email"
    case skipStatus            =  "skip_status"
}

public struct TwitterDefaultPermission {
    public static let userPermission: [String: Any] = [ReadPermissions.includeEmail.rawValue: "true", ReadPermissions.skipStatus.rawValue: "true"]
}
