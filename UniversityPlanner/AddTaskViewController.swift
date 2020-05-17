//
//  AddTaskViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 23/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    @IBOutlet weak var labelModulesname: UILabel!
    @IBOutlet weak var textTaskname: UITextField!
    
    @IBOutlet weak var textNotes: UITextField!
    var modules:Modules?
    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelModulesname.text = self.modules?.name
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTask(_ sender: Any) {
        let task = Task(context: context)
        task.modules = modules?.name
        task.title = textTaskname.text
        task.notes = textNotes.text
        modules?.addToNames(task)
        (UIApplication.shared.delegate as!
            AppDelegate).saveContext()  
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
