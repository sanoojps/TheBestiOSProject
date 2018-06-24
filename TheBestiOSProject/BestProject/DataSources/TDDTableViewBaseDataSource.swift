//
//  TDDTableViewBaseDataSource.swift
//  TDDSwift
//
//  Created by Sanooj on 04/06/2018.
//  Copyright © 2018 Sanooj. All rights reserved.
//

import UIKit

class TDDTableViewBaseDataSource<Element:Equatable>: NSObject,
    TDDTableViewDataSourceConfiguration , UITableViewDataSource, UITableViewDelegate
{
    let shouldUseSections: Bool
    
    let dataSourceCollection: Array<Element>
    
    required init(shouldUseSections:Bool, withDataSource dataSourceCollection: Array<Element>)
    {
        self.shouldUseSections =
        shouldUseSections
        
        self.dataSourceCollection =
        dataSourceCollection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if shouldUseSections
        {
           return 1
        }
        
        return self.dataSourceCollection.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        if shouldUseSections
        {
            return self.dataSourceCollection.count
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //stub conformance
        return UITableViewCell()
        
    }
}

extension TDDTableViewBaseDataSource
{
   
}
