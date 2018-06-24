//
//  Requests.swift
//  TheBestiOSProject
//
//  Created by Sanooj on 17/06/2018.
//  Copyright © 2018 DCore. All rights reserved.
//

import Foundation

/**
 * An attempt at cloning "requests" API library for python
 * - only basic URL Requests first
 */

/**
 * Goals
 * -----
 * A cutomization point for all parameters that make up an HTTP request
 * A way to use any Native / 3rd Party HTTP Library as backen to make actuals HTTP request
 * add support to use Network framework (Network) and Sockets
 *
 * Reasoning
 * ----------
 * "Moya" swift library takes an approach
 * "https://github.com/Moya/Moya/blob/master/docs/Examples/Basic.md"
 * I feel is too verbose
 */


/*
 * URLComponents - class
 * Has all components to make a URL
 *  https://cocoacasts.com/working-with-nsurlcomponents-in-swift
 */


struct URLComponents
{
    enum HTTPProtocols: String
    {
        case http
        case https
        case file
    }
    
    func makeAURL() -> URLComponents
    {
        return self
    }
    
    func withProtocol(_ protocol: HTTPProtocols = .http) -> URLComponents
    {
        return self
    }
    
    
}

struct ReQuests
{
    func requestWith(type:String,url:String) -> ReQuests
    {
        //URLComponents
        //URlQuery Items
        //URL
        
        return self
    }
}
