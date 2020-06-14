//
//  MedicationViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-15.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class MedicationViewController: UIViewController {
    
    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var backbutton: UIBarButtonItem!
    
    @IBOutlet weak var medicationLabel: UILabel!
    
    @IBOutlet weak var medicationNameText: UITextField!
    
    @IBOutlet weak var doseText: UITextField!
    
    @IBOutlet weak var freqText: UITextField!
    
    @IBOutlet weak var routeText: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet var swipe_back: UIScreenEdgePanGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    

    func setUpView() {
        Utilities.styleTextField(medicationNameText)
        Utilities.styleTextField(doseText)
        Utilities.styleTextField(routeText)
        Utilities.styleTextField(freqText)
        Utilities.styleFilledButton(submitButton)
        errorLabel.alpha = 0
        // navigation bar set up
        navbar.barTintColor = UIColor.white
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        transitionToList()
    }
    
    // submit button function

    @IBAction func submitTapped(_ sender: Any) {
        
        // clean up text fields
        let medName = medicationNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let dose = doseText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let route = routeText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let freq = freqText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // get patient UID
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("Nurses").document(uid).collection("Current Patient").document("Patient Info").getDocument { (snapshot, error) in
            guard let patient_uid = snapshot?.get("uid") else { return }
            // add medication info
            db.collection("Patients").document("\(patient_uid)").collection("Medication").addDocument(data: ["Medication Name": medName, "Dosage": dose, "Route": route, "Frequency": freq, "Time": NSDate()])
            self.errorLabel.alpha = 1
            self.errorLabel.text = "Sucessfully Submitted!"
            self.errorLabel.textColor = UIColor.init(red: 0.12, green: 0.66, blue: 0.62, alpha: 1)
            
            // clear text fields
            self.medicationNameText.text = ""
            self.doseText.text = ""
            self.routeText.text = ""
            self.freqText.text = ""
        }
        print("sucessfully submitted data")
    }
    
    
    
    
    
    //transition functions
    
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
