//
//  FilteredBooksCollectionViewController.swift
//  MyLibrary
//
//  Created by Xinyu Zhao on 1/12/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FilteredBooksCollectionViewController: UICollectionViewController {
    
    var filteredBooks: Library!
    var all: Library!

    override func viewDidLoad() {
        let bookcase = UIImageView(image: UIImage(named: "bookcase"))
        bookcase.frame.size.width = view.frame.width
        bookcase.frame.size.height = view.frame.height
        view.addSubview(bookcase)
        view.sendSubviewToBack(bookcase)
        
        navigationController?.title = "Filtered"
        self.collectionView!.backgroundColor = UIColor.clearColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back to Filter", style: .Plain, target: self, action: "dismiss")
        
        let all = UIBarButtonItem(title: "All Books", style: .Plain, target: self, action: "showAllBooks")
        toolbarItems = [all]
        navigationController?.setToolbarHidden(false, animated: true)
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return filteredBooks.books.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("book", forIndexPath: indexPath) as! BookCollectionViewCell
        
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 3.0
        cell.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.8)
        
        cell.titleText.text = filteredBooks.books[indexPath.row].title
        cell.titleText.sizeToFit()
        var fontSize = 25
        while(cell.titleText.frame.width >= cell.frame.width)
        {
            fontSize -= 2
            cell.titleText.font = UIFont(name: (cell.titleText.font?.fontName)!, size: CGFloat(fontSize))
        }
        cell.authorText.text = filteredBooks.books[indexPath.row].author
        cell.pageNumberText.text = String(filteredBooks.books[indexPath.row].pages) + " pages"
        cell.timeText.text = filteredBooks.books[indexPath.row].timeAfterAdd
        cell.pageNumberText.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {

                let newVC = segue.destinationViewController as! BookInfoViewController
                newVC.theBook = filteredBooks.books[indexPath.row]
                newVC.showedBooks = filteredBooks
                newVC.allBooks = all
            
        }
    }
    
    func dismiss()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func showAllBooks()
    {
        navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
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
