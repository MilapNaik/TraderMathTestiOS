//
//  FinishTest.swift
//  TraderMathTestiOS
//
//  Created by Milap Naik on 5/26/16.
//  Copyright (c) 2016 Gamelap Studios. All rights reserved.
//

import Foundation
import UIKit


class FinishTestController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    var highscore:Int?
    var finishtime:String?
    let db = SQLiteDB.sharedInstance()
    
    var bestRank: [String] = ["1", "2", "3", "4", "5"]
    var bestScore: [String] = ["-----", "-----", "-----", "-----", "-----"]
    var bestTime: [String] = ["-----", "-----", "-----", "-----", "-----"]
    
    var i: Int = 0


    @IBOutlet weak var correctAnswers: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addhighscore()
        loadhighscores()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestRank.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.column1.text = self.bestRank[indexPath.row]
        cell.column2.text = self.bestScore[indexPath.row]
        cell.column3.text = self.bestTime[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        correctAnswers.text = "Score: \(highscore!)"
        finishTime.text = "Time: \(finishtime!)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    @IBAction func Menu(sender: UIButton) {
        self.performSegueWithIdentifier("goestoMenu", sender: self)
    }
    
    
    func addhighscore(){
        db.execute("INSERT INTO EASY_MATH5 (Score, Time) Values ('\(highscore!)', '\(finishtime!)'); ", parameters:nil)
    }
    
    func loadhighscores(){
        var result = db.query("SELECT * from EASY_MATH5 ORDER BY Score DESC, Time ASC LIMIT 5", parameters: nil)
        println("===============================")
        
        for row in result
        {
            //FirstScore.text = row["Score"]!.asString()
            //FirstTime.text = row["Time"]!.asString()
            
            /*print(row["Rank"]!.asString())
            print(" ")
            print(row["Score"]!.asString())
            print(" ")
            println(row["Time"]!.asString())*/
            
            bestScore[i] = row["Score"]!.asString()
            print(bestScore[i])
            bestTime[i] = row["Time"]!.asString()
            println(bestTime[i])
            
            i++
        }
        
    }
    
}
    
