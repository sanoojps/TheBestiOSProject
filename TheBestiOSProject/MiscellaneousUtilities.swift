//
//  MiscellaneousUtilities.swift
//  TheBestiOSProject
//
//  Created by sanooj on 11/4/17.
//  Copyright © 2017 DCore. All rights reserved.
//

import Foundation
import Darwin

//MARK: - Debug Log
///https://github.com/JungleCandy/LoggingPrint/blob/master/LoggingPrint.swift
/// Prints the filename, function name, line number and textual representation of `object` and a newline character into the standard output if the build setting for "Active Complilation Conditions" (SWIFT_ACTIVE_COMPILATION_CONDITIONS) defines `DEBUG`.
///
/// The current thread is a prefix on the output. <UI> for the main thread, <BG> for anything else.
///
/// Only the first parameter needs to be passed to this funtion.
///
/// The textual representation is obtained from the `object` using `String(reflecting:)` which works for _any_ type. To provide a custom format for the output make your object conform to `CustomDebugStringConvertible` and provide your format in the `debugDescription` parameter.
/// - Parameters:
///   - object: The object whose textual representation will be printed. If this is an expression, it is lazily evaluated.
///   - file: The name of the file, defaults to the current file without the ".swift" extension.
///   - function: The name of the function, defaults to the function within which the call is made.
///   - line: The line number, defaults to the line number within the file that the call is made.
@inline(__always) func loggingPrint<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line ,shouldSkipForRelease:Bool = {
    #if DEBUG
        return false; #else
        return true; #endif
    }()
    )
{
    if !shouldSkipForRelease
    {
        let value = object()
        let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
        let queue = Thread.isMainThread ? "UI" : "BG"
        
        print("<\(queue)> \(fileURL) \(function)[\(line)]: " + String(reflecting: value))
    }
    
}

//MARK: - Data Validations Container

//stub validations protocol
protocol DataValidations
{
    //stub
}

struct Validations : DataValidations
{
    struct URL: DataValidations
    {
        //Empty
        //Inner Container to keep things organised
        //All URL validations Would go here
    }
    
    struct String: DataValidations
    {
        //Empty
        //Inner Container to keep things organised
        //All String validations Would go here
    }
}

//MARK: - URLValidations
typealias URLValidations = Validations.URL
extension URLValidations
{
    static func isAnHttpURL(url:String) -> Bool
    {
        let httpURLValidationRegExPattern:String =
        "^https?://"
        
        guard let httpURLValidationRegEx: NSRegularExpression =
            try? NSRegularExpression(
                pattern: httpURLValidationRegExPattern,
                options: [NSRegularExpression.Options.anchorsMatchLines,.caseInsensitive]
            ) else
        {
            return false
        }
        
        let range: NSRange =
            NSRange(location: 0, length: url.count)
        
        //find the first match
        guard let result:NSTextCheckingResult =
            httpURLValidationRegEx.firstMatch(
                in: url,
                options: NSRegularExpression.MatchingOptions.anchored,
                range: range
            ) else
        {
            return false
        }
        
        loggingPrint(httpURLValidationRegEx.pattern)
        
        return (result.resultType == NSTextCheckingResult.CheckingType.regularExpression)
    }
    
    
}

//MARK: - StringValidations
typealias StringValidations = Validations.String
extension StringValidations
{
    
}

//MARK: - Identifiers
final class Identifiers
{
    static var programName:String
    {
        /*returns a CString
         //used for commandLineUtilities
         */
        //CString
        if let programName:UnsafePointer<Int8> =
            getprogname()
        {
            //CString to swift
            let programName:String =
                String.init(cString: programName)
            
            return programName
        }
        
        return String(
            format: NSLocalizedString(
                "NO_NAME_BUNDLE_ID",
                comment: "NO_NAME_BUNDLE_ID"),
            Date().timeIntervalSince1970
        )
        
    }
    
    static var bundle:Bundle
    {
        let bundle:Bundle =
            Bundle(for: self)
        
        return bundle
    }
    
    static var bundleName:String
    {
        let bundleName:String =
            bundle.object(
                forInfoDictionaryKey: "CFBundleName") as? String ?? programName
        
        return bundleName
    }
    
    static var bundleDisplayName:String
    {
        let bundleDisplayName:String =
            bundle.object(
                forInfoDictionaryKey: "CFBundleDisplayName") as? String
                ?? programName
        
        return bundleDisplayName
    }
    
    static var backgroundSessionIdentifier: String
    {
        return ("com.\(bundleDisplayName).backgroundURLSession")
    }
}

struct Session {
    
    static func getSession(
        sessionType:URLSessionType = .`default`,
        customConfiguration:URLSessionConfiguration? = nil
        ) -> URLSession
    {
        switch sessionType
        {
        case .shared:
            return URLSession.shared
            
        case .`default`:
            return URLSession(
                configuration: URLSessionConfiguration.default
            )
            
        case .ephermeral:
            return URLSession(
                configuration: URLSessionConfiguration.ephemeral
            )
            
        case .background:
            return URLSession(
                configuration: URLSessionConfiguration.background(
                    withIdentifier: Identifiers.backgroundSessionIdentifier
                )
            )
            
        case .custom:
            return {
                if let customConfiguration = customConfiguration
                {
                    return URLSession.init(
                        configuration: customConfiguration
                    )
                }
                else
                {
                    return URLSession.shared
                }
                }()
        }
    }
    
}

//MARK: - Error Codes
enum ErrorDomains:String
{
    case network = "network"
    case file = "file"
    case database = "database"
    case unknown = "unknown"
}

protocol ErrorComponets
{
    var domian:String {get set}
    var userInfo:[String:Any]? {get set}
    var localizedDescriptionKey: String? {get set}
    var code:ErrorCodes {get set}
    init(_ code:ErrorCodes, _ errorDescription:String?)
}

enum ErrorCodes:Int
{
    case genericIOError = 99999
    case unknownError = 100000
    case foundNil = 88888
    case notReachable = 87777
}

enum ErrorCodeDescriptions:String
{
    case genericIOError = "A network error occurred."
    case unknownError = "An unknown error occurred."
    case foundNil = "Found \"Nil\" while unwrapping."
    case notReachable = "Network Unreachable"
}


struct ErrorStub
{
    class NetworkError:UnknownError
    {
        required init(_ code: ErrorCodes = ErrorCodes.unknownError , _ errorDescription:String? = nil)
        {
            super.init(code, errorDescription)
            
            //set domain
            self.domian =
            "com.\(Identifiers.bundleDisplayName).error.\(ErrorDomains.network.rawValue)"
        }
    }
    
    class FileError
    {
        
    }
    
    class DatabaseError
    {
        
    }
    
    class UnknownError:ErrorComponets
    {
        var domian: String =
        "com.\(Identifiers.bundleDisplayName).error.\(ErrorDomains.unknown.rawValue)"
    
        var code:ErrorCodes =
            ErrorCodes.unknownError
        
        var userInfo:[String:Any]? =
            [NSLocalizedDescriptionKey : ErrorCodeDescriptions.unknownError]
        
        var localizedDescriptionKey: String? =
            ErrorCodeDescriptions.unknownError.rawValue
        
        required init (_ code: ErrorCodes = ErrorCodes.unknownError , _ errorDescription:String? = nil)
        {
            //set code
            self.code = code
            
            //set localizedDescriptionKey
            self.localizedDescriptionKey =
            UnknownError.getLocalizedDescriptionKey(
                code: code,
                errorDescription: errorDescription
            )
    
            //set userinfo
            self.userInfo =
            UnknownError.getUserInfo(
                code: code,
                errorDescription: errorDescription
            )
        }
    }
    
    
}

private extension ErrorStub.UnknownError
{
    private static func getLocalizedDescriptionKey (
        code: ErrorCodes,
        errorDescription:String?
        ) -> String
    {
        //set localizedDescriptionKey
        if let errorDescription = errorDescription
        {
            return errorDescription
        }
        else
        {
            switch code
            {
            case .genericIOError:
                return ErrorCodeDescriptions.genericIOError.rawValue
                
            case .foundNil:
                return ErrorCodeDescriptions.foundNil.rawValue
                
            case .notReachable:
                return ErrorCodeDescriptions.notReachable.rawValue
                
            default:
                return ErrorCodeDescriptions.unknownError.rawValue
            }
        }
    }
    
    private static func getUserInfo(
        code: ErrorCodes,
        errorDescription:String?
        ) -> [String:Any]
    {
        //set userInfo
        if let errorDescription = errorDescription
        {
            return [NSLocalizedDescriptionKey :errorDescription]
        }
        else
        {
            switch code
            {
            case .genericIOError:
                
                return
                    [NSLocalizedDescriptionKey : ErrorCodeDescriptions.genericIOError.rawValue]
                
            case .foundNil:
                
                return
                    [NSLocalizedDescriptionKey : ErrorCodeDescriptions.foundNil.rawValue]
                
            case .notReachable:
                return [NSLocalizedDescriptionKey :ErrorCodeDescriptions.notReachable.rawValue]
                
            default:
                
                return
                    [NSLocalizedDescriptionKey : ErrorCodeDescriptions.unknownError.rawValue]
            }
        }
        
    }
}
