//
//  IntakeViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-15.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class IntakeViewController: UIViewController {

    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var intakeLabel: UILabel!
    
    @IBOutlet weak var intakeText: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet var swipe_back: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        Utilities.styleTextField(intakeText)
        Utilities.styleFilledButton(submitButton)
        errorLabel.alpha = 0
        // navigation bar set up
        navbar.barTintColor = UIColor.white
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        transitionToList()
    }
    
    // Submit Button
    
    @IBAction func submitTapped(_ sender: Any) {
        
        //clean up data
        let intake = intakeText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // get patient UID
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("Nurses").document(uid).collection("Current Patient").document("Patient Info").getDocument { (snapshot, error) in
            guard let patient_uid = snapshot?.get("uid") else { return }
            
            // add intake info
            db.collection("Patients").document("\(patient_uid)").collection("Intake").addDocument(data: ["intake": intake, "Time": NSDate()])
            
            // error message
            self.errorLabel.alpha = 1
            self.errorLabel.text = "Sucessfully Submitted!"
            self.errorLabel.textColor = UIColor.init(red: 0.12, green: 0.66, blue: 0.62, alpha: 1)
            
            // clear text fields
            self.intakeText.text = ""
            
        }
        print("sucessfully submitted data")
    }
    
    
    // tranistion functions
    
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
