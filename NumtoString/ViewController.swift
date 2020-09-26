//
//  ViewController.swift
//  NumtoString
//
//  Created by imran shaik on 25/09/20.
//  Copyright © 2020 imran shaik. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    var one = ["", "one ", "two ", "three ", "four ", "five ", "six ", "seven ", "eight ", "nine ", "ten ", "eleven ", "twelve ", "thirteen ", "fourteen ", "fifteen ", "sixteen ", "seventeen ", "eighteen ", "nineteen "]
    var ten = ["", "", "twenty ", "thirty ", "forty ", "fifty ", "sixty ", "seventy ", "eighty ", "ninety "]

    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var outputLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        numToWords(1, "zero")
//        convertToWords(0)
//        main()
    }
    func numToWords(_ n: Int, _ s: String) -> String {
        var str = "" as? String
        // if n is more than 19, divide it
        if n > 19 {
            str! += ten[n / 10] + one[n % 10]
        } else {
            str! += one[n]
        }
        // if n is non-zero
        if n != 0 {
            str! += s
        }
        return str!
    }
    func convertToWords(_ n: Int) -> String {
        var out = String()
        if String(n/10000000).count > 2 {
            let numb = n/10000000
            out += bigNumbers(numb) + "crore "
        }else{
//            out += numToWords(n / 100000000, "million ")
            out += numToWords(n / 10000000, "crore ")
        }
        out += numToWords((n / 100000) % 100, "lakh ")
        out += numToWords((n / 1000) % 100, "thousand ")
        out += numToWords((n / 100) % 10, "hundred ")
        if n > 100 && n % 100 != 0 {
            out += "and "
        }
        out += numToWords(n % 100, "")
        return out
    }
    func bigNumbers(_ n:Int) -> String {
        var out = String()
        out += numToWords(n / 100000000, "million ")
        out += numToWords(n / 10000000, "crore ")
        out += numToWords((n / 100000) % 100, "lakh ")
        out += numToWords((n / 1000) % 100, "thousand ")
        out += numToWords((n / 100) % 10, "hundred ")
        if n > 100 && n % 100 != 0 {
            out += "and "
        }
        out += numToWords(n % 100, "")
        return out
    }
    func main() -> Int {
        // long handles upto 9 digit no
        // change to unsigned long long int to
        // handle more digit number
//        inputTF.text =
        let n = Int(inputTF.text!)
//        let n1 = 970430058
//        let n2 = 000
        // convert given number in words
        outputLbl.text = convertToWords(n ?? 0)
        print(convertToWords(n ?? 0))
//        print(convertToWords(n1))
//        print(convertToWords(n2))
        return 0
    }
    @IBAction func onEnterBtnTap(_ sender: Any) {
        if (inputTF.text?.isEmpty)! || (inputTF.text?.count)! > 16{
        self.basicAlert(title: "Error", message: "Enter max 16 digits.The value should not exceed 16 digits.")
        }else{
        numToWords(0, "")
        convertToWords(0)
        main()
        }
    }
    
    @IBAction func onTapgestureTap(_ sender: Any) {
        self.inputTF.resignFirstResponder()
    }
    func basicAlert(title: String, message : String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alertController, animated: true, completion: nil)
}
}
