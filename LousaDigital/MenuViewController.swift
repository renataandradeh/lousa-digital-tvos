//
//  MenuViewController.swift
//  LousaDigital
//
//  Created by Bruna Costa on 15/02/17.
//  Copyright © 2017 Renata Gondim Andrade Theóphilo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate {
    
    var activities = ["alfabeto", "numeros", "mundo", "cores", "mais"]
    @IBOutlet weak var tableViewMenu: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return activities[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMenu.dequeueReusableCell(withIdentifier: "cell") as! MenuRow
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    @IBAction func goActivities(_ sender: Any) {
        //transição da MenuViewController para GameViewController
        let game = GameViewController()
        present(game, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   ////////////
    
    
    


}
