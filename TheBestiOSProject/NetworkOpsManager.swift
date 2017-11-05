//
//  NetworkOpsManager.swift
//  TheBestiOSProject
//
//  Created by sanooj on 11/3/17.
//  Copyright © 2017 DCore. All rights reserved.
//

import Foundation


//MARK: - Protocols
protocol NetworkRequestsManager
{
    func makeAPOSTRequest()
    func makeGETRequest()
    func makePUTRequest()
    func makeHEADRequest()
    func makeDELETERequest()
    
}

//Protocol
//Set of variables to be implemented
//Separates out all components requited to create a url request
//also represents url response
protocol URLRequestComponents
{
    var baseURL:String {get set}
    var path: String {get set}
    var finalULRString: String {get set}
    var fullyFormedURL: URL? {get set}
    var urlRequest: URLRequest? {get set}
    var headers: [String:String] {get set}
    var encoding: URLEncoding {get set}
    var httpMethod: HTTPMethod { get set}
    var httpBody: Data? { get set}
    var response: URLResponse? {get set}
    var error: Error? {get set}
    var data: Data? {get set}
}


//Public API methods from WS call
protocol URLRequestConvertible
{
    associatedtype Element
    
    func request(withBaseURL baseURL: String, andPath path: String) -> Element
    
    func ofType(method:HTTPMethod)-> Element
    
    func withSessionType(
        sessionType:URLSessionType,
        completionHandler:
        @escaping (_ data:Data?, _ urlResponse:URLResponse?, _ error:Error?)->()
    ) -> Element
    
    func make() -> Element
    
    func cancel() -> Element
    
    func invalidate() -> Element
    
}

//Types of URL encoding supported
enum URLEncoding
{
    case JSONEncoding
    case URLEncoding
    case NoEncoding
}

//MARK: - Enums

//https://github.com/Alamofire/Alamofire/blob/c8a4d3a910bcfd53b9b855463495b8200ca80fd6/Source/ParameterEncoding.swift
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum URLSessionType:Int
{
    case shared
    case `default`
    case ephermeral
    case background
    case custom
}

enum URLSessionTaskType:Int
{
    case data
    case upload
    case dowload
}

//MARK: - Classes

/*
 Public API
 Abstracts away the internal HTTPRequestMaker class
 which performs the HTTPRequest request
 */
class HTTPRequest
{
    // this should be private
    //and all access to properties of HTTPRequestMaker should be made via methods in this class
    //implemented all for the sake of simplicity
    //Only required property values need to be exposed to public use
    fileprivate let httpRequestMaker:HTTPRequestMaker =
        HTTPRequestMaker()
    
    var httpMethod: HTTPMethod
    {
        return httpRequestMaker.httpMethod
    }
    
    var httpBody: Data?
    {
        return httpRequestMaker.httpBody
    }
    
    var urlRequest: URLRequest?
    {
        return httpRequestMaker.urlRequest
    }
    
    var headers: [String : String]
    {
        return httpRequestMaker.headers
    }
    
    var encoding: URLEncoding
    {
        return httpRequestMaker.encoding
    }
    
    var baseURL:String
    {
        return httpRequestMaker.baseURL
    }
    
    var path: String
    {
        return httpRequestMaker.path
    }
    
    var finalULRString: String
    {
        return httpRequestMaker.finalULRString
    }
    
    var fullyFormedURL: URL?
    {
        return httpRequestMaker.fullyFormedURL
    }
    
    var response: URLResponse?
    {
        return httpRequestMaker.response
    }
    
    var error: Error?
    {
        return httpRequestMaker.error
    }
    
    var data: Data?
    {
        return httpRequestMaker.data
    }
    
}


/*
 Main Request Handler
 */
private class HTTPRequestMaker:URLRequestComponents
{
    
    //URLRequestComponents
    //associated type Protocol Conformance
    typealias Element = HTTPRequestMaker
    
    var httpMethod: HTTPMethod = HTTPMethod.get
    var httpBody: Data? = nil
    var urlRequest: URLRequest? = nil
    var headers: [String : String] = [:]
    var encoding: URLEncoding = .NoEncoding
    var baseURL:String = ""
    var path: String = ""
    var finalULRString: String = ""
    var fullyFormedURL: URL? = nil
    var response: URLResponse? = nil
    var error: Error? = nil
    var data: Data? = nil
    
    //private vars
    fileprivate var session: URLSession? = nil
    fileprivate var sessionType:URLSessionType = .shared
    fileprivate var task:URLSessionTask? = nil
    
}


//MARK: - Extensions

extension HTTPRequestMaker
{
    ///Utility functions
    
    //Make a URL by combing Base and Path URL Strings
    @discardableResult
    func makeAFullyFormedURL(withBaseURL baseURL: String, andPath path: String) -> HTTPRequestMaker {
        
        let urlString:String  =
            self.fullyFormedURLString(baseURL: baseURL, path: path)
        
        let finalULRString:URL? =
            URL(string: urlString)
        
        self.fullyFormedURL =
        finalULRString
        
        return self
    }
    
    ///Save the passed in values
    func attachToURLRequest(headers httpHeaders: [String : String], andHttpBody httpBoadyData: Data?) -> HTTPRequestMaker {
        
        self.urlRequest?.allHTTPHeaderFields =
        httpHeaders
        
        self.urlRequest?.httpBody =
        httpBoadyData
        
        return self
    }
    
    func fullyFormedURLString(baseURL:String , path: String )-> String
    {
        if URLValidations.isAnHttpURL(url: baseURL)
        {
            self.baseURL =
                (baseURL.last == "/") ? String(baseURL.dropLast()) : baseURL
            
            self.path =
                (path.first == "/") ? String(path.dropFirst()) : path
            
            return self.baseURL + "/" + self.path
        }
        else
        {
           return ""
        }
        
    }
}

//MARK: - Reachability
//Simplified with just a HEAD request
//ideal Scenario
//use SCNetworkRechability API
func isOnline(completionHandler:@escaping (Bool)->())
{
    HTTPRequest().request(
        withBaseURL: "http://www.example.com", andPath: ""
    ).ofType(
        method: HTTPMethod.head
        ).withSessionType
        { (data:Data?, response:URLResponse? , error:Error?)in
            
            let isOnline:Bool =
            { (response:URLResponse?) in
                
                if let httpRespose:HTTPURLResponse = response as? HTTPURLResponse ,
                    httpRespose.statusCode == 200
                {
                    return true
                }
                
                return false
                
            }(response)
            
            completionHandler(isOnline)
    }
}


//MARK: - Network call
extension HTTPRequest:URLRequestConvertible
{
    //Public API protocol Conformance
    //URLRequestConvertible
    func request(withBaseURL baseURL: String, andPath path: String) -> HTTPRequest
    {
        self.httpRequestMaker.makeAFullyFormedURL(
            withBaseURL: baseURL,
            andPath: path
        )
        
        return self
    }
    
    func ofType(method:HTTPMethod)-> HTTPRequest
    {
        self.httpRequestMaker.httpMethod =
        method
        
        return self
    }
    
    @discardableResult
    func withSessionType(
        sessionType:URLSessionType = .shared,
        completionHandler:@escaping (_ data:Data?, _ urlResponse:URLResponse?, _ error:Error?)->()
        ) -> HTTPRequest
    {
        
        guard let fullyFormedURL:URL =
            self.httpRequestMaker.fullyFormedURL else
        {
            
            let errorStub =
                ErrorStub.NetworkError(ErrorCodes.foundNil)
            
            let error =
                NSError.init(
                    domain: errorStub.domian,
                    code: errorStub.code.rawValue,
                    userInfo:errorStub.userInfo
            )
            
            completionHandler(nil,nil,error)
            return self
        }
        
        var urlRequest =
            URLRequest(
                url: fullyFormedURL,
                cachePolicy:
                URLRequest.CachePolicy.returnCacheDataDontLoad,
                timeoutInterval: TimeInterval.init(30.0) //random
        )
        
        urlRequest.httpMethod =
            self.httpRequestMaker.httpMethod.rawValue
        
        urlRequest.allHTTPHeaderFields =
            self.httpRequestMaker.headers
        
        urlRequest.httpBody =
            self.httpRequestMaker.httpBody
        
        self.httpRequestMaker.urlRequest =
        urlRequest
        
        guard let request:URLRequest =
        self.httpRequestMaker.urlRequest else
        {
            
            let errorStub =
            ErrorStub.NetworkError(ErrorCodes.foundNil)
            
            let error =
                NSError.init(
                    domain: errorStub.domian,
                    code: errorStub.code.rawValue,
                    userInfo:errorStub.userInfo
            )
            
            completionHandler(nil,nil,error)
            return self
        }
        
        let session:URLSession =
            Session.getSession(
                sessionType: sessionType
        )
        
        self.httpRequestMaker.session =
        session
        
        let task:URLSessionDataTask =
            session.dataTask(with: request)
            { (data:Data?, urlResponse:URLResponse?, error:Error?) in
                
                self.httpRequestMaker.data =
                    data
                
                self.httpRequestMaker.response =
                    urlResponse
                
                self.httpRequestMaker.error =
                    error
                
                completionHandler(data,urlResponse,error)
                
                return
        }
        
        self.httpRequestMaker.task =
            task

        return self
    }
    
    @discardableResult
    func make() -> HTTPRequest
    {
        if let task = self.httpRequestMaker.task , task.state == .suspended
        {
            self.httpRequestMaker.task?.resume()
        }
        
        return self
    }
    
    func cancel() -> HTTPRequest
    {
        self.httpRequestMaker.task?.cancel()
        
        return self
    }

    func invalidate() -> HTTPRequest
    {
        self.httpRequestMaker.session?.invalidateAndCancel()
        
        return self
    }
}

