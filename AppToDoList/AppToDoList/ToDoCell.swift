//
//  ToDoCell.swift
//  AppToDoList
//
//  Created by Makape Tema on 2023/03/14.
//

import Foundation
import UIKit

class ToDoCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var describeLabel: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    
    @IBOutlet var switchComplete: UISwitch!
    
}
