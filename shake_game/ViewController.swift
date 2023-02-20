//
//  ViewController.swift
//  shake_game
//
//  Created by 保坂篤志 on 2023/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var rankingButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupButton()
    }
    
    func setupButton() {
        
        startButton.layer.cornerCurve = .continuous
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        
        rankingButton.layer.cornerCurve = .continuous
        rankingButton.layer.cornerRadius = startButton.bounds.height / 2
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "toGameView", sender: nil)
    }
    
    @IBAction func backButtonPressed(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func rankingButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "toRankingView", sender: nil)
    }
    
}
