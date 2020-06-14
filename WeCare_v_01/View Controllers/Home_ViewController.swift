//
//  Home_ViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-04.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class Home_ViewController: UIViewController {
    
    @IBOutlet weak var nav_bar: UINavigationBar!
    
    @IBOutlet weak var sign_out_button: UIBarButtonItem!
    
    @IBOutlet weak var WeCare_Logo: UIImageView!
    
    @IBOutlet weak var nurse_name_label: UILabel!
    
    @IBOutlet weak var clock_in_button: UIButton!
    
    @IBOutlet weak var clock_out_button: UIButton!
    
    @IBOutlet weak var patient_list: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //authenticateUserAndConfigureView()
        setUpView()
        clock_out_button.alpha = 0.25
        get_user_info()
        generate_patient_list()
        
    }
    
    // set up teh view
    
    func setUpView() {
        // clock in button
        clock_in_button.layer.borderWidth = 1
        clock_in_button.layer.borderColor = UIColor.black.cgColor
        clock_in_button.layer.cornerRadius = 10.0
        clock_in_button.tintColor = UIColor.black
        
        // clock out button
        clock_out_button.layer.borderWidth = 1
        clock_out_button.layer.borderColor = UIColor.black.cgColor
        clock_out_button.layer.cornerRadius = 10.0
        clock_out_button.tintColor = UIColor.black
        
        // patient list buttons
        patient_list.layer.borderWidth = 1
        patient_list.layer.borderColor = UIColor.black.cgColor
        patient_list.layer.cornerRadius = 10.0
        patient_list.tintColor = UIColor.black
        
        // navigation bar set up
        nav_bar.barTintColor = UIColor.white
        
        // sign out button colour
        sign_out_button.tintColor = UIColor.red
    }
    
    
    
    
    // generate user info and add first name to welcome label
    
    func get_user_info () {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("Nurses").document(uid).getDocument { (snapshot, error) in
            guard let name = snapshot?.get("first_name") else { return }
            // add the user's name to welcome label
            self.nurse_name_label.text = "Welcome, \(name):"
            
        }
        
    }
    
    // get patient list from firestore:
    
    func generate_patient_list() {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("Nurses").document(uid).collection("Current Patient").document("Patient Info").getDocument { (snapshot, error) in
            guard let patient_name = snapshot?.get("name") else { return }
            self.patient_list.setTitle("\(patient_name)", for: .normal)
        }
    }
    
    
    // signOut navigation bar
    
    @IBAction func sign_out_tapped(_ sender: Any) {
        self.manageSignOut()
    }
    
    
    @objc func manageSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signout()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func signout() {
        do {
            try Auth.auth().signOut()
            self.transition_to_login_page()
            print("succesfully signed out")
            /*
            let navController = UINavigationController(rootViewController: ViewController())
            navController.navigationBar.barStyle = .black
            self.present(navController, animated: true, completion: nil)
            */
        } catch let error {
            print("failed to sign out user", error)
        }
    }
    
    // Mark - Use to navigate between viewcontrollers
    
    func transition_to_login_page() {
        let loginViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginviewcontroller) as? ViewController
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToHome(){
        let homeViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeviewcontroller) as? Home_ViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToList() {
        
        let listViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.listviewcontroller) as? list_ViewController
        view.window?.rootViewController = listViewController
        view.window?.makeKeyAndVisible()
        /*
        let newViewController = tableViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        */
    }
    
    /*
    func nurseName(_ name:String){
        let db = Firestore.firestore()
        let all_nurses = db.collection("Nurses")
        let nurse_first_name =
    */
  
    
    // Clocking the user in
    
    @IBAction func clock_in_tapped(_ sender: Any) {
        clock_in_button.alpha = 0.25
        clock_out_button.alpha = 1
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        // add clock in to firestore
        db.collection("Nurses").document(uid).collection("Clock In").addDocument(data: ["Time":NSDate()])
        print(" Succesfully clock-ed in user; \(uid) ")
    }
    
    // Clocking the user out
    
    @IBAction func clock_out_tapped(_ sender: Any) {
        clock_in_button.alpha = 1
        clock_out_button.alpha = 0.25
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        // add clock out to firestore
        db.collection("Nurses").document(uid).collection("Clock Out").addDocument(data: ["Time":NSDate()])
        print(" Succesfully clock-ed out user; \(uid) ")
    }
    
    //go to patients virtals page
    
    @IBAction func patient_tap(_ sender: Any) {
        transitionToList()
    }
    
    
    /* Dont reallly need the following code but its there just incase
      //keeping the user logged in
      
      func authenticateUserAndConfigureView() {
          //keep user signed in
          if Auth.auth().currentUser == nil{
              DispatchQueue.main.async {
                  let navController = UINavigationController(rootViewController: ViewController())
                  navController.navigationBar.barStyle = .black
                  self.present(navController, animated: true, completion: nil)
              }
          }
          else {
              self.configureViewComponents()
          }
      }
      
      
      func configureViewComponents() {
          navigationItem.title = "WeCare Nurse Login"
          navigationItem.leftBarButtonItem = UIBarButtonItem(title: "sign out", style: .plain, target: self, action: #selector(manageSignOut))
          navigationItem.leftBarButtonItem?.tintColor = .white
          
      }
    */
    
    
}

