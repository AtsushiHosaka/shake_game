//
//  RankingViewController.swift
//  shake_game
//
//  Created by 保坂篤志 on 2023/01/25.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    
    var data = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    
    func setupButton() {
        
        backButton.layer.cornerRadius = backButton.bounds.height / 2
        
        backButton.layer.cornerCurve = .continuous
    }
    
    func getData() {
        
        data = UserDefaults.standard.array(forKey: "data") as? [Int] ?? []
        
        data.sort(by: { $0 >= $1 })
        
        tableView.reloadData()
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension RankingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        
        config.text = "\(data[indexPath.row])回"
        
        config.secondaryText = "\(indexPath.row + 1)位"
        
        config.textProperties.font = UIFont(name: "Helvetica Neue Bold", size: 27)!
        config.secondaryTextProperties.font = UIFont(name: "Helvetica Neue Bold", size: 14)!
        
        cell.contentConfiguration = config
        
        return cell
    }
    
    
    
}

extension RankingViewController: UITableViewDelegate {
    
}
