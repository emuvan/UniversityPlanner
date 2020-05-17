//
//  BarchartViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 26/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import Foundation
import Charts
import UIKit

class BarchartViewController: UIViewController{
    
    @IBOutlet weak var BarChartView: BarChartView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        var work: [String]!
        work = ["BIG-DATA","DESIGN","CONCURRENCY","DATA-MINING","PROJECT","ENTERPRISE"]
        let percent = [80.0, 50.0, 60.0, 40.0, 40.0, 20.0]
                
        setChart(dataPoints: work, values: percent)
    }
    func setChart(dataPoints: [String], values: [Double]) {
        BarChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
                
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: values[i], y: values[i])
            dataEntries.append(dataEntry)
        }
                
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "percent")
        let chartData = BarChartData(dataSet: chartDataSet)
        BarChartView.data = chartData
        BarChartView.xAxis.labelPosition = .bottom
        BarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)


        let ll = ChartLimitLine(limit: 50.0, label: "Target")
        BarChartView.rightAxis.addLimitLine(ll)
            
    }
    
    
}
