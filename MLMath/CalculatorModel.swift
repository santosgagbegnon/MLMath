//
//  CalculatorModel.swift
//  MLMath
//
//  Created by Santos on 2018-09-15.
//  Copyright © 2018 Santos. All rights reserved.
//

import Foundation
class CalculatorModel {
    private var expression = Stack<String>()
    private static var WOLFRAM_API_KEY = "6RG66G-W2VP4RJY83"
    public func addToExpression(newAddittion : String){
        expression.push(item: newAddittion)
    }
    public func undoAdditionToExpression() {
        _ = expression.pop()
    }
    public func getExpression() -> String {
        var stringExpression = ""
        var poppedFirstItem = true
        let reverseStack = expression.getStackInReverse()
    
        while (!reverseStack.isEmpty()){
            let poppedValue = reverseStack.pop()!
            if (!(poppedFirstItem && poppedValue == "0")) { //Ensures 0 is not appended to the first part of the expression eg. 0100
                stringExpression += String(poppedValue)
            }
            poppedFirstItem = false
        }
        if (stringExpression == "") {stringExpression = "0"}
        return stringExpression
    }
    public func calculateExpression(closure : @escaping (String?) -> Void ) {
        var currentExpression = getExpression()
        expression = Stack<String>()
        let rerservedCharacters = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]").inverted)
        currentExpression = currentExpression.addingPercentEncoding(withAllowedCharacters: rerservedCharacters) ?? currentExpression
        let baseURL = "http://api.wolframalpha.com/v2/query?output=JSON&format=plaintext,minput&input="+currentExpression+"&includepodid=Limit&includepodid=Result&includepodid=Root&includepodid=Solution&includepodid=Solutions&"+"appid="+CalculatorModel.WOLFRAM_API_KEY
        print(baseURL)
        let requestURL = URL(string: baseURL)!
        var x = URLRequest(url: requestURL)
        x.httpMethod = "GET"
        URLSession.shared.dataTask(with: x) { (data, response, error) in
            print("api call")
            if error != nil {
                print("Error occurred when using wolframpha: " + error!.localizedDescription)
            }
            let httpURLResponse = response as? HTTPURLResponse
            let statusCode = httpURLResponse?.statusCode ?? 0
            if (statusCode == 200){ //Everything worked
                do{
                    guard let data = data else {return}
                    let wolframAlphaJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    if let pods = wolframAlphaJSON?["queryresult"]?["pods"] as? [[String:Any]] {
                        if let subpods = pods[0]["subpods"] as? [[String:Any]] {
                            let plainText = subpods[0]["plaintext"] as? String
                            if (plainText != nil && plainText?.contains("?") == false) {
                                closure(plainText)
                            }else{
                                let minput = subpods[0]["minput"] as? String
                                closure(minput)
                            }
                        }
                        else {
                            closure(nil)
                        }
                    }
                    else{
                        closure(nil)
                    }
                }
                catch let JSONError{
                    
                    print(JSONError.localizedDescription)
                }
        }
            else {
                print("Error status code not 200, instead it's " + String(statusCode) )
            }
        }.resume()
    }
    
}
