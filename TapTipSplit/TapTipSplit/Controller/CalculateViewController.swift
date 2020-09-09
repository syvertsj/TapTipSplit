//
//  CalculateViewController.swift
//  TapTipSplit
//
//  Created by James on 9/3/20.
//  Copyright © 2020 James Syvertsen. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var billDetailLabel: UILabel!
    
    var billAmount: Float = 0.0
    var splitNumber: Int = 1
    
    var billCalculator: BillCalculator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        billTextField.delegate = self
        
        billTextField.clearButtonMode = UITextField.ViewMode.always
        
        splitNumberLabel.text = String(splitNumber)
        tipPercentLabel.text = "\(Int(tipPercentSlider.value.rounded())) %"
        totalPerPersonLabel.text = "0.0"
        billDetailLabel.isHidden = true
    }
          
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        billTextField.resignFirstResponder()
    }
    
    @IBAction func splitStepperAction(_ sender: UIStepper) {
        
        splitNumber = Int(sender.value)
        splitNumberLabel.text = String(splitNumber)
        billTextField.resignFirstResponder()
    }
    
    @IBAction func calculateAction(_ sender: UIButton) {
        
        guard let billAmount = Float(billTextField.text!) else { return }
                
        let tipPercentage = tipPercentSlider.value.rounded()
        
        billCalculator = BillCalculator(bill: billAmount, tipPercent: tipPercentage, split: splitNumber)

        totalPerPersonLabel.text = billCalculator?.billCalculation().totalPerPerson
        billDetailLabel.text = billCalculator?.billCalculation().billDetailText()
        billDetailLabel.isHidden = false
    }
        
    @IBAction func sliderAction(_ sender: Any) {
        
        tipPercentLabel.text = "\(Int(tipPercentSlider.value.rounded())) %"
        billTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate methods

extension CalculateViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        totalPerPersonLabel.text = "0.0"
        billDetailLabel.isHidden = true
        return true
    }
}
