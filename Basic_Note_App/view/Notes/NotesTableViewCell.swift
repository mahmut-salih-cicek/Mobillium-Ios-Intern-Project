//
//  NotesTableViewCell.swift
//  Basic_Note_App
//
//  Created by xmod on 8.08.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
  
    @IBOutlet weak var noteContent: UILabel!
    @IBOutlet weak var noteTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
   

}
