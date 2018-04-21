//
//  AddUpdatePersonUIViewController.swift
//  CoreDataCRUD
//
//  Created by Ron Rith on 3/25/18.
//  Copyright © 2018 Ron Rith. All rights reserved.
//

import UIKit
import CoreData

class AddUpdatePersonUIViewController: UIViewController {
    @IBOutlet var personNameTextField: UITextField!
    @IBOutlet var personAgeTextField: UITextField!
    
    var people = [Person]()
    var peopleHolder: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("personHolder: \(peopleHolder)")
        if(peopleHolder != nil){
            personNameTextField.text = peopleHolder?.name
            personAgeTextField.text = String(describing: peopleHolder?.age)
        }
    }
    @IBAction func savePerson(_ sender: Any) {
        // save
        if(personNameTextField.text != nil && personAgeTextField.text != nil){
            let personName = personNameTextField.text!
            let personAge = Int16(personAgeTextField.text!)
            
            let person = Person(context: PersistenceService.context)
            person.name = personName
            person.age = personAge!
            PersistenceService.saveContext()
            self.people.append(person)
            print(#function)
            
            navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func resetPerson(_ sender: Any) {
        personNameTextField.text = ""
        personAgeTextField.text = ""
    }
    
}
