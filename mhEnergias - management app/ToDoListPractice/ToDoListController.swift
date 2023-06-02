///
//  ToDoListController.swift
//  toDoApp
//
//  Created by MultiLab PRT on 12/05/2023.
//

import UIKit
import Firebase
import CoreData


class ToDoListController: UITableViewController {

    var toDos : [ToDoCD] = []
    var receivedName = ""

    @IBOutlet weak var result: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let atIndex = receivedName.firstIndex(of: "@") {
            let username = String(receivedName.prefix(upTo: atIndex))
            result.text = "Welcome, \(username)!"
        } else {
            // Handle the case when "@" is not found in the email
            result.text = "Welcome!"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return toDos.count
    }
    
//    func createToDos() -> [ToDo] {
//        let swift = ToDo()
//        swift.name = "Learn Swift"
//        swift.important = true
//
//        let dog = ToDo()
//        dog.name = "Walk the dog"
//
//        return [swift, dog]
//    }

    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                    toDos = coreDataToDos
                    tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]

        if let name = toDo.name {
            if toDo.important {
                cell.textLabel?.text = "! " + name
            }
            else {
                cell.textLabel?.text = toDo.name
            }
        }
        
        
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
    }


}
