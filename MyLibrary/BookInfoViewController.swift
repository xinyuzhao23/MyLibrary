//
//  BookInfoViewController.swift
//  MyBooks
//
//  Created by Xinyu Zhao on 1/6/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController {

    var theBook: Book!
    var allBooks: Library!
    var showedBooks: Library!

    @IBOutlet weak var bookTitle: UILabel!

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genres: UITextView!
    @IBOutlet weak var categoryView: UITextView!
    @IBOutlet weak var starSymbol: UIImageView!
    @IBOutlet weak var readCheckBox: UIImageView!
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var quoteText: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let page = UIImageView(image: UIImage(named: "newPage"))
        page.frame.size.width = view.frame.width
        page.frame.size.height = view.frame.height
        view.addSubview(page)
        view.sendSubviewToBack(page)
        
        categoryView.backgroundColor = UIColor.clearColor()
        genres.backgroundColor = UIColor.clearColor()
        quoteText.backgroundColor = UIColor.clearColor()
        
        if(theBook.favorite == true)
        {
            starSymbol.hidden = false
        }
        else
        {
            starSymbol.hidden = true
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editBook")
        
        bookTitle.text = theBook.title
        bookTitle.sizeToFit()
        bookTitle.textAlignment = .Center
        
        var fontSize: CGFloat = 43.0
        while(bookTitle.frame.width > view.frame.width - (starSymbol.frame.width * 2)){
            bookTitle.font = UIFont(name: (bookTitle.font?.fontName)!, size: --fontSize)
            bookTitle.sizeToFit()
        }
        
        if(theBook.author != ""){
            authorLabel.text = "By: \(theBook.author)"
            authorLabel.sizeToFit()
            authorLabel.textAlignment = .Center
        }
        
        genres.text = ""
        var i: Int
        for i = 0; i < theBook.genre.count; i++
        {
            if(theBook.genre[i] != "")
            {
                genres.text = genres.text! + "\(theBook.genre[i])    "
            }
        }
        
        genres.sizeToFit()
        genres.textAlignment = .Center
        genres.textColor = UIColor.grayColor()
        
        if(theBook.category != ""){
            categoryView.text = theBook.category
            categoryView.textAlignment = .Center
            categoryView.sizeToFit()
            categoryView.textColor = UIColor.grayColor()
        }
        
        if(theBook.pages != 0){
            pageLabel.text = String(theBook.pages) + " pages"
            pageLabel.textColor = UIColor.grayColor()
            pageLabel.textAlignment = .Center
            pageLabel.sizeToFit()
        }
        else{
            pageLabel.text = ""
        }
        
        if(theBook.readStatus == true){
            readCheckBox.image = UIImage(named: "checked")
        }
        else{
            readCheckBox.image = UIImage(named: "unchecked")
        }
        
        quoteText.text = theBook.favoriteQuote
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func editBook()
    {
        let editVC = storyboard?.instantiateViewControllerWithIdentifier("Edit") as! EditViewController
        editVC.book = theBook
        navigationController?.pushViewController(editVC, animated: true)
    }

    @IBAction func deleteBook(sender: UIButton) {
        let index = allBooks.books.indexOf(theBook)
        allBooks.books.removeAtIndex(index!)
        if(showedBooks != nil)
        {
            let ind = showedBooks.books.indexOf(theBook)
            showedBooks.books.removeAtIndex(ind!)
        }
        navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
