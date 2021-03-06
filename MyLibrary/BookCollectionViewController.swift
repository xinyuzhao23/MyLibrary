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

    var allBooks: Library!
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
        navigationItem.rightBarButtonItems = [add]
        toolbarItems = [filter]
        navigationController?.setToolbarHidden(false, animated: true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView?.reloadData()
        })
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
        return allBooks.books.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("book", forIndexPath: indexPath) as! BookCollectionViewCell
        
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 3.0
        cell.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.8)
        
        cell.titleText.text = allBooks.books[indexPath.row].title
        cell.titleText.sizeToFit()
        var fontSize = 25
        while(cell.titleText.frame.width >= cell.frame.width)
        {
            fontSize -= 2
            cell.titleText.font = UIFont(name: (cell.titleText.font?.fontName)!, size: CGFloat(fontSize))
        }
        cell.authorText.text = allBooks.books[indexPath.row].author
        cell.pageNumberText.text = String(allBooks.books[indexPath.row].pages) + " pages"
        cell.timeText.text = allBooks.books[indexPath.row].timeAfterAdd
        cell.pageNumberText.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func addBook()
    {
        let nextView = self.storyboard!.instantiateViewControllerWithIdentifier("BookViewController") as! BookViewController
        nextView.totalBooks = allBooks
        navigationController?.pushViewController(nextView, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
            if(segue.identifier == "toBook")
            {
                let newVC = segue.destinationViewController as! BookInfoViewController
                newVC.theBook = allBooks.books[indexPath.row]
                newVC.allBooks = allBooks
            }
        }
    }
    
    /*func showAllBooks()
    {
        if(bookList.books.count != allBooks.books.count)
        {
            for book in allBooks.books
            {
                if(!bookList.books.contains(book))
                {
                    bookList.books.append(book)
                }
            }
            collectionView?.reloadData()
            print(bookList.books)
        }
    }*/
    
    func filter()
    {
        let newVC = self.storyboard?.instantiateViewControllerWithIdentifier("popUp") as! FilterViewController
        newVC.allBooks = allBooks
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    func reloadData()
    {
        collectionView?.reloadData()
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
