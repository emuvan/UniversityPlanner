//
//  DetailViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 20/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData
import Charts

class DetailViewController: UIViewController,
UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var PieChartView2: PieChartView!
    override func viewDidLoad() {
           super.viewDidLoad()
        
        
           // Do any additional setup after loading the view.
        configureView()
     //   tableView.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupPieChart()
        setupPieChart2()
       }
    
    
    func setupPieChart(){
          pieView.chartDescription?.enabled = false
          pieView.drawHoleEnabled = false
          pieView.rotationAngle = 0
          pieView.rotationEnabled = true
         // pieView.isUserInteractionEnabled = false
          
          pieView.legend.enabled = false
      
          var entries: [PieChartDataEntry] = Array()
          entries.append(PieChartDataEntry(value: 25.0, label: "CW"))
          entries.append(PieChartDataEntry(value: 25.0, label: "Viva"))
          entries.append(PieChartDataEntry(value: 25.0, label: "assessement"))
          
          let dataSet = PieChartDataSet(entries: entries, label: "")
          
          let c1 = NSUIColor(hex: 0xe1d6f7)
          let c2 = NSUIColor(hex: 0xE0E482)
          let c3 = NSUIColor(hex: 0xfe857e)
    
          
          dataSet.colors = [c1, c2, c3]
          dataSet.drawValuesEnabled = false
          
          pieView.data = PieChartData(dataSet: dataSet)
          
      }
    
    func setupPieChart2(){
          PieChartView2.chartDescription?.enabled = false
          PieChartView2.drawHoleEnabled = false
          PieChartView2.rotationAngle = 0
          PieChartView2.rotationEnabled = true
         // PieChartView2.isUserInteractionEnabled = false
          
          PieChartView2.legend.enabled = false
      
          var entries: [PieChartDataEntry] = Array()
          entries.append(PieChartDataEntry(value: 25.0, label: "CW"))
          entries.append(PieChartDataEntry(value: 25.0, label: "Viva"))
          entries.append(PieChartDataEntry(value: 25.0, label: "assessement"))
          
          let dataSet = PieChartDataSet(entries: entries, label: "")
          
          let c1 = NSUIColor(hex: 0xe1d6f7)
          let c2 = NSUIColor(hex: 0xE0E482)
          let c3 = NSUIColor(hex: 0xfe857e)
    
          
          dataSet.colors = [c1, c2, c3]
          dataSet.drawValuesEnabled = false
          
          PieChartView2.data = PieChartData(dataSet: dataSet)
          
      }
    
    
    
    let managedObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    let cellColour:UIColor = UIColor(red:1.0 , green: 0.0, blue: 0.0, alpha: 0.1)
    let cellSelColour:UIColor = UIColor(red:1.0, green: 0.0, blue: 0.0, alpha: 0.2)
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        self.configureCell(cell,indexPath: indexPath)
        let backgroundView = UIView()
        backgroundView.backgroundColor = cellSelColour
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    // configure the cell here
    
    func configureCell(_ cell: UITableViewCell, indexPath: IndexPath)
    
    {
        let title = self.fetchedResultsController.fetchedObjects?[indexPath.row].title
        cell.textLabel?.text = title
        cell.backgroundColor = cellColour
        if let noteText = self.fetchedResultsController.fetchedObjects?[indexPath.row].notes
        {
            cell.detailTextLabel?.text = noteText
        }
        else
        {
            cell.detailTextLabel?.text = ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = modules {
            if let label = detailDescriptionLabel {
                label.text = detail.name
            }
        }
    }
    
   
    
    var modules: Modules? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<Task>?
        = nil
    
    var fetchedResultsController: NSFetchedResultsController<Task> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let currentModules = self.modules
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        // Set the batch size to a suitable number.
        
        fetchRequest.fetchBatchSize = 20
        
        if(self.modules != nil)
        {
            let predicate = NSPredicate(format: "modulesTask = %@", currentModules!)
            fetchRequest.predicate = predicate
            
        }
        else
        {
            let predicate = NSPredicate(format: "modules = %@","Mobile")
            fetchRequest.predicate = predicate
            
        }
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController<Task>(fetchRequest: fetchRequest,
        managedObjectContext: self.managedObjectContext,
        sectionNameKeyPath: #keyPath(Task.modules),
        cacheName: nil)
        
        
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if let identifier = segue.identifier{
            switch identifier
            {
            case "modulesDetails":
                let destVC = segue.destination as! ModulesDetailViewController
                if let name = self.modules?.name
                {
                    destVC.modulesName = name
                }
                else
                {
                    destVC.modulesName = "Modules"
                }
                if let codes = self.modules?.codes
                {
                    destVC.textCodes = codes
                }
            default:
                break
            }
        }
        if segue.identifier == "addTask"
        {
            let object = self.modules
            let controller = segue.destination as! AddTaskViewController
            controller.modules = object
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex
        sectionIndex: Int, for type: NSFetchedResultsChangeType) {
           switch type {
               case .insert:
                   tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
               case .delete:
                   tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
               default:
                   return
           }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, indexPath: newIndexPath!)
            case .move:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, indexPath: newIndexPath!)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
                return
        }
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

