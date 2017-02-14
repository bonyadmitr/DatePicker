//
//  DatePickerTextField.swift
//  DatePicker
//
//  Created by Bondar Yaroslav on 14/02/2017.
//  Copyright © 2017 Bondar Yaroslav. All rights reserved.
//

import UIKit

class DatePickerTextField: UITextField {
    
    fileprivate let dateFormator = DateFormatter()
    fileprivate let datePicker = UIDatePicker()
    
    var didPickDate: (_ date: Date)->Void = {_ in }
    
    var date: Date? {
        didSet { updateText() }
    }
    
    var dateStyle: DateFormatter.Style {
        get {
            return dateFormator.dateStyle
        }
        set {
            dateFormator.dateStyle = newValue
            updateText()
        }
    }
    @IBInspectable var dateFormat: String {
        get {
            return dateFormator.dateFormat
        }
        set {
            dateFormator.dateFormat = newValue
            updateText()
        }
    }
    
    var datePickerMode: UIDatePickerMode {
        get {
            return datePicker.datePickerMode
        }
        set {
            datePicker.datePickerMode = newValue
        }
    }
    
    
    private func updateText() {
        guard let date = date else {
            text = ""
            return
        }
        text = dateFormator.string(from: date)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        inputView = datePicker
        delegate = self
        dateFormator.dateStyle = .full
        datePicker.addTarget(self, action: #selector(didPickDate(sender:)), for: .valueChanged)
    }
    
    @objc private func didPickDate(sender: Any?) {
        date = datePicker.date
        updateText()
        didPickDate(datePicker.date)
    }
}

extension DatePickerTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if date == nil {
            date = datePicker.date
        }
    }
}
