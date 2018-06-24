//
//  DocmentationCommentsHelp.swift
//  TheBestiOSProject
//
//  Created by Sanooj on 25/06/2018.
//  Copyright © 2018 DCore. All rights reserved.
//

import Foundation

struct Demo
{
    // MARK: - General description
    ///
    /// General description
    ///
    let description: String = ""
    
    // MARK: - Example
    /// This is an example
    ///
    ///     var godotHasArrived = false
    ///
    ///     let numbers = 1...5
    ///     let containsTen = numbers.contains(10)
    ///     print(containsTen)
    ///     // Prints "false"
    ///
    ///     let (a, b) = (100, 101)
    ///     let aFirst = a < b
    ///     print(aFirst)
    ///     // Prints "true"
    ///
    let example: Bool = true
    
    // MARK: - standout
    ///
    /// `Bool` represents Boolean values in Swift. Create instances of `Bool`
    ///
    let standout:String = ""
    
    // MARK: - bold
    ///
    /// Using Imported Boolean values
    /// =============================
    ///
    /// Unicode Scalar View
    /// -------------------
    ///
    let bold: String = ""
    
    // MARK: - Italics
    ///
    /// *String interpolations*
    /// are string literals that evaluate any included
    ///
    let italics: String = ""
    
    /// MARK: - Function Documentation
    ///
    /// Function
    /// -----------
    /// Encodes this value into the given encoder.
    ///
    /// Description
    /// -----------
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// Parameters
    /// -----------
    /// - Parameter encoder: The encoder to write data to.
    ///
    /// Return value
    /// -----------
    /// - Returns: The return value, if any, of the `body` closure parameter.
    ///
    func method(endoder: String) -> Void {}
    
    // MARK: - Property Documentation
    ///
    /// The indices that are valid for subscripting the collection, in ascending
    /// order.
    ///
    public var indices: CountableRange<Int>
    
}
