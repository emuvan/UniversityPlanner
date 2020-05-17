//
//  AddCalenderViewController.swift
//  UniversityPlanner
//
//  Created by Van Quang Nguyen on 20/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import EventKitUI

class AddCalenderViewController: UIViewController {
    
    var startDateForCal:Date?
    var endDateForCal:Date?
    
    override func viewDidLoad() {
           super.viewDidLoad()
           self.title = "Add the reminder to Calendar"
        
       let eventStore : EKEventStore = EKEventStore()
              
       
              //this is how you set up access for the reminders - extra task
              eventStore.requestAccess(to: EKEntityType.reminder, completion:
                  {(granted, error) in
                      if !granted {
                          print("Access to store not granted")
                      }
              })
        //this is how you set up access for the calendar
               eventStore.requestAccess(to: .event) { (granted, error) in
                
                if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(error)")
                    
                let event:EKEvent = EKEvent(eventStore: eventStore)
                    
                 event.title = "the Coursework deadline check the university planner app"
                 event.startDate = self.startDateForCal!
                 event.endDate = self.endDateForCal!
                 event.notes = "This coursework is for the following modules in the university planner"
                //create an alarm (alert on the calendar event)
                let alarm:EKAlarm = EKAlarm()
                    alarm.relativeOffset = 60 * -60 //1 hour before in seconds
                    //add the alarm
                    event.addAlarm(alarm)
                    event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                    let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    self.present(alert, animated: true, completion: nil)
                }
                print("Saved Event")
                    let alert = UIAlertController(title: "Saved", message:"Event has been saved to your Calendar",preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    
                    print("failed to save event with error : \(String(describing: error)) or access not granted")
                }
        }
    }
                   
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}
