//
//  ThirdViewController.swift
//  MatchTheMember
//
//  Created by Niky Arora on 2/7/18.
//  Copyright © 2018 Niky Arora. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    var navBar: UINavigationBar!
    var myString: String!
    var questionArray = [String]()
    var accuracyArray = [Bool]()
    var imageDict = [String:UIImage]()
    
    var streakLabel: UILabel!
    var questionLabel: UILabel!
    
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    
    var nameLabel1: UILabel!
    var nameLabel2: UILabel!
    var nameLabel3: UILabel!
    var correctLabel1: UILabel!
    var correctLabel2: UILabel!
    var correctLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: view.frame.width, height: 40))
        navBar.backgroundColor = .white
        let back = UINavigationItem()
        back.title = "Statistics"
        navBar.items = [back]
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(switchScreenGame(sender:)))
        back.leftBarButtonItem = backButton
        view.addSubview(navBar);
        
        streakLabel = UILabel(frame: CGRect(x:145, y:100, width:view.frame.width-150, height: 30))
        streakLabel.text = "Longest Streak: \(Int(myString)!)"
        self.view.addSubview(streakLabel)
        
        questionLabel = UILabel(frame: CGRect(x:150, y:175, width:view.frame.width-150, height: 30))
        questionLabel.text = "Last Questions"
        self.view.addSubview(questionLabel)
        
        nameLabel1 = UILabel(frame: CGRect(x:200, y:275, width:view.frame.width-150, height: 30))
        nameLabel2 = UILabel(frame: CGRect(x:200, y:450, width:view.frame.width-150, height: 30))
        nameLabel3 = UILabel(frame: CGRect(x:200, y:625, width:view.frame.width-150, height: 30))
        correctLabel1 = UILabel(frame: CGRect(x:200, y:300, width:view.frame.width-150, height: 30))
        correctLabel2 = UILabel(frame: CGRect(x:200, y:475, width:view.frame.width-150, height: 30))
        correctLabel3 = UILabel(frame: CGRect(x:200, y:650, width:view.frame.width-150, height: 30))
        
        imageView1 = UIImageView(frame:CGRect(x:25, y:225, width:150, height:150))
        imageView2 = UIImageView(frame:CGRect(x:25, y:400, width:150, height:150))
        imageView3 = UIImageView(frame:CGRect(x:25, y:575, width:150, height:150))
        getImages()
    }

    func getImages() {
        if questionArray.count == 1 {
            imageView1.image = imageDict[questionArray[0]]
            self.view.addSubview(imageView1)
            nameLabel1.text = "Name: \(questionArray[0])"
            self.view.addSubview(nameLabel1)
            correctLabel1.text = "Correct: \(accuracyArray[0])"
            self.view.addSubview(correctLabel1)
        }
        else if questionArray.count == 2 {
            imageView1.image = imageDict[questionArray[0]]
            imageView2.image = imageDict[questionArray[1]]
            self.view.addSubview(imageView1)
            self.view.addSubview(imageView2)
            nameLabel1.text = "Name: \(questionArray[0])"
            self.view.addSubview(nameLabel1)
            nameLabel2.text = "Name: \(questionArray[1])"
            self.view.addSubview(nameLabel2)
            correctLabel1.text = "Correct: \(accuracyArray[0])"
            self.view.addSubview(correctLabel1)
            correctLabel2.text = "Correct: \(accuracyArray[1])"
            self.view.addSubview(correctLabel2)
        }
        else if questionArray.count == 3 {
            imageView1.image = imageDict[questionArray[0]]
            imageView2.image = imageDict[questionArray[1]]
            imageView3.image = imageDict[questionArray[2]]
            self.view.addSubview(imageView1)
            self.view.addSubview(imageView2)
            self.view.addSubview(imageView3)
            nameLabel1.text = "Name: \(questionArray[0])"
            self.view.addSubview(nameLabel1)
            nameLabel2.text = "Name: \(questionArray[1])"
            self.view.addSubview(nameLabel2)
            nameLabel3.text = "Name: \(questionArray[2])"
            self.view.addSubview(nameLabel3)
            correctLabel1.text = "Correct: \(accuracyArray[0])"
            self.view.addSubview(correctLabel1)
            correctLabel2.text = "Correct: \(accuracyArray[1])"
            self.view.addSubview(correctLabel2)
            correctLabel3.text = "Correct: \(accuracyArray[2])"
            self.view.addSubview(correctLabel3)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func switchScreenGame(sender: UIButton!) {
        self.performSegue(withIdentifier: "unwindToGame", sender: sender)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
