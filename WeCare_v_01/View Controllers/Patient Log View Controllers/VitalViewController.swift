//
//  VitalViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-15.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class VitalViewController: UIViewController {
    
    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var bloodPressureLabel: UILabel!
    @IBOutlet weak var bloodPressureText: UITextField!
    
    
    @IBOutlet weak var pulseLabel: UILabel!
    @IBOutlet weak var pulseText: UITextField!
    
    @IBOutlet weak var rrLabel: UILabel!
    @IBOutlet weak var rrText: UITextField!
    
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempText: UITextField!
    
    
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var sugarText: UITextField!
    
    @IBOutlet weak var o2Label: UILabel!
    @IBOutlet weak var o2Text: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet var swipe_back: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        Utilities.styleTextField(bloodPressureText)
        Utilities.styleTextField(pulseText)
        Utilities.styleTextField(rrText)
        Utilities.styleTextField(tempText)
        Utilities.styleTextField(sugarText)
        Utilities.styleTextField(o2Text)
        Utilities.styleFilledButton(submitButton)
        errorLabel.alpha = 0
        // navigation bar set up
        navbar.barTintColor = UIColor.white
    }
    
    @IBAction func backTapped(_ sender: Any) {
        transitionToList()
    }
    
    //submit button
    
    @IBAction func submitTapped(_ sender: Any) {
        
        // Clean up the text fields:
        let blood_pressure = bloodPressureText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pulse = pulseText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let rr = rrText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let temp = tempText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let sugar = sugarText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let O2 = o2Text.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // get patient UID
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("Nurses").document(uid).collection("Current Patient").document("Patient Info").getDocument { (snapshot, error) in
            guard let patient_uid = snapshot?.get("uid") else { return }
            // submit data
            db.collection("Patients").document("\(patient_uid)").collection("Vitals").addDocument(data: ["blood pressure": blood_pressure, "pulse": pulse, "R.R": rr, "temperature": temp, "sugar": sugar, "O2 Stat": O2, "Time": NSDate()])
            self.errorLabel.alpha = 1
            self.errorLabel.text = "Sucessfully Submitted!"
            self.errorLabel.textColor = UIColor.init(red: 0.12, green: 0.66, blue: 0.62, alpha: 1)
            /*
            errorLabel.alpha = 1
            errorLabel.text = "Error in submitting info, contact your supervisor"
            errorLabel.textColor = UIColor.red
            */
        }
        print("successfully submitted data")
        
        // clear the text fields
        bloodPressureText.text = ""
        pulseText.text = ""
        rrText.text = ""
        tempText.text = ""
        sugarText.text = ""
        o2Text.text = ""
    }
    
    // transition functions
    
    func transitionToList() {
        let listViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.listviewcontroller) as? list_ViewController
        view.window?.rootViewController = listViewController
        view.window?.makeKeyAndVisible()
    }
    
    // swipe back to list
    
    @IBAction func swiped_back(_ sender: Any) {
        transitionToList()
    }
    
}
