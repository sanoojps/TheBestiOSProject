//
//  TDDProtocols.swift
//  TDDSwift
//
//  Created by Sanooj on 22/06/2018.
//  Copyright © 2018 Sanooj. All rights reserved.
//

import Foundation


//MARK: - Table View Related Protocols 
protocol TDDTableViewBaseDataSourceCollection
{
    associatedtype Element:Equatable
    
    ///Collection
    var dataSourceCollection:Array<Element> { get }
    
    //flag to use colletion count as number of sections insteda of rows
    var shouldUseSections: Bool { get }
    
}

protocol TDDTableViewDataSourceConfiguration: TDDTableViewBaseDataSourceCollection
{
    ///required init
    init(shouldUseSections:Bool, withDataSource dataSourceCollection: Array<Element> )
}
