//
//  ViewController.swift
//  iKid
//
//  Created by Arjun Lalwani on 01/11/16.
//  Copyright © 2016 Arjun Lalwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var firstViewController: FirstViewController!
    private var secondViewController: SecondViewController!
    private var jokes: [String : [String]] = ["Good": ["How can a man go eight days without sleep?", "He sleeps at night."],
                                              "Pun": ["What is red and smells like blue paint?", "Red paint."],
                                              "Dad": ["Is this pool safe for diving?", "It deep ends."]]
    private var jokeIndex : String = ""
    
    
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var homeButton: UIBarButtonItem!
    
    
    private func firstBuilder() {
        if firstViewController == nil {
            firstViewController = storyboard?.instantiateViewController(withIdentifier: "First")  as! FirstViewController
        }
    }
    
    private func secondBuilder() {
        if secondViewController == nil {
            secondViewController = storyboard?.instantiateViewController(withIdentifier: "Second")  as! SecondViewController
        }

    }
    
    
    @IBAction func switchViews(_ sender: UIBarButtonItem) {
        firstBuilder()
        secondBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)

        // delivers answer page
        if (sender.title == "Answer" && firstViewController != nil && firstViewController?.view.superview != nil) {
            
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            
            secondViewController.view.frame = view.frame
            secondViewController.answer.text = jokes[jokeIndex]![1] // create var question in FVC
            secondViewController.answer.numberOfLines = 2
            self.homeButton.title = "Home"
            
            // switching from question to answer
            switchViewController(from: firstViewController, to: secondViewController)
        } else if (sender.title == "Home") {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            self.welcomeMessage.text = "Welcome! Select Jokes category"
            self.homeButton.title = "Home"
            secondViewController.answer.text = ""
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            firstViewController.view.frame = view.frame
            
            jokeIndex = sender.title!
            print(jokeIndex)
            firstViewController.question.text = jokes[jokeIndex]?[0]
            firstViewController.question.numberOfLines = 2
            self.welcomeMessage.text = ""
            self.homeButton.title = "Answer"
            
            // switching from answer to question
            switchViewController(from: secondViewController, to: firstViewController)
        }
        
        UIView.commitAnimations()
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParentViewController: self)
        }
        
        UIView.commitAnimations()

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
