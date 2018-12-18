//
//  matchGameModel.swift
//  MatchGameiOS
//
//  Created by Rocco Salerno on 3/31/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import Foundation

class myGamePlay
{
    struct Node{
        var isMatched = false
        var emojiSymbol = ""
    }
    
    let emojiArray = ["😈","🎱","🏓","🎮","🔬","⛄️","💩","☠️","🤖","👻"]//emojis that will be used for gmae
    var emojiRow = [Node]()//a row of emojis that will be put in gameBoard
    var gameBoard = [[Node]]() //entire gameBoard
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
init(){
    var counter: Int
    var myItem = Node(isMatched: false, emojiSymbol: "")
    var randomEmoji: Int
    for _ in 0...4
    {
        emojiRow.removeAll()
        counter = 0
    
        while counter < 4
        {
            randomEmoji = Int(arc4random_uniform(10)) // chooses random index from emojiArray
            if(!doesExist(emojiArray[randomEmoji])) //if the randomEmoji does not exist, do this
            {
                myItem.emojiSymbol = emojiArray[randomEmoji] //creates a new Node(myItem) and fills it with random emoji
                emojiRow.append(myItem)
                counter = counter + 1
            }
        }
        gameBoard.append(emojiRow)
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func doesExist(_ emojiItem:String)->Bool
    {
        var ans = false
        var count = 0
        var rowCount = 0
        
        for (_, row) in gameBoard.enumerated()
        {
           for(_, cell) in row.enumerated()
           {
                if cell.emojiSymbol == emojiItem
                {
                    count = count + 1
                }
            }
        }
        for eachIndex in emojiRow
        {
            if eachIndex.emojiSymbol == emojiItem
            {
                rowCount = rowCount + 1
            }
        }
       count = count + rowCount
       if count == 2
       {
           ans = true
       }
        return ans
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func getRowNumber(_ id:Int)->Int?
    {
        var rowNumber: Int?
        
        switch id
        {
        case 0...3: rowNumber = 0
        case 4...7: rowNumber = 1
        case 8...11: rowNumber = 2
        case 12...15: rowNumber = 3
        case 16...19: rowNumber = 4
        
        default: rowNumber = nil
        }
        
        return rowNumber
    }
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func getSymbol(_ theID: Int)->String
    {
        let number = theID%4
        var theString:String
        
        if let newIndex = getRowNumber(theID)
        {
            theString = gameBoard[newIndex][number].emojiSymbol
        }
        else{
            theString = ""
        }
        return theString
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func checkMatch(_ id: Int, id2: Int)->Bool{
        var match = false
        var firstSymbol: String
        var secondSymbol: String
        let theID = id%4 //get coloum number
        let theID2 = id2%4
        
        if let firstIndex = getRowNumber(id)
        {
            firstSymbol = gameBoard[firstIndex][theID].emojiSymbol
            if let secondIndex = getRowNumber(id2)
            {
                secondSymbol = gameBoard[secondIndex][theID2].emojiSymbol
                if firstSymbol == secondSymbol
                {
                    match = true
                    gameBoard[firstIndex][theID].isMatched = true
                    gameBoard[secondIndex][theID2].isMatched = true
                }
            }
        }
        return match
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func printBoard()
    {
        var theRow = ""
        for(_,row) in gameBoard.enumerated(){
            for(_,cell) in row.enumerated(){
                theRow = theRow + cell.emojiSymbol
            }
            print(theRow)
            theRow = ""
        }
    }
    
}
