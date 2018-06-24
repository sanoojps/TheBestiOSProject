//
//  TBIBaseTableViewCell.swift
//  TheBestiOSProject
//
//  Created by Sanooj on 17/06/2018.
//  Copyright © 2018 DCore. All rights reserved.
//

import UIKit

class TBIBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TBIBaseTableViewCell
{
    func configureCornerRadiusForView(_ view:UIView)
    {
        view.layer.cornerRadius = 20.0
    }
}
