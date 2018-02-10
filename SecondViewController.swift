//
//  SecondViewController.swift
//  MatchTheMember
//
//  Created by Niky Arora on 2/7/18.
//  Copyright © 2018 Niky Arora. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController {
    
    var imageView: UIImageView!
    var imageDictionary = [String:UIImage]()
    var nameOptions = [UIButton]()
    var names = [String]()
    var members = [String]()
    var name: String = ""
    let numImages: UInt32 = 53
    var correctLocation: UInt32 = arc4random_uniform(4)
    
    var answered: Bool = false
    var answeredCorrect: Bool = false
    var answeredLastCorrect: Bool = false
    
    var timer1: Timer!
    var time1 = 5.0
    var timeLabel: UILabel!
    
    var timer2: Timer!
    var time2 = 1.0
    var navBar: UINavigationBar!
    
    var score: Int = 0
    var longestStreak: Int = 0
    var currentLongest: Int = 0
    var numRounds: Int = 0
    var questions = [String]()
    var accuracy = [Bool]()
    
    var toStats: Bool = false
    
    var toggleStop: UIButton!
    var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        populateImageDictionary()
        members = Array(imageDictionary.keys)
        
        navBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: view.frame.width, height: 40))
        //navBar.backgroundColor = UIColor(red:1.00, green:0.79, blue:0.20, alpha:1.0)
        let statistics = UINavigationItem()
        statistics.title = "Member Match"
        navBar.items = [statistics]
        let statsButton = UIBarButtonItem(image: UIImage(named: "statisticsicon"), style: .plain, target: self, action: #selector(switchScreenStatistics(sender:)))
        statistics.rightBarButtonItem = statsButton
        view.addSubview(navBar);
        
        toggleStop = UIButton(frame: CGRect(x: 20, y:650, width:view.frame.width - 40, height: 50))
        toggleStop.setTitle("STOP", for: .normal)
        toggleStop.setTitleColor(UIColor (red:1.00, green:0.79, blue:0.20, alpha:1.0), for: .normal)
        toggleStop.backgroundColor = UIColor.clear
        toggleStop.layer.borderWidth = 1.0
        toggleStop.layer.borderColor = UIColor(red:1.00, green:0.79, blue:0.20, alpha:1.0).cgColor
        toggleStop.layer.cornerRadius = 20
        toggleStop.addTarget(self, action: #selector(stopButton(sender:)), for: .touchUpInside)
        view.addSubview(toggleStop)
        
        imageView = UIImageView(frame:CGRect(x:50, y:100, width:view.frame.width-100, height:view.frame.width-100))
        generateImage()
        numRounds += 1
        
        timeLabel = UILabel(frame: CGRect(x:125, y:410, width:view.frame.width-150, height: 30))
        timeLabel.text = "Time Left: 5.0 seconds"
        self.view.addSubview(timeLabel)
        runTimer()
        
        scoreLabel = UILabel(frame: CGRect(x:170, y:575, width:view.frame.width-100, height: 40))
        scoreLabel.text = "Score: \(score)"
        self.view.addSubview(scoreLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func switchScreenStatistics(sender: UIButton!) {
        toStats = true
        timer1.invalidate()
        //timer2.invalidate()
        self.performSegue(withIdentifier: "showThirdViewController", sender: sender)
    }
    
    @objc func stopButton(sender: UIButton!) {
        self.performSegue(withIdentifier: "showFirstViewController", sender: toggleStop)
    }
    
    @objc func checkCorrect(sender: UIButton!) {
        for i in 0...3 {
            nameOptions[i].isUserInteractionEnabled=false
            timer1.invalidate()
            answered = true
            if(sender == nameOptions[i]) {
                if(correctLocation==i){
                    nameOptions[i].backgroundColor = .green
                    answeredCorrect = true
                }
                else {
                    nameOptions[i].backgroundColor = .red
                    nameOptions[Int(correctLocation)].backgroundColor = .green
                }
            }
        }
        if(answered == true) {
            if(answeredCorrect==true){
                score += 1
                answeredLastCorrect = true
            }
           runTimer2()
        }
    }
    
    func runTimer() {
        timer1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(SecondViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func runTimer2() {
        timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(SecondViewController.updateTimer2)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(Int(time1) <= 0) {
            timeLabel.text = "Time Left: 0.0 seconds"
            timer1.invalidate()
            if(answered == false) {
                for i in 0...3 {
                    if(i == correctLocation) {
                        nameOptions[i].backgroundColor = .green
                    }
                    else {
                        nameOptions[i].backgroundColor = .red
                    }
                    nameOptions[i].isUserInteractionEnabled=false
                }
                runTimer2()
            }
        }
        else {
            timeLabel.text = "Time Left: \(String(time1)) seconds"
        }
        time1 -= 0.1
    }
    
    @objc func updateTimer2() {
        time2 -= 0.1
        if(time2 <= 0) {
            timer2.invalidate()
            resetConstruction()
        }
    }
    
    
    func resetTimer1() {
        time1 = 5.0
        timeLabel.text = "Time Left: 5.0 seconds"
        runTimer()
    }
    
    func resetTimer2() {
        time1 = 1.0
    }
    
    func resetConstruction() {
        saveQuestions()
        longest()
        answered = false
        answeredCorrect = false
        updateScoreLabel()
        numRounds += 1
        time2 = 1.0
        names.removeAll()
        nameOptions.removeAll()
        generateImage()
        resetTimer1()
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
        self.view.addSubview(scoreLabel)
    }
    func saveQuestions() {
        if(numRounds==1){
            if(answeredCorrect) {
                accuracy.append(true)
            }
            else {
                accuracy.append(false)
            }
            questions.append(name)
        }
        else if(numRounds == 2) {
            questions.append(name)
            if(answeredCorrect) {
                accuracy.append(true)
            }
            else {
                accuracy.append(false)
            }
        }
        else if(numRounds == 3) {
            if(answeredCorrect) {
                accuracy.append(true)
            }
            else {
                accuracy.append(false)
            }
            questions.append(name)
        }
        else{
            questions[0] = questions[1]
            accuracy[0] = accuracy[1]
            questions[1] = questions[2]
            accuracy[1] = accuracy[2]
            questions[2] = name
            accuracy[2] = answeredCorrect
        }
    }
    
    func longest() {
        if(answeredCorrect) {
            if(answeredLastCorrect || score == 0) {
                currentLongest += 1
                answeredLastCorrect = true
            }
        }
        else {
            currentLongest = 0
            answeredLastCorrect = false
        }
        if(currentLongest >= longestStreak) {
            longestStreak = currentLongest
        }
    }
    
    func populateImageDictionary() {
        imageDictionary = ["Daniel Andrews": #imageLiteral(resourceName: "danielandrews"), "Nikhar Arora": #imageLiteral(resourceName: "nikhararora"), "Tiger Chen": #imageLiteral(resourceName: "tigerchen"), "Xin Yi Chen": #imageLiteral(resourceName: "xinyichen"), "Julie Deng": #imageLiteral(resourceName: "juliedeng"), "Radhika Dhomse": #imageLiteral(resourceName: "radhikadhomse"), "Kaden Dippe": #imageLiteral(resourceName: "kadendippe"), "Angela Dong": #imageLiteral(resourceName: "angeladong"), "Zach Govani": #imageLiteral(resourceName: "zachgovani"), "Shubham Gupta": #imageLiteral(resourceName: "shubhamgupta"), "Suyash Gupta": #imageLiteral(resourceName: "suyashgupta"), "Joey Hejna": #imageLiteral(resourceName: "joeyhejna"), "Cody Hsieh": #imageLiteral(resourceName: "codyhsieh"), "Stephen Jayakar": #imageLiteral(resourceName: "stephenjayakar"), "Aneesh Jindal": #imageLiteral(resourceName: "aneeshjindal"), "Mohit Katyal": #imageLiteral(resourceName: "mohitkatyal"), "Mudabbir Khan": #imageLiteral(resourceName: "mudabbirkhan"), "Akkshay Khoslaa": #imageLiteral(resourceName: "akkshaykhoslaa"), "Justin Kim": #imageLiteral(resourceName: "justinkim"), "Eric Kong": #imageLiteral(resourceName: "erickong"), "Abhinav Koppu": #imageLiteral(resourceName: "abhinavkoppu"), "Srujay Korlakunta": #imageLiteral(resourceName: "srujaykorlakunta"), "Ayush Kumar": #imageLiteral(resourceName: "ayushkumar"), "Shiv Kushwah": #imageLiteral(resourceName: "shivkushwah"), "Leon Kwak": #imageLiteral(resourceName: "leonkwak"), "Sahil Lamba": #imageLiteral(resourceName: "sahillamba"), "Young Lin": #imageLiteral(resourceName: "younglin"), "William Lu": #imageLiteral(resourceName: "williamlu"), "Louie McConnell": #imageLiteral(resourceName: "louiemcconnell"), "Max Miranda": #imageLiteral(resourceName: "maxmiranda"), "Will Oakley": #imageLiteral(resourceName: "willoakley"), "Noah Pepper": #imageLiteral(resourceName: "noahpepper"), "Samanvi Rai": #imageLiteral(resourceName: "samanvirai"), "Krishnan Rajiyah": #imageLiteral(resourceName: "krishnanrajiyah"), "Vidya Ravikumar": #imageLiteral(resourceName: "vidyaravikumar"), "Shreya Reddy": #imageLiteral(resourceName: "shreyareddy"), "Amy Shen": #imageLiteral(resourceName: "amyshen"), "Wilbur Shi": #imageLiteral(resourceName: "wilburshi"), "Sumukh Shivakumar": #imageLiteral(resourceName: "sumukhshivakumar"), "Fang Shuo": #imageLiteral(resourceName: "fangshuo"), "Japjot Singh": #imageLiteral(resourceName: "japjotsingh"), "Victor Sun": #imageLiteral(resourceName: "victorsun"), "Sarah Tang": #imageLiteral(resourceName: "sarahtang"), "Kanyes Thaker": #imageLiteral(resourceName: "kanyesthaker"), "Aayush Tyagi": #imageLiteral(resourceName: "aayushtyagi"), "Levi Walsh": #imageLiteral(resourceName: "leviwalsh"), "Carol Wang": #imageLiteral(resourceName: "carolwang"), "Sharie Wang": #imageLiteral(resourceName: "shariewang"), "Ethan Wong": #imageLiteral(resourceName: "ethanwong"), "Natasha Wong": #imageLiteral(resourceName: "natashawong"), "Aditya Yadav": #imageLiteral(resourceName: "adityayadav"), "Candice Ye": #imageLiteral(resourceName: "candiceye"), "Vineeth Yeevani": #imageLiteral(resourceName: "vineethyeevani"), "Jeffery Zhang": #imageLiteral(resourceName: "jeffreyzhang")]
    }
    
    func generateImage() {
        let random = arc4random_uniform(numImages + 1)
        name = members[Int(random)]
        imageView.image = imageDictionary[name]
        self.view.addSubview(imageView)
        correctLocation = arc4random_uniform(4)
        displayNameOptions()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(toStats){
            let statsController = segue.destination as! ThirdViewController
            statsController.myString = "\(longestStreak)"
            statsController.questionArray = questions
            statsController.accuracyArray = accuracy
            statsController.imageDict = imageDictionary
        }
    }
    
    func displayNameOptions() {
        
        for j in 0...3 {
            if(j==correctLocation) {
                names.append(name)
            }
            else {
                var nameOption: String = members[Int(arc4random_uniform(numImages))]
                while(names.contains(nameOption) || nameOption == name) {
                    nameOption = members[Int(arc4random_uniform(numImages))]
                }
                names.append(nameOption)
            }
        }
       
        for i in 0...3 {
            if i%2 == 0 {
                nameOptions.append(UIButton(frame: CGRect(x: 220, y:450 + (i*30), width:175, height: 40)))
            }
            else {
                nameOptions.append(UIButton(frame: CGRect(x: 20, y:450 + ((i-1)*30), width:175, height: 40)))
            }
            nameOptions[i].layer.cornerRadius = 10
            nameOptions[i].setTitleColor(UIColor (red:1.00, green:0.79, blue:0.20, alpha:1.0), for: .normal)
            nameOptions[i].backgroundColor = UIColor(red:0.09, green:0.51, blue:0.79, alpha:1.0)
            nameOptions[i].layer.borderWidth = 1.0
            nameOptions[i].layer.borderColor = UIColor(red:1.00, green:0.79, blue:0.20, alpha:1.0).cgColor
            nameOptions[i].setTitle(names[i], for: .normal)
            nameOptions[i].addTarget(self, action: #selector(checkCorrect(sender:)), for: .touchUpInside)
            view.addSubview(nameOptions[i])
        }
    }
    
    @IBAction func unwindToGame(Segue: UIStoryboardSegue) {
        toStats = false
        resetConstruction()
    }


}
