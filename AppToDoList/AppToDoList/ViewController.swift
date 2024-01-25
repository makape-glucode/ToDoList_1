//
//  ViewController.swift
//  AppToDo
//
//  Created by Makape Tema on 2023/03/13.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var taskName: UITextField!
    @IBOutlet var taskDescriptionToDo: UITextView!
    
    @IBOutlet var dateField: UITextField!
    
    @IBOutlet var segmentChange: UISegmentedControl!
    
    @IBOutlet var theSwitch: UISwitch!
    
    var selectedTask: AppToDoList? = nil
    
    var todo: AppToDoList?
    
    //Date Picker
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .systemBlue
        datePicker.minimumDate = Date()

        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ToDo or !ToDo"
        
        if (selectedTask != nil) {
            taskName.text = selectedTask?.name
            //taskDescriptionToDo.text = selectedTask?.taskDescription
            //theSwitch.isComplete = .isOn
            
        }
        
        dateField.addSubview(datePicker)
        
    }

    @IBAction func toggleComplete(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if (selectedTask == nil) {
            let entity = NSEntityDescription.entity(forEntityName: "AppToDoList", in: context)
            let newTask = AppToDoList(entity: entity!, insertInto: context)
//            newTask.id = models.count as NSNumber
            newTask.name = taskName.text
            
            newTask.category = segmentChange.numberOfSegments
            //newTask.taskDescription = taskDescriptionToDo.text
            
            do {
                try context.save()
                models.append(newTask)
                navigationController?.popViewController(animated: true)
                
            } catch {
                print("context save error")
            }
            
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppToDoList")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let doTheApp = result as! AppToDoList
                    if (doTheApp == selectedTask) {
                        doTheApp.name = taskName.text
                        doTheApp.category = segmentChange.numberOfSegments
                        //doTheApp.taskDescription = taskDescriptionToDo.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print("Fetch failed")
            }
        }
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if (selectedTask == nil) {
            let entity = NSEntityDescription.entity(forEntityName: "AppToDoList", in: context)
            let newTask = AppToDoList(entity: entity!, insertInto: context)
            newTask.id = models.count as NSNumber
            newTask.name = taskName.text
            newTask.category = segmentChange.numberOfSegments
            //newTask.category = segmentChange
            //newTask.taskDescription = taskDescriptionToDo.text
            
            do {
                try context.save()
                models.append(newTask)
                navigationController?.popViewController(animated: true)
                
            } catch {
                print("context save error")
            }
            
        } else {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppToDoList")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let doTheApp = result as! AppToDoList
                    if (doTheApp == selectedTask) {
                        doTheApp.name = taskName.text
                        doTheApp.category = segmentChange.numberOfSegments
                        //doTheApp.taskDescription = taskDescriptionToDo.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print("Fetch failed")
            }
        }
       
        
    }

    
}


//extension DateFormatter {
//    static let dayMonthYearTimeFormatter = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMMM YYYY, HH:mm"
//
//        return dateFormatter
//    }()
//}
