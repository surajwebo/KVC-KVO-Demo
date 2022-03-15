//
//  ViewController.swift
//  KVC-KVO-Demo
//
//  Created by Suraj Mirajkar on 15/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // KVC
        let car = Car(model: "Tata", variant: "Indica Vista")
        print("Direct accessing variable from class Car - Model: " + car.model + "Variant: " + car.variant)
        
        if let model = car.value(forKey: "model") as? String {
            print("KVC accessing value for key from class Car - Model: " + model)
        }
        if let variant = car.value(forKey: "variant") as? String {
            print("KVC accessing value for key class Car - Variant: " + variant)
        }
        
        // KVO
        let observingModel = car.observe(\.model, options: [.old, .new]) { observerCar, observerModel in
            print("KVO observing car model old: " + observerModel.oldValue!)
            print("KVO observing car model new: " + observerModel.newValue!)
        }
        
        let observingVariant = car.observe(\.variant, options: [.old, .new]) { observerCar, observerVariant in
            print("KVO observing car variant old: " + observerVariant.oldValue!)
            print("KVO observing car variant new: " + observerVariant.newValue!)
        }
        
        car.model = "Mahindra"
        car.variant = "XUV 700"
        
        car.model = "Maruti"
        car.variant = "Vitara Brezza"
    }
}

class Car: NSObject {
    @objc dynamic var model: String //@objc is required to expose this var to ObjectiveC layer and dynamic is required to make it compliant to KVC
    @objc dynamic var variant: String
    
    init(model: String, variant: String) {
        self.model = model
        self.variant = variant
    }
}
