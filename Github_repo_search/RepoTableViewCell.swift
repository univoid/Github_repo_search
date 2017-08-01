//
//  RepoTableViewCell.swift
//  Github_repo_search
//
//  Created by YUHUI ZHENG on 2017/07/30.
//  Copyright © 2017 YUHUI ZHENG. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        // Make description multilines
        desLabel.numberOfLines = 0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Make description field size to fit
    override func layoutSubviews() {
        super.layoutSubviews()
        desLabel.sizeToFit()
        desLabel.frame.size.width = 340
    }

}
