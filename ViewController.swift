//
//  ViewController.swift
//  MatchTheMember
//
//  Created by Niky Arora on 2/7/18.
//  Copyright © 2018 Niky Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    var toggleStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red:0.09, green:0.51, blue:0.79, alpha:1.0)
        
        toggleStart = UIButton(frame: CGRect(x: 20, y:650, width:view.frame.width - 40, height: 50))
       // toggleStart.backgroundColor = .blue
        
        toggleStart.setTitle("START", for: .normal)
        toggleStart.setTitleColor(UIColor (red:1.00, green:0.79, blue:0.20, alpha:1.0), for: .normal)
        toggleStart.backgroundColor = UIColor.clear
        toggleStart.layer.borderWidth = 1.0
        toggleStart.layer.borderColor = UIColor(red:1.00, green:0.79, blue:0.20, alpha:1.0).cgColor
        toggleStart.layer.cornerRadius = 20
        toggleStart.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        view.addSubview(toggleStart)
        
        imageView = UIImageView(frame:CGRect(x:50, y:200, width:view.frame.width-100, height:150))
        imageView.image = UIImage(named: "logo")
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func buttonPressed(sender: UIButton!) {
        self.performSegue(withIdentifier: "showSecondViewController", sender: toggleStart)
    }
}

