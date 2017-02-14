//
//  ViewController.swift
//  DatePicker
//
//  Created by Bondar Yaroslav on 14/02/2017.
//  Copyright © 2017 Bondar Yaroslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePickerTextField: DatePickerTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerTextField.didPickDate = didPickDate
//        datePickerTextField.dateStyle = .short
//        datePickerTextField.dateFormat = "yyyy/MM/dd -:- hh:mm a"
//        datePickerTextField.datePickerMode = .time
    }
    
    func didPickDate(date: Date) {
        print(date)
    }
}
