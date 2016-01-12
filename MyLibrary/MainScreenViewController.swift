//
//  MainScreenViewController.swift
//  MyLibrary
//
//  Created by Xinyu Zhao on 1/6/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    var bookList = Library(books: [Book]())
    
    @IBOutlet weak var enter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let door = UIImageView(image: UIImage(named: "door.jpg"))
        door.frame.size.width = view.frame.width
        door.frame.size.height = view.frame.height
        view.addSubview(door)
        view.sendSubviewToBack(door)
        
        enter.backgroundColor = UIColor(red: 255.0, green: 215.0, blue: 0, alpha: 1.0)
        enter.layer.borderColor = enter.titleLabel?.textColor.CGColor
        enter.layer.borderWidth = 3.5
        
        let book1 = Book(title: "Clockwork Angel", author: "Cassandra Clare", genre: ["Fantasy", "", ""], readStatus: true, category: "Fiction", pages: 500, favorite: true, favoriteQuote: "")
        let book2 = Book(title: "City of Heavenly Fire", author: "Cassandra Clare", genre: ["Fantasy", "", ""], readStatus: true, category: "Fiction", pages: 700, favorite: true, favoriteQuote: "")
        let book3 = Book(title: "Graclin O'Malley", author: "Anne Moore", genre: ["Historical Fiction", "", ""], readStatus: true, category: "Nonfiction", pages: 200, favorite: true, favoriteQuote: "")
        let book4 = Book(title: "Learning C++ in 21 Days", author: "Tom", genre: ["Computer Science", "", ""], readStatus: false, category: "Nonfiction", pages: 400, favorite: true, favoriteQuote: "")
        bookList.books = [book1, book2, book3, book4]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "enter")
        {
            let newVC = segue.destinationViewController as! BookCollectionViewController
            newVC.allBooks = bookList
        }
    }
    
    
}

