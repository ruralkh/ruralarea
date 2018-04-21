//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Ron Rith on 3/25/18.
//  Copyright © 2018 Ron Rith. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var coreDataCRUDtableView: UITableView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeople()
        coreDataCRUDtableView.dataSource = self
        coreDataCRUDtableView.delegate = self
    }

    @IBAction func onPlusTapped(_ sender: Any) {
        let alert = UIAlertController(title: "add person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "input person name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "input person age"
            textField.keyboardType = .numberPad
        }
        
        let alertAction = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields?.first?.text! ?? ""
            let age = alert.textFields?.last?.text!
            print("Name: \(name)")
            print("Age: \(age!)")
            // -- use object from model
            let person = Person(context: PersistenceService.context)
            person.name = name
            person.age = Int16(age!)!
            PersistenceService.saveContext()
            self.people.append(person)
            print("P Name: \(person.name!)")
            print("P Age: \(person.age)")
            self.coreDataCRUDtableView.reloadData()
        }
       
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    func getPeople(){
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let person = try PersistenceService.context.fetch(fetchRequest)
            self.people = person
            self.coreDataCRUDtableView.reloadData()
        }catch{}
    }
}
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Name: \(people[indexPath.row].name!) Age: \(people[indexPath.row].age)"
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        getPeople()
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let person = self.people[indexPath.row]
        
        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, index) in
            let alertDelete = UIAlertController(title: "Do you want delete?", message: nil, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "delete", style: .default) { (_) in
                self.coreDataCRUDtableView.beginUpdates()
                self.people.remove(at: indexPath.row)
                self.coreDataCRUDtableView.deleteRows(at: [indexPath],with: .fade)
                self.coreDataCRUDtableView.endUpdates()
            }
            
            alertDelete.addAction(alertAction)
            self.present(alertDelete, animated: true, completion: nil)
            self.coreDataCRUDtableView.reloadData()
        }
        let edit = UITableViewRowAction(style: .destructive, title: "edit") { (action, index) in
            let alertEdit = UIAlertController(title: "Do you want edit?", message: nil, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "edit", style: .default, handler: { (_) in
               
                print("Person Edit Name: \(person.name!)")
                print("Person Edit Age: \(person.age)")
            
                self.performSegue(withIdentifier: "showEdit", sender: person)
            })
            alertEdit.addAction(alertAction)
            self.present(alertEdit, animated: true, completion: nil)
            self.performSegue(withIdentifier: "showEdit", sender: person)
        }
        edit.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        return [delete,edit]
    }
    
}

