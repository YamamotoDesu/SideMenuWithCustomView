//
//  ViewController.swift
//  SideMenu
//
//  Created by 山本響 on 2022/03/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewBG: UIImageView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    var menu = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    
    var options: [option] = [
    
        option(title: "Home",
               seque: "HomeSeque"),
        option(title: "Settings",
               seque: "SettingsSeque"),
        option(title: "Profile",
               seque: "ProfileSeque"),
        option(title: "Terms And Conditions",
               seque: "TermsSeque"),
        option(title: "Privacy Policy",
               seque: "PrivacySeque"),
    
    ]
    
    struct option {
        var title = String()
        var seque = String()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.backgroundColor = .clear
        
        home = containerView.transform
    }
    
    func hideMenu() {
        
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = self.home
            self.containerView.layer.cornerRadius = 0
            self.viewBG.layer.cornerRadius =
                self.containerView.layer.cornerRadius
        }
    }
    
    func showMenu() {
        
        self.containerView.layer.cornerRadius = 40
        self.viewBG.layer.cornerRadius =
            self.containerView.layer.cornerRadius
        let x = screen.width * 0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = scaledAndTranslatedTransform
        }
    }
    
    @IBAction func hideMenu(_ sender: UITapGestureRecognizer) {
        
        if menu == true {

            hideMenu()

            menu = false
        }
    }
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {

        if menu == false && swipeGesture.direction == .right {
            
            showMenu()
            
            menu = true
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        cell.backgroundColor = .clear
        cell.descriptionLabel.text = options[indexPath.row].title
        cell.descriptionLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
            currentCell.alpha = 0.5
            UIView.animate(withDuration: 1) {
                currentCell.alpha = 1
            }
            
            hideMenu()
            menu = false
            
            self.performSegue(withIdentifier: options[indexPath.row].seque, sender: self)
        }
    }
    
}

class tableViewCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
}
