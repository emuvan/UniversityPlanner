//
//  ModulesDetailViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 23/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit
import Charts

class ModulesDetailViewController: UIViewController {
    @IBOutlet weak var mabelModules: UILabel!
    @IBOutlet weak var textViewModulesCodes: UITextView!
    var textCodes = ""
    var modulesName = ""
    var modules: Modules?
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var pieView2: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mabelModules.text = modulesName
        textViewModulesCodes.text = textCodes
        setupPieChart()
        setupPieChart2()
        // Do any additional setup after loading the view.
    }
    
      func setupPieChart(){
       pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
        pieView.rotationEnabled = true
       // pieView.isUserInteractionEnabled = false
        
        pieView.legend.enabled = false
    
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: 25.0, label: "BIS"))
        entries.append(PieChartDataEntry(value: 25.0, label: "Games"))
        entries.append(PieChartDataEntry(value: 25.0, label: "Software"))
        entries.append(PieChartDataEntry(value: 25.0, label: "Multimedia"))
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        let c1 = NSUIColor(hex: 0xe1d6f7)
        let c2 = NSUIColor(hex: 0xE0E482)
        let c3 = NSUIColor(hex: 0xfe857e)
        let c4 = NSUIColor(hex: 0x8B8682)
  
        
        dataSet.colors = [c1, c2, c3, c4]
        dataSet.drawValuesEnabled = false
        
        pieView.data = PieChartData(dataSet: dataSet)
        
    }
    
    func setupPieChart2(){
          pieView2.chartDescription?.enabled = false
          pieView2.drawHoleEnabled = false
          pieView2.rotationAngle = 0
          pieView2.rotationEnabled = true
         // pieView2.isUserInteractionEnabled = false
          
          pieView2.legend.enabled = false
      
          var entries: [PieChartDataEntry] = Array()
          entries.append(PieChartDataEntry(value: 20.0, label: "big data"))
          entries.append(PieChartDataEntry(value: 20.0, label: "mobile"))
          entries.append(PieChartDataEntry(value: 20.0, label: "Software"))
          entries.append(PieChartDataEntry(value: 20.0, label: "enterprise"))
          entries.append(PieChartDataEntry(value: 20.0, label: "concurrency"))
          entries.append(PieChartDataEntry(value: 20.0, label: "data mining"))
          entries.append(PieChartDataEntry(value: 60.0, label: "project"))

        
          
          let dataSet2 = PieChartDataSet(entries: entries, label: "")
          
          let c1_2 = NSUIColor(hex: 0x181718)
          let c2_2 = NSUIColor(hex: 0xee367a)
          let c3_2 = NSUIColor(hex: 0x9ACD32)
          let c4_2 = NSUIColor(hex: 0xE066FF)
          let c5_2 = NSUIColor(hex: 0x0E3EE1)
          let c6_2 = NSUIColor(hex: 0x8B8682)
          let c7_2 = NSUIColor(hex: 0xfe857e)

          
          dataSet2.colors = [c1_2, c2_2, c3_2, c4_2, c5_2, c6_2, c7_2]
          dataSet2.drawValuesEnabled = false
          
          pieView2.data = PieChartData(dataSet: dataSet2)
          
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
