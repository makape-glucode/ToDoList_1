//
//  categoryViewController.swift
//  AppToDoList
//
//  Created by Makape Tema on 2023/03/22.
//

import UIKit
import CoreData

class categoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var categorySegment: UISegmentedControl!
    
    
    @IBOutlet var categoryTable: UITableView!
    
    //var theRef = ToDoTableView.self
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTable.dataSource = self
        categoryTable.delegate = self
        categoryTable.backgroundColor = .gray
        
        
        
        if models.isEmpty {
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
               let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppToDoList")
               
               do {
                   let results: [AppToDoList] = try context.fetch(request) as! [AppToDoList]
                   models = results
               } catch {
                   print("Fetch failed")
                   view.addSubview(categoryTable)
               }
           }
    }
    

    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                view.backgroundColor = .cyan
            case 1:
                view.backgroundColor = .red
            case 2:
                view.backgroundColor = .green
            case 3:
                view.backgroundColor = .darkGray
            case 4:
                view.backgroundColor = .systemGray3
            default:
                break
            }
            
            categoryTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch categorySegment.selectedSegmentIndex {
            case 0:
                return models.filter { $0.category == 0 }.count
            case 1:
                return models.filter { $0.category == 1 }.count
            case 2:
                return models.filter { $0.category == 2 }.count
            case 3:
                return models.filter { $0.category == 3 }.count
            case 4:
                return models.filter { $0.category == 4 }.count
            default:
                return 0
            }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let theTask: AppToDoList!
        theTask = models[indexPath.row]
        
        tableCell.textLabel?.text = theTask.name
        
        return tableCell
    }
    
    
    
}
