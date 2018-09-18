//
//  ViewController.swift
//  MLMath
//
//  Created by Santos on 2018-08-10.
//  Copyright © 2018 Santos. All rights reserved.
//

import UIKit
import Vision

class CalculatorViewController: UIViewController {
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var calculationView: UIView!
    @IBOutlet weak var handWrittenCanvasView: CanvasView!
    private var visionRequests = [VNRequest]()
    private var calculatorModel = CalculatorModel()
    private var isShowingCalculation = false //boolean to track whether or not calcView is displaying a calculated answer
    private var shouldGetOperator = false //boolean to track whether or not determineHandWrittenDigit should push operator to stack
    private var lastOperator = "" //The latest operator pressed by the user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVision()
        calculationView.backgroundColor = UIColor.clear
    }
    
    func setUpVision(){
        guard let visionModel = try? VNCoreMLModel(for: mnistCNN().model) else{fatalError("Couldn't load MNIST model.")}
        let classificationRequest = VNCoreMLRequest(model: visionModel) { (request, error) in
            if(error != nil){
                print("Error with classification request:", error ?? "failed to describe erorr")
            }
            guard let observations = request.results else {print("No observations!");return}
            let classifications = observations
                .compactMap({$0 as? VNClassificationObservation})
                .filter({$0.confidence > 0.8})
                .map({$0.identifier})
            DispatchQueue.main.async {
               
                if let handWrittenNum = classifications.first {
                    if (self.isShowingCalculation){
                        self.isShowingCalculation = false
                        self.calculatorModel.clearExpression()
                    }
                    self.calculatorModel.addToExpression(newAddittion: handWrittenNum)
                    if let results = self.calculatorModel.calculateExpression() {
                        self.calculationLabel.text = results
                        self.isShowingCalculation = true
                    }
                    else{
                        self.calculationLabel.text = handWrittenNum
                        self.isShowingCalculation = false
                    }
                }
                else{
                    if (self.shouldGetOperator){
                        self.calculatorModel.addToExpression(newAddittion: self.lastOperator)
                    }
                }
                self.handWrittenCanvasView.eraseCanvas()
            }
        }
        self.visionRequests = [classificationRequest]
    }
    
    func determineHandWrittenDigit() {
        let snapshot = UIImage(view: handWrittenCanvasView)
        let resizedImage = scaleImage(image: snapshot, toSize: CGSize(width: 28, height: 28))
        let imageRequestHandler = VNImageRequestHandler(cgImage: resizedImage.cgImage!, options: [:])
        do {
            try imageRequestHandler.perform(self.visionRequests)
        }
        catch{
            print(error)
        }
    }
    func scaleImage(image: UIImage, toSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }


    @IBAction func onCalculationViewSwippedRight(_ sender: UISwipeGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.ended && !isShowingCalculation){
            _ = calculatorModel.undoAdditionToExpression()
            calculationLabel.text = calculatorModel.getExpression()
        }
    }
    
    @IBAction func onEqualButtonPressed(_ sender: UIButton) {
        shouldGetOperator = false
        determineHandWrittenDigit()
    }
    @IBAction func onMathSymbolButtonPressed(_ sender: UIButton) {
        if (isShowingCalculation){
            isShowingCalculation = false
        }
        lastOperator = sender.titleLabel!.text!
        shouldGetOperator = true
        determineHandWrittenDigit()

       
    }
    @IBAction func onClearButtonPressed(_ sender: UIButton) {
        calculatorModel.clearExpression()
        handWrittenCanvasView.eraseCanvas()
        calculationLabel.text = "0"
    }
    
}

