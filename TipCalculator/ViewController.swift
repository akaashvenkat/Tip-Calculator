//
//  ViewController.swift
//  TipCalculator
//
//  Created by Akaash Venkat on 7/15/20.
//  Copyright © 2020 Akaash Venkat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var base_value = 0.00
	var tip_percentage = 0.0
	var tip_value = 0.00
	var total_value = 0.00
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dollarSignLabel: UILabel!
	@IBOutlet weak var inputValue: UITextField!
	@IBOutlet weak var percentageSelector: UISegmentedControl!
	@IBOutlet weak var customPercentageValue: UITextField!
	@IBOutlet weak var percentageSignLabel: UILabel!
	@IBOutlet weak var tipValueLabel: UILabel!
	@IBOutlet weak var totalValueLabel: UILabel!
	
	@IBAction func acceptInputValue(_ sender: Any) {
		base_value = Double(inputValue.text!) ?? 0.00
		inputValue.text = String(format: "%.2f", base_value)
		updateValues()
	}
	
	@IBAction func selectPercentage(_ sender: Any) {
		let optionSelected = percentageSelector.titleForSegment(at: percentageSelector.selectedSegmentIndex)
		
		switch optionSelected {
			case "10%":
				tip_percentage = 10.0
				hideCustomPercentage(value: true)
			case "15%":
				tip_percentage = 15.0
				hideCustomPercentage(value: true)
			case "20%":
				tip_percentage = 20.0
				hideCustomPercentage(value: true)
			default:
				tip_percentage = 0.0
				customPercentageValue.placeholder = "0"
				customPercentageValue.text = ""
				hideCustomPercentage(value: false)
		}
		
		updateValues()
	}
	
	@IBAction func acceptCustomPercentage(_ sender: Any) {
		tip_percentage = Double(customPercentageValue.text!) ?? 0.0
		updateValues()
	}
	
	func hideCustomPercentage(value: Bool) {
		customPercentageValue.isHidden = value
		percentageSignLabel.isHidden = value
	}
	
	func updateValues() {
		tip_value = base_value * tip_percentage / 100
		total_value = tip_value + base_value
		
		tipValueLabel.text = "Tip: $" + String(format: "%.2f", tip_value)
		totalValueLabel.text = "Total: $" + String(format: "%.2f", total_value)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateColors()
		addDoneButtonOnKeyboards()
		
		tip_percentage = 10.0
		hideCustomPercentage(value: true)
	}
	
	func updateColors() {
		if #available(iOS 13.0, *) {
			if self.traitCollection.userInterfaceStyle == .dark {
				view.backgroundColor = UIColor.black
				titleLabel.textColor = UIColor.white
				dollarSignLabel.textColor = UIColor.white
				inputValue.textColor = UIColor.white
				customPercentageValue.textColor = UIColor.white
				percentageSignLabel.textColor = UIColor.white
				tipValueLabel.textColor = UIColor.red
				totalValueLabel.textColor = UIColor.systemGreen
			} else {
				view.backgroundColor = UIColor.white
				titleLabel.textColor = UIColor.black
				dollarSignLabel.textColor = UIColor.black
				inputValue.textColor = UIColor.black
				customPercentageValue.textColor = UIColor.black
				percentageSignLabel.textColor = UIColor.black
				tipValueLabel.textColor = UIColor.blue
				totalValueLabel.textColor = UIColor.systemGreen
			}
		}
	}
	
	func addDoneButtonOnKeyboards() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputValue.inputAccessoryView = doneToolbar
		customPercentageValue.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        inputValue.resignFirstResponder()
		customPercentageValue.resignFirstResponder()
    }
}

