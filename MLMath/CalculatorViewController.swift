//
//  ViewController.swift
//  MLMath
//
//  Created by Santos on 2018-08-10.
//  Copyright © 2018 Santos. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var calculationView: UIView!
    private var calculatorModel = CalculatorModel()
    private var stringExpression = ""
    private var firstPress = true
    
    @IBAction func onCalculationViewSwippedRight(_ sender: UISwipeGestureRecognizer) {
         _ = calculatorModel.undoAdditionToExpression()
        calculationLabel.text = calculatorModel.getExpression()
    }
    //            let randomNum = Int(arc4random_uniform(10))
    @IBAction func onCanvasViewDoubleTap(_ sender: UITapGestureRecognizer) {
        let randomNum = Int(arc4random_uniform(10))
        calculatorModel.addToExpression(newAddittion: String(randomNum))
        calculationLabel.text = calculatorModel.getExpression()

    }
    
    @IBAction func onEqualButtonPressed(_ sender: UIButton) {
        calculatorModel.calculateExpression { (answer) in
            DispatchQueue.main.async {
                if (answer != nil){
                    self.calculationLabel.text = answer
                }
                else{
                    self.calculationLabel.text = "Error"
                }
            }
        }
    }
    @IBAction func onMathSymbolButtonPressed(_ sender: UIButton) {

        calculatorModel.addToExpression(newAddittion: sender.titleLabel!.text!)
        calculationLabel.text = calculatorModel.getExpression()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calculationView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

