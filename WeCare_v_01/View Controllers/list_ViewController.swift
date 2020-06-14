//
//  list_ViewController.swift
//  WeCare_v_01
//
//  Created by Mikail Masood on 2020-05-15.
//  Copyright © 2020 Mikail Masood. All rights reserved.
//

import UIKit
import SwiftUI

class list_ViewController: UIViewController {
    
    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var vital_button: UIButton!
    
    @IBOutlet weak var medication_button: UIButton!
    
    @IBOutlet weak var intake_button: UIButton!
    
    @IBOutlet weak var output_button: UIButton!
    
    @IBOutlet weak var hygiene_button: UIButton!
    
    @IBOutlet weak var positioning_button: UIButton!
    
    @IBOutlet weak var bedsore_button: UIButton!
    
    @IBOutlet weak var dressing_button: UIButton!
    
    @IBOutlet weak var activity_button: UIButton!
    
    @IBOutlet var swipe_back: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    func setUpView() {
        Utilities.styleFilledButton(vital_button)
        vital_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(medication_button)
        medication_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(intake_button)
        intake_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(output_button)
        output_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(hygiene_button)
        hygiene_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(positioning_button)
        positioning_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(bedsore_button)
        bedsore_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(dressing_button)
        dressing_button.layer.cornerRadius = 10.0
        Utilities.styleFilledButton(activity_button)
        activity_button.layer.cornerRadius = 10.0
        
        // navigation bar set up
        navbar.barTintColor = UIColor.white
    }

    // giving the button tranisiton actions
    
    @IBAction func back_tapped(_ sender: Any) {
        transitionToHome()
    }
    
    @IBAction func vital_tapped(_ sender: Any) {
        transitionToVital()
    }
    
    @IBAction func med_tapped(_ sender: Any) {
        transitionToMedication()
    }
    
    @IBAction func in_tapped(_ sender: Any) {
        transitionToIntake()
    }
    
    @IBAction func out_tapped(_ sender: Any) {
        transitionToOutput()
    }
    
    @IBAction func hygiene_tapped(_ sender: Any) {
        transitionToHygiene()
    }
    
    @IBAction func pos_tapped(_ sender: Any) {
        transitionToPositioning()
    }
    
    @IBAction func bed_tapped(_ sender: Any) {
        transitionToBedsore()
    }
    
    @IBAction func dress_tapped(_ sender: Any) {
        transtionToDressing()
    }
    
    @IBAction func act_tapped(_ sender: Any) {
        transitionToActivity()
    }
    
    
    // Tranisition Functions
    
    func transitionToVital() {
        let vitalViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.vitalviewcontroller) as? VitalViewController
        view.window?.rootViewController = vitalViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToMedication() {
        let medViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.medicationviewcontroller) as? MedicationViewController
        view.window?.rootViewController = medViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToIntake() {
        let intakeViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.intakeviewcontroller) as? IntakeViewController
        view.window?.rootViewController = intakeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToOutput() {
        let outputViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.outputviewcontroller) as? OutputViewController
        view.window?.rootViewController = outputViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToHygiene() {
        let hygieneViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.hygieneviewcontroller) as? HygieneViewController
        view.window?.rootViewController = hygieneViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToPositioning() {
        let posViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.positioningviewcontroller) as? PositioningViewController
        view.window?.rootViewController = posViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToBedsore() {
        let bedsoreViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.bedsoreviewcontroller) as? BedsoreViewController
        view.window?.rootViewController = bedsoreViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func transtionToDressing() {
        let dressViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.dressingviewcontroller) as? DressingViewController
        view.window?.rootViewController = dressViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToActivity() {
        let activityViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.activityviewcontroller) as? ActivityViewController
        view.window?.rootViewController = activityViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToHome(){
        let homeViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeviewcontroller) as? Home_ViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    // swipe to go back home
    
    @IBAction func swiped_back(_ sender: Any) {
        transitionToHome()
    }
    
}
