//
//  ResultViewController.swift
//  shake_game
//
//  Created by 保坂篤志 on 2023/01/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    var result: Int = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLabel()
        
        updateData()
    }
    
    func setupButton() {
        
        backButton.layer.cornerCurve = .continuous
        backButton.layer.cornerRadius = backButton.bounds.height / 2
    }
    
    func setupLabel() {
        
        resultLabel.text = "\(result) 回！"
    }
    
    func updateData() {
        
        var data = UserDefaults.standard.array(forKey: "data") as? [Int] ?? []
        
        data.append(result)
        
        UserDefaults.standard.set(data, forKey: "data")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
