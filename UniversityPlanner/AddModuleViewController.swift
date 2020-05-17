//
//  AddModuleViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 20/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit


class AddModuleViewController: UIViewController {
        
    @IBOutlet weak var textModuleName: UITextField!
    @IBOutlet weak var textModuleCode: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //do any additional setup after loading the view
    }
    
    @IBAction func saveModule(_ sender: UIButton) {
        let newModule = Modules(context: context)
        if self.textModuleName.text != ""
        {
            newModule.name = self.textModuleName.text
            newModule.codes = self.textModuleCode.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        else{
            let alert = UIAlertController(title: "Missing modules name", message:"Please enter the modules name",preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(OkAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

