//
//  ViewController.swift
//  NanoChallenge1Project
//
//  Created by Laurentius Richard Reynaldo on 03/03/20.
//  Copyright © 2020 Laurentius Richard Reynaldo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{
    
    var selectedCategory = "Sport"
    var counter = -1
    var achievement = 0
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var ButtonGo: UIButton!
    @IBOutlet weak var category: UIPickerView!
    var categoryData : [String] = [String]()
    
    @IBOutlet weak var textfieldChallenge: UITextField!
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var labelChallenge: UILabel!
    @IBOutlet weak var labelCounter: UILabel!
    @IBOutlet weak var labelAchievement: UILabel!
    //array for the randomed challenge
    var challengeFun = ["Take a cold bath","Greet a random person on the street","Meditate for 5 minute","Sing a song","Text the 1st person after you scroll in your contact"]
    
    var challenge2 = ["Ice bucket challenge","Mannequin challenge","Impression challenge","Chubby bunny challenge","Try not to laugh challenge"]
    
    var challengeSport = ["Push up challenge","Bent knee push up","Front Plank","Squat jump","Side plank","Sit up","Run for 5 minute"]
    
    var challengeDrunk = ["Play king's game","2 truth 1 false","Never have i ever","Most likely","True or false story","Would you rather"]
    
    
    //alert for the empty challenge add button
    func showAlertTf() {
        let alert = UIAlertController(title: "Message", message: "Input your challenge.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertSave() {
        let alert = UIAlertController(title: "Message", message: "YOU LOST TO THE TOP ACHIEVEMENT!! TRY AGAIN TOMORROW", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ButtonGo.layer.cornerRadius = 60
        buttonDone.layer.cornerRadius=20
        addButton.layer.cornerRadius = 20
        
        self.category.delegate = self
        self.category.dataSource = self
        self.textfieldChallenge.delegate = self as? UITextFieldDelegate
        categoryData = ["Sport","Fun","2 or more people","Drunk"]
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -120 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func doneForTheDay(_ sender: Any) {
        if achievement < counter {
            achievement = counter
            labelAchievement.text = String(achievement)
        }else
        {
            showAlertSave()
        }
        counter = 0
        labelCounter.text = String(counter)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoryData[row]
        switch selectedCategory {
        case "Sport":
            image1.image = #imageLiteral(resourceName: "barbell")
        case "Fun":
            image1.image = #imageLiteral(resourceName: "confetti")
        case "2 or more people":
            image1.image = #imageLiteral(resourceName: "dance")
        case "Drunk":
            image1.image = #imageLiteral(resourceName: "cheers")
        default:
            labelChallenge.text = ""
        }
       
    }
    
    @IBAction func AddChallenge(_ sender: Any) {
        if textfieldChallenge.text!.isEmpty{
            showAlertTf()
        }else
        {
            switch selectedCategory {
            case "Sport":
                challengeSport.append(textfieldChallenge.text!)
            case "Fun":
                challengeFun.append(textfieldChallenge.text!)
            case "2 or more people":
                challenge2.append(textfieldChallenge.text!)
            case "Drunk":
                challengeDrunk.append(textfieldChallenge.text!)
            default:
                labelChallenge.text = ""
            }
        }
        textfieldChallenge.text = ""
    }
    
    @IBAction func randChallenge(_ sender: Any) {
        switch selectedCategory {
        case "Sport":
            let number = Int.random(in: 0 ... challengeSport.count-1)
            labelChallenge.text = challengeSport[number]
        case "Fun":
            let number = Int.random(in: 0 ... challengeFun.count-1)
            labelChallenge.text = challengeFun[number]
        case "2 or more people":
            let number = Int.random(in: 0 ... challenge2.count-1)
            labelChallenge.text = challenge2[number]
        case "Drunk":
           
            let number = Int.random(in: 0 ... challengeDrunk.count-1)
            labelChallenge.text = challengeDrunk[number]
        default:
            labelChallenge.text = ""
        }
        counter += 1
        labelCounter.text = "\(counter)"
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        let attributedString = NSAttributedString(string: categoryData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex:0xBD3028)])
        return attributedString
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}


