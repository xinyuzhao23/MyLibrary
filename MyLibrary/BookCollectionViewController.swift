//
//  BookCollectionViewController.swift
//  MyBooks
//
//  Created by Xinyu Zhao on 1/5/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookCollectionViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate {

    var bookList: Library!
    var allBooks = Library(books: [Book(title: "Clockwork Angel", author: "Cassandra Clare", genre: ["Fantasy", "", ""], readStatus: true, category: "Fiction", pages: 500, favorite: true, favoriteQuote: ""), Book(title: "City of Heavenly Fire", author: "Cassandra Clare", genre: ["Fantasy", "", ""], readStatus: true, category: "Fiction", pages: 700, favorite: true, favoriteQuote: ""), Book(title: "Gracelin O'Malley", author: "Anne Moore", genre: ["Historical Fiction", "", ""], readStatus: true, category: "Fiction", pages: 200, favorite: true, favoriteQuote: ""), Book(title: "Teaching Yourself C in 21 Days", author: "Peter Aitken", genre: ["Computer Science", "Technology", ""], readStatus: false, category: "Nonfiction", pages: 400, favorite: true, favoriteQuote: "")])
    var previousCategory: String!
    var currentCategory: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bookcase = UIImageView(image: UIImage(named: "bookcase"))
        bookcase.frame.size.width = view.frame.width
        bookcase.frame.size.height = view.frame.height
        view.addSubview(bookcase)
        view.sendSubviewToBack(bookcase)
        
        navigationController?.title = "All Books"
        self.collectionView!.backgroundColor = UIColor.clearColor()
        
        let add = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "addBook")
        let filter = UIBarButtonItem(title: "Filter", style: .Plain, target: self, action: "filter")
        let all = UIBarButtonItem(title: "All Books", style: .Plain, target: self, action: "showAllBooks")
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        navigationItem.rightBarButtonItems = [add]
        toolbarItems = [filter, space, all]
        navigationController?.setToolbarHidden(false, animated: true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return bookList.books.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("book", forIndexPath: indexPath) as! BookCollectionViewCell
        
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 3.0
        cell.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.8)
        
        cell.titleText.text = bookList.books[indexPath.row].title
        cell.titleText.sizeToFit()
        var fontSize = 25
        while(cell.titleText.frame.width >= cell.frame.width)
        {
            fontSize -= 2
            cell.titleText.font = UIFont(name: (cell.titleText.font?.fontName)!, size: CGFloat(fontSize))
        }
        cell.authorText.text = bookList.books[indexPath.row].author
        cell.pageNumberText.text = String(bookList.books[indexPath.row].pages) + " pages"
        cell.timeText.text = bookList.books[indexPath.row].timeAfterAdd
        cell.pageNumberText.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func addBook()
    {
        let nextView = self.storyboard!.instantiateViewControllerWithIdentifier("BookViewController") as! BookViewController
        nextView.totalBooks = allBooks
        nextView.showedBook = bookList
        navigationController?.pushViewController(nextView, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
            if(segue.identifier == "toBook")
            {
                let newVC = segue.destinationViewController as! BookInfoViewController
                newVC.theBook = bookList.books[indexPath.row]
                newVC.allBooks = allBooks
                newVC.showedBooks = bookList
            }
        }
    }
    
    func showAllBooks()
    {
        bookList.books.removeAll()
        for books in allBooks.books
        {
            bookList.books.append(books)
        }
        collectionView?.reloadData()
    }
    
    func filter()
    {
        let newVC = self.storyboard?.instantiateViewControllerWithIdentifier("popUp") as! FilterViewController
        newVC.allBooks = self.allBooks
        newVC.booksListed = bookList
        presentViewController(newVC, animated: true, completion: nil)
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
