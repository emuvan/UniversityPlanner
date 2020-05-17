//
//  ReminderViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 20/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import Foundation
import UIKit

class ReminderViewController: UIViewController{
    
    @IBOutlet weak var firstDatepicker: UIDatePicker!
    @IBOutlet weak var secondDatepicker: UIDatePicker!
    @IBOutlet weak var LabelFirstDate: UILabel!
    @IBOutlet weak var LabelSecondDate: UILabel!
    @IBOutlet weak var LabelDaysUntil: UILabel!
    @IBOutlet weak var LabelWeeksAndDaysUntil: UILabel!
    var localeEng = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerSettingsBundle()
        updatelanguage()
        
        // Do any additional setup after loading the view, typically from a nib.
        //get the first label as a test
        let test = getLabel(key: "LabelFirstDate")
        print("Label is " + test)
        //update the labels
        updateDates()
    }
    
    @IBAction func valueChanged(_ sender: UIDatePicker) {
        updateDates()
    }
    
    @IBAction func valueChanged2(_ sender: Any) {
        updateDates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        
        if segue.identifier ==  "addCal" {
            //only one - pass the date
            let addEventView = segue.destination as! AddCalenderViewController
            addEventView.startDateForCal = self.firstDatepicker.date
            addEventView.endDateForCal = self.secondDatepicker.date
        }
                
    }
    
    
    
    
    
    
    
   override func awakeFromNib() {
          let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(ReminderViewController.appMovedToForeground), name:        UIApplication.willEnterForegroundNotification, object: nil)
          updatelanguage()
      }
    
    func updateDates(){
        
        
        //set up first and second date labels
        var date1:String = ""
        var date2:String = ""
        
        if self.localeEng {
            
            date1 = getLabel(key: "LabelFirstDate")
            date2 = getLabel(key: "LabelSecondDate")
        }
        else{
            date1 = getLabel(key: "LabelFirstDateFr")
            date2 = getLabel(key: "LabelSecondDateFr")
        }
        
        let dateFormatter = DateFormatter()
        if self.localeEng
        {
            dateFormatter.locale = Locale.current
            dateFormatter.locale = Locale(identifier: "en_GB")
        }
        else{
            dateFormatter.locale = Locale(identifier: "fr_FR")
        }
        
        //set to full date style
        dateFormatter.dateStyle = DateFormatter.Style.full
        var styledDate = dateFormatter.string(from: firstDatepicker.date)
        date1.append(" \(styledDate)")
        styledDate = dateFormatter.string(from: secondDatepicker.date)
        date2.append(" \(styledDate)")
        //set to labels
        LabelFirstDate.text = date1
        LabelSecondDate.text = date2
        
        //update the days between
        let days = daysBetween(date1: secondDatepicker.date, date2: firstDatepicker.date)
        var daysLabel:String = ""
        var daysWeeksLabel:String = ""
        
        //get the labels from the plist
        
        if self.localeEng
        {
            daysLabel = getLabel(key: "LabelDayUntil")
            daysWeeksLabel = getLabel(key: "LabelWeekAndDays")
            
        }
        else {
            
            daysLabel = getLabel(key: "LabelDayUntilFr")
            daysWeeksLabel = getLabel(key: "LabelWeekAndDaysFr")
        }
        
        daysLabel.append(" \(days) days") //ideally need jours for FR etc.
               //update the label
               LabelDaysUntil.text = daysLabel
               //update the weeks and days between
        
        daysWeeksLabel.append(" \(weekAndDaysBetween(date1: secondDatepicker.date, date2: firstDatepicker.date))")
        LabelWeeksAndDaysUntil.text = daysWeeksLabel
    
    }
    
    
    func daysBetween(date1:Date, date2:Date) ->Int{
        
        //seconds
        let sec = self.secondDatepicker.date.timeIntervalSince(self.firstDatepicker.date)
       
        //days
        let days = sec/(60*60*24)
        return Int(days)
        
    }
    
    func weekAndDaysBetween(date1:Date, date2:Date) -> String {
        let days = daysBetween(date1: secondDatepicker.date, date2: firstDatepicker.date)
        
        let remDays = days % 7
        let weeks = Int(days/7)
        let weeksDaysString = " \(weeks) weeks and \(remDays) days"
        return weeksDaysString
    }
    
   func getLabel(key:String)->String
   {
       var value:String = ""
       if let path = Bundle.main.path(forResource: "LabelStrings", ofType: "plist") {
           
           
           ////If your plist contain root as Dictionary
           if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
               
               value = (dict[key] as! String?)!
           }
       }
       return value
   }
    
    func updatelanguage(){
        //Get the defaults
        let defaults = UserDefaults.standard
        let useFrench = defaults.bool(forKey: "useFrench")
        if useFrench{
            self.localeEng = false
        }
        else{
            self.localeEng = true
        }
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    @objc func appMovedToForeground()
    {
            updatelanguage()
    }
    
    
    
    
}
