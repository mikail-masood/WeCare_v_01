//
//  DressingViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-15.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DressingViewController: UIViewController {

    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var dressedButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet var swipe_back: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        Utilities.styleHollowButton(dressedButton)
        errorLabel.alpha = 0
        // navigation bar set up
        navbar.barTintColor = UIColor.white
    }
    
    @IBAction func backTapped(_ sender: Any) {
        transitionToList()
    }
    
    // tap dressing button
    
    @IBAction func dressTapped(_ sender: Any) {
        
        //dim the button for 1 second
        dressedButton.alpha = 0.25
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ) {
            self.dressedButton.alpha = 1.0
        }
        // get patient UID
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("Nurses").document(uid).collection("Current Patient").document("Patient Info").getDocument { (snapshot, error) in
            guard let patient_uid = snapshot?.get("uid") else { return }
            // add dresing data
            db.collection("Patients").document("\(patient_uid)").collection("Dressing").addDocument(data: ["Dressed": "Yes", "Time": NSDate()])
            // error label
            self.errorLabel.alpha = 1
            self.errorLabel.text = "Sucessfully Submitted!"
            self.errorLabel.textColor = UIColor.init(red: 0.12, green: 0.66, blue: 0.62, alpha: 1)
        }
    }
    
    
    
    
    // transition function
    func transitionToList() {
        let listViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.listviewcontroller) as? list_ViewController
        view.window?.rootViewController = listViewController
        view.window?.makeKeyAndVisible()
    }

    //swipe to gop back
    
    @IBAction func swiped_back(_ sender: Any) {
        transitionToList()
    }
}
