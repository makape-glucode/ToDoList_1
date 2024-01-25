//
//  ToDoTableView.swift
//  AppToDoList
//
//  Created by Makape Tema on 2023/03/14.
//

//import Foundation
import UIKit
import CoreData

var models = [AppToDoList]()

class ToDoTableView: UITableViewController, UISearchResultsUpdating {
    
        
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var firstLoad = true
    
    //try search
    let searchControl = UISearchController()
    
    lazy var searchToDo :[AppToDoList] = {
        return models
    }()
    //
    var selectedTask: AppToDoList? = nil
    
    override func viewDidLoad() {
        if(firstLoad) {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppToDoList")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let doTheApp = result as! AppToDoList
                    models.append(doTheApp)
                }
            } catch {
                print("Fetch failed")
            }
            
        }
        
        //search
        searchControl.searchResultsUpdater = self
        navigationItem.searchController = searchControl
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
            searchToDo = models.filter(){
                $0.name?.contains(text) ?? false
            }
            
            if searchToDo.count == 0 {
                searchToDo = models
            }
            tableView.reloadData()
    }
    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoCell
        
        let theTask: AppToDoList!
        theTask = models[indexPath.row]
        
        tableCell.nameLabel.text = theTask.name
        //tableCell.describeLabel.text = theTask.taskDescription
        
        
        
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count /* + searchToDo.count */
        //return searchToDo.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editTask", sender: self)
        let item = models[indexPath.row]
    }
    //delete
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppToDoList")
        
        tableView.beginUpdates()
        models.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
        
        if  let result = try? context.fetch(request) {
            for str in result as! [NSManagedObject]{
                context.delete(str)
            }
        }
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editTask") {
//            let indexPath = tableView.indexPathForSelectedRow!
//
//            let taskDetail = segue.destination as? ViewController
//
//
//            let selectedTask: AppToDoList!
//            selectedTask = models[indexPath.row]
//            taskDetail!.selectedTask = selectedTask
//
//            //seacrh
//            //taskDetail?.todo = searchToDo[tableView.indexPathForSelectedRow!.row]
//            /* */
//
//            tableView.deselectRow(at: indexPath, animated: true)
            
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let taskDetail = segue.destination as? ViewController
                let selectedTask: AppToDoList!
                selectedTask = models[indexPath.row]
                taskDetail!.selectedTask = selectedTask
            } else {
                print("Error")
                tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    //Core daat
    func getAllItems() {
        do {
            models = try context.fetch(AppToDoList.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            // error
        }
    }
    
    func deleteItem(item: AppToDoList) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
}


