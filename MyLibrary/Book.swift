//
//  Book.swift
//  MyBooks
//
//  Created by Xinyu Zhao on 1/4/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit
import CoreData

class Book: NSObject {
    var title: String!
    var author: String!
    var genre: [String]!
    var dateAdd: NSDate!
    var readStatus: Bool!
    var category: String!
    var pages: Int!
    var timeAfterAdd: String!
    var folders: [String]!
    var favorite: Bool!
    var favoriteQuote: String!
    
    init(title: String, author: String, genre: [String], readStatus: Bool, category: String, pages: Int, favorite: Bool, favoriteQuote: String)
    {
        self.title = title
        self.author = author
        self.genre = genre
        self.dateAdd = NSDate()
        self.readStatus = readStatus
        self.category = category
        self.pages = pages
        
        let cal = NSCalendar.currentCalendar()
        let flags = NSCalendarUnit.Day
        let components = cal.components(flags, fromDate: dateAdd, toDate: NSDate(), options: NSCalendarOptions.MatchFirst)
        let days = components.day
        self.timeAfterAdd = "Added \(days) days ago"
        
        self.folders = [String]()
        self.favorite = favorite
        self.favoriteQuote = favoriteQuote
    }
    
    func compareTo(other: Book) -> Bool
    {
        if(title == other.title && author == other.author && genre == other.genre && dateAdd.compare(other.dateAdd) == NSComparisonResult.OrderedSame && readStatus == other.readStatus && category == other.category && pages == other.pages && timeAfterAdd == other.timeAfterAdd && favorite == other.favorite && favoriteQuote == other.favoriteQuote){
            return true
        }
        else{
            return false
        }
    }
    
    override var description: String {
        return "Title: " + self.title + " Read Stats: \(self.readStatus)"
    }
}
