//
//  GameViewController.swift
//  shake_game
//
//  Created by 保坂篤志 on 2023/01/25.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {

    let motionManager = CMMotionManager()
    
    var pastAccel: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)
    
    var timer = Timer()
    
    var time: Int = 3
    
    var count: Int = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        countLabel.text = "3"
    }
    
    func startMotionManager() {
        
        if motionManager.isAccelerometerAvailable {
            // intervalの設定 [sec]
            motionManager.accelerometerUpdateInterval = 0.2
            
            // センサー値の取得開始
            motionManager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                    self.outputAccelData(acceleration: accelData!.acceleration)
                })
            
        }
    }
    
    func outputAccelData(acceleration: CMAcceleration){
        
        if length(of: acceleration - pastAccel) > 3.7 {
            
            count += 1
            
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            
            countLabel.text = String(count)
        }
        
        pastAccel = acceleration
    }
    
    func setupTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        time -= 1
        
        if time > 0 {
            
            countLabel.text = String(time)
            
        }
        
        if time == 0 {
            
            countLabel.text = "START!"
            startMotionManager()
        }
        
        if time <= -10 {
            
            timer.invalidate()
            
            stopAccelerometer()
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            performSegue(withIdentifier: "toResultView", sender: nil)
        }
    }
    
    // センサー取得を止める場合
    func stopAccelerometer(){
        
        if (motionManager.isAccelerometerActive) {
            
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    func length(of vector: CMAcceleration) -> Double {
        
        return sqrt(powl(vector.x, 2) + powl(vector.y, 2) + powl(vector.z, 2))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let resultView = segue.destination as! ResultViewController
        
        resultView.result = count
    }

}

extension CMAcceleration {
    
    static func -(left: CMAcceleration, right: CMAcceleration) -> CMAcceleration {
        
        return CMAcceleration(x: right.x - left.x, y: right.y - left.y, z: right.z - left.z)
    }
}
