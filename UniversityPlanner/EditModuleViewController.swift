//
//  EditModuleViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 23/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData

class EditModuleViewController: UIViewController {
    @IBOutlet weak var textModuleName: UITextField!
    @IBOutlet weak var textModuleCode: UITextField!
    var currentModules:Modules?
    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textModuleName.text = currentModules?.name
        textModuleCode.text = currentModules?.codes
    }
    
    
    @IBAction func updateModules(_ sender: Any) {
        currentModules?.name = textModuleName.text
        currentModules?.codes = textModuleCode?.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
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
