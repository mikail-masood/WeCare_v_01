//
//  ActivityViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-15.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ActivityViewController: UIViewController {

    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var activityText: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet var swipe_back: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    

    func setUpView() {
        Utilities.styleTextField(activityText)
        Utilities.styleFilledButton(submitButton)
        errorLabel.alpha = 0
        // navigation bar set up
        navbar.barTintColor = UIColor.white
    }
    
    @IBAction func backTapped(_ sender: Any) {
        transitionToList()
    }
    
    // submit Button
    
    
    @IBAction func submitTapped(_ sender: Any) {
        
        // clean the data
        let activity = activityText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // get patient UID
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("Nurses").document(uid).collection("Current Patient").document("Patient Info").getDocument { (snapshot, error) in
            guard let patient_uid = snapshot?.get("uid") else { return }
            // add activity data
            db.collection("Patients").document("\(patient_uid)").collection("Activity").addDocument(data: ["activity": activity, "Time": NSDate()])
            // error message
            self.errorLabel.alpha = 1
            self.errorLabel.text = "Sucessfully Submitted!"
            self.errorLabel.textColor = UIColor.init(red: 0.12, green: 0.66, blue: 0.62, alpha: 1)
            // clear text field
            self.activityText.text = ""
            
        }
        print("sucessfully submitted")
    }
    
    
    
    // tarnsition Functions
    
    func transitionToList() {
        let listViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.listviewcontroller) as? list_ViewController
        view.window?.rootViewController = listViewController
        view.window?.makeKeyAndVisible()
    }

    // swiped to go to list
    @IBAction func swiped_back(_ sender: Any) {
        transitionToList()
    }
}
