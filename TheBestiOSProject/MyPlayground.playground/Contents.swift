//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Darwin

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()


//Testing APIS

//zip

let numbersA:CountableClosedRange<Int> = 1...4;
let numbersB:CountableClosedRange<Int> = 4...8;

print(zip(numbersA, numbersB))


let url = "HTtP://mediatemple.net"

url.localizedCaseInsensitiveContains("htt")

do
{
    let regex = try NSRegularExpression.init(pattern: "^https?://", options: [NSRegularExpression.Options.anchorsMatchLines,.caseInsensitive])
    
    print(regex.pattern)
    
    let range = NSRange.init(location: 0, length: url.count)
    
    let result:NSTextCheckingResult? =
        regex.firstMatch(in: url, options: [NSRegularExpression.MatchingOptions.anchored], range: range)
    
    let count =
    regex.numberOfMatches(in: url, options: [NSRegularExpression.MatchingOptions.anchored], range: range)
    
    if let result = result
    {
        print(result.resultType == NSTextCheckingResult.CheckingType.regularExpression)
    }
}
catch
{
    
}


do
{
    let detector = try NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
    
    let range = NSRange.init(location: 0, length: url.count)
    
    let result:NSTextCheckingResult? =
        detector.firstMatch(in: url, options: NSRegularExpression.MatchingOptions.anchored, range: range)
    if let result = result
    {
        print(result.resultType == NSTextCheckingResult.CheckingType.link)
    }
    
}
catch
{
    
}

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
func loggingPrint<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line ,shouldSkipForRelease:Bool = {
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

func isAnHttpURL(url:String) -> Bool
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
    
    loggingPrint(httpURLValidationRegEx.pattern,shouldSkipForRelease: true)
    
    return (result.resultType == NSTextCheckingResult.CheckingType.regularExpression)
}


isAnHttpURL(url: url)

String.init(cString: getprogname())



protocol StackOperation
{
    associatedtype Element
    
    var isEmpty: Bool {get}
    
    var count: Int {get}
    
    //LIFO
    mutating func push(_ element: Element)
    
    mutating func pop() -> Element?
    
    func peek() -> Element?
}


struct Stack<T>:StackOperation
{
    typealias Element = T
    
    //data store
    private var dataStore:[T] =
        []
    
    var isEmpty: Bool
    {
        return self.dataStore.isEmpty
    }
    
    var count: Int
    {
        return self.dataStore.count
    }
    
    mutating func push(_ element: T)
    {
        self.dataStore.append(element)
    }
    
    mutating func pop() -> T? {
        return self.dataStore.popLast()
    }
    
    func peek() -> T?
    {
        return self.dataStore.last
    }
    
    
    
    
}


//MARK - Validators
struct Validators
{
    struct DateValidator
    {
        static func validateDate(_ dateString:String , againstFormat dateFormatString:String) -> Bool
        {
            let dateFormat:DateFormatter =
                DateFormatter()
            
            dateFormat.dateFormat =
            dateFormatString
            
            guard let date:Date =
                dateFormat.date(from: dateString) else
            {
                return false
            }
            
            loggingPrint(date)
            
            return true
        }
    }
}

struct Formats
{
    struct DateFormats
    {
        //DD - days in a year
        //MM - month in year
        //yy - year
        static let DDMMYYYY =
        "DD/MM/YYYY"
        
        static let ddMMYYYY =
        "dd/MM/YYYY"
    }
}

let date = "27/10/1986"
let format = "dd/mm/yyyy"

let formatA = "dd/MM/yyyy" //gives proper date 05/11/2017"

let formatB = "DD/MM/yyyy" //309/11/2017 //gives year

let dateFormat:DateFormatter =
    DateFormatter()

dateFormat.locale =
    Locale.current

dateFormat.dateFormat =
formatA

dateFormat.string(from: Date())

let nu_date =
dateFormat.date(from: date)!

dateFormat.string(from: nu_date)

let ddmmyyyRegex = "([0-9]{2}/[0-9]{2}/[0-9]{4})"

let httpURLValidationRegEx: NSRegularExpression! =
    try? NSRegularExpression(
        pattern: ddmmyyyRegex,
        options: [NSRegularExpression.Options.anchorsMatchLines,.caseInsensitive]
    )



let range: NSRange =
    NSRange(location: 0, length: date.count)

//find the first match
let result:NSTextCheckingResult! =
    httpURLValidationRegEx.firstMatch(
        in: date,
        options: NSRegularExpression.MatchingOptions.anchored,
        range: range
    )

