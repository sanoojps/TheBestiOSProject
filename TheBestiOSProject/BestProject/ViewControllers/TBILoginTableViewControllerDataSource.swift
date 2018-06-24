//
//  TBILoginTableViewControllerDataSource.swift
//  TheBestiOSProject
//
//  Created by Sanooj on 25/06/2018.
//  Copyright © 2018 DCore. All rights reserved.
//

import Foundation
import UIKit.UITableView

class TBILoginTableViewControllerDataSource: TDDTableViewBaseDataSource<TBILoginCredentials>
{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       return super.tableView(tableView, cellForRowAt: indexPath)
    }
}

