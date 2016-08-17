//
//  ViewController.swift
//  yahtzee
//
//  Created by krikaz on 5/28/16.
//  Copyright © 2016 krikaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dice0: UILabel!
    @IBOutlet weak var dice1: UILabel!
    @IBOutlet weak var dice2: UILabel!
    @IBOutlet weak var dice3: UILabel!
    @IBOutlet weak var dice4: UILabel!
    
    @IBOutlet weak var acesButton: UIButton!
    @IBOutlet weak var twosButton: UIButton!
    @IBOutlet weak var threesButton: UIButton!
    @IBOutlet weak var foursButton: UIButton!
    @IBOutlet weak var fivesButton: UIButton!
    @IBOutlet weak var sixesButton: UIButton!
    @IBOutlet weak var threeKindButton: UIButton!
    @IBOutlet weak var fourKindButton: UIButton!
    @IBOutlet weak var fullHouseButton: UIButton!
    @IBOutlet weak var smallStraightButton: UIButton!
    @IBOutlet weak var largeStraightButton: UIButton!
    @IBOutlet weak var yahtzeeButton: UIButton!
    @IBOutlet weak var chanceButton: UIButton!
    
    @IBOutlet weak var scoreAces: UILabel!
    @IBOutlet weak var scoreTwos: UILabel!
    @IBOutlet weak var scoreThrees: UILabel!
    @IBOutlet weak var scoreFours: UILabel!
    @IBOutlet weak var scoreFives: UILabel!
    @IBOutlet weak var scoreSixes: UILabel!
    @IBOutlet weak var scoreThreeKind: UILabel!
    @IBOutlet weak var scoreFourKind: UILabel!
    @IBOutlet weak var scoreFullHouse: UILabel!
    @IBOutlet weak var scoreSmallStraight: UILabel!
    @IBOutlet weak var scoreLargeStraight: UILabel!
    @IBOutlet weak var scoreYahtzee: UILabel!
    @IBOutlet weak var scoreChance: UILabel!
    @IBOutlet weak var scoreTotal: UILabel!
    
    @IBOutlet weak var round: UILabel!
    

    
    var dice = [Int](count:5, repeatedValue: 0)
    var freeze = [Bool](count:5, repeatedValue: false)
    var table = [Int](count:13, repeatedValue: 0)
    var numberLaunch = 0
    var endTurn = false
    var diceLabel = [UILabel]()
    var tableButton = [UIButton]()
    var scoreLabel = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diceLabel.append(dice0)
        diceLabel.append(dice1)
        diceLabel.append(dice2)
        diceLabel.append(dice3)
        diceLabel.append(dice4)
        tableButton.append(acesButton)
        tableButton.append(twosButton)
        tableButton.append(threesButton)
        tableButton.append(foursButton)
        tableButton.append(fivesButton)
        tableButton.append(sixesButton)
        tableButton.append(threeKindButton)
        tableButton.append(fourKindButton)
        tableButton.append(fullHouseButton)
        tableButton.append(smallStraightButton)
        tableButton.append(largeStraightButton)
        tableButton.append(yahtzeeButton)
        tableButton.append(chanceButton)
        scoreLabel.append(scoreAces)
        scoreLabel.append(scoreTwos)
        scoreLabel.append(scoreThrees)
        scoreLabel.append(scoreFours)
        scoreLabel.append(scoreFives)
        scoreLabel.append(scoreSixes)
        scoreLabel.append(scoreThreeKind)
        scoreLabel.append(scoreFourKind)
        scoreLabel.append(scoreFullHouse)
        scoreLabel.append(scoreSmallStraight)
        scoreLabel.append(scoreLargeStraight)
        scoreLabel.append(scoreYahtzee)
        scoreLabel.append(scoreChance)
    }
    
    func checkFreezeAll() -> Bool {
        return freeze == [true,true,true,true,true]
    }
    
    func checkEndTurn() -> Bool {
        return endTurn
    }
    
    func checkEndTurnOrFreezeAll() -> Bool {
        return checkFreezeAll() || checkEndTurn()
    }
    
    func keep(x: Int) {
        if freeze[x] == false  && numberLaunch != 0 {
            freeze[x] = true
            diceLabelRed(x)
        } else {
            freeze[x] = false
            diceLabelBlack(x)
        }
    }
    
    @IBAction func keep0() {
        keep(0)
    }

    @IBAction func keep1() {
        keep(1)
    }

    @IBAction func keep2() {
        keep(2)
    }
    
    @IBAction func keep3() {
        keep(3)
    }
    
    @IBAction func keep4() {
        keep(4)
    }
    
    @IBAction func keepAll() {
        for x in 0...4 {
            freeze[x] = true
            diceLabelRed(x)
        }
    }
    
    func hideButton(num: Int) {
        tableButton[num].hidden = true
    }
    
    func showButton(num: Int) {
        tableButton[num].hidden = false
    }
    

    func number(num: Int) {
        if checkEndTurnOrFreezeAll() {
            for x in 0...4 {
                if dice[x] == num {
                    table[num-1] += num
                }
            }
            replay(num-1)
        }
    }
    
    @IBAction func aces() {
        number(1)
    }
    
    @IBAction func twos() {
        number(2)
    }

    @IBAction func threes() {
        number(3)
    }

    @IBAction func fours() {
        number(4)
    }
    
    @IBAction func fives() {
        number(5)
    }
    
    @IBAction func sixes() {
        number(6)
    }
    
    
    
    func numberKind(num: Int) {
        if checkEndTurnOrFreezeAll() {
            var count:[Int:Int] = [:]
            for item in dice {
                count[item] = (count[item] ?? 0) + 1
                if (num == 11 && count[item] == 5) {
                    table[num] = 50
                } else if count[item] >= num-3 {
                    table[num] = dice.reduce(0, combine: +)
                }
            }
            replay(num)
        }
        
    }
    
    @IBAction func threeKind() {
        numberKind(6)
    }
    
    @IBAction func fourKind() {
        numberKind(7)
    }
    
    @IBAction func yahtzee() {
        numberKind(11)
    }
    
    @IBAction func fullHouse() {
        if checkEndTurnOrFreezeAll() {
            var count:[Int:Int] = [:]
            for item in dice {
                count[item] = (count[item] ?? 0) + 1
            }
            let first = Array(count.values)[0]
            let second = Array(count.values)[1]
            if (first == 3 && second == 2) || (first == 2 && second == 3) {
                table[8] = 25
            }
            replay(8)
        }
    }
    
    func sortDices() {
        dice = dice.sort (<)
    }

    func allStraight(num: Int) {
        if checkEndTurnOrFreezeAll() {
            sortDices()
            var add = 0
            for x in 0...3 {
                if dice[x] == dice[x+1]-1 {
                    add += 1
                }
            }
            if add >= num-6 {
                table[num] = (num-6)*10
            }
            replay(num)
        }
    }
    
    @IBAction func smallStraight() {
        allStraight(9)
    }
    
    @IBAction func largeStraight() {
        allStraight(10)
    }



    @IBAction func chance() {
        if checkEndTurnOrFreezeAll() {
            table[12] = dice.reduce(0, combine:+)
            replay(12)
        }
    }
    
    func showPlayButtons() {
        for x in 0...12 {
            showButton(x)
        }
    }

    func updateScores(num: Int) {
        scoreLabel[num].text = "\(table[num])"
        scoreTotal.text = "\(table.reduce(0, combine:+))"
    }
    
    
    func updateDice(num: Int) {
            diceLabel[num].text = "\(dice[num])"
    }
    
    func updateAllDices() {
        for x in 0...4 {
            updateDice(x)
        }
    }
    
    @IBAction func launch() {
        if numberLaunch < 3 {
            for x in 0...4 {
                if freeze[x] == false {
                    dice[x] = Int(arc4random_uniform(6)+1)
                    updateDice(x)
                }
            }
            numberLaunch += 1
            writeRound()
            if numberLaunch == 3 {
                endTurn = true
            }
        }
    }
    
    func diceLabelBlack(num: Int) {
        diceLabel[num].textColor = UIColor.blackColor()
    }
    
    func diceLabelRed(num: Int) {
        diceLabel[num].textColor = UIColor.redColor()
    }
    
    func writeRound() {
        round.text = "\(numberLaunch)"
    }
    
    func reInitDice() {
        for x in 0...4 {
            dice[x] = 0
        }
    }
    
    func reInitFreeze() {
        for x in 0...4 {
            freeze[x] = false
        }
    }
    
    func reInitTable() {
        for x in 0...12 {
            table[x] = 0
        }
    }
    
    func reInitEndTurn() {
        endTurn = false
    }
    
    func reInitNumberLaunch() {
        numberLaunch = 0
    }
    
    func reInitAllDicesColor() {
        for x in 0...4 {
            diceLabelBlack(x)
        }
    }
    
    func reInitAllScores() {
        for x in 0...12 {
            updateScores(x)
        }
    }
    
    func restartReplay() {
        reInitNumberLaunch()
        reInitDice()
        reInitFreeze()
        reInitEndTurn()
        reInitAllDicesColor()
        writeRound()
        updateAllDices()
    }
    
    func replay(num: Int) {
        restartReplay()
        updateScores(num)
        hideButton(num)
    }
    
    @IBAction func start() {
        restartReplay()
        reInitTable()
        reInitAllScores()
        showPlayButtons()
    }

    
    
    
    
    
    
    
}












