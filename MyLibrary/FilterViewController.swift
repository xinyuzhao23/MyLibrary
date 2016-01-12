//
//  FilterViewController.swift
//  MyLibrary
//
//  Created by Xinyu Zhao on 1/6/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit
import CoreData

class FilterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var genre1Text: UITextField!
    
    @IBOutlet weak var genre2Text: UITextField!
    
    @IBOutlet weak var genre3Text: UITextField!
    
    @IBOutlet weak var categoryText: UITextField!
    
    @IBOutlet weak var readText: UITextField!
    
    var genrePicker = UIPickerView()
    var fictionPicker = UIPickerView()
    var nonfictionPicker = UIPickerView()
    var categoryPicker = UIPickerView()
    var statusPicker = UIPickerView()
    var allBooks: Library!
    var booksListed: Library!
    
    var genres = ["Adventure", "Animals", "Art", "Autobiography/Biography", "Classic", "Comedy", "Computer Science", "Cooking", "Crime", "Diary", "Drama", "Essay", "Fairy Tales", "Fantasy", "Graphic Novel", "History", "Horror", "Journal", "Math", "Memoir", "Mystery", "Mythology", "Realistic Fiction", "Religion", "Romance", "Science", "Science Fiction", "Short Story", "Sports", "Technology", "Tragedy", "Travel"]
    var categories = ["Fiction", "Nonfiction"]
    var trueFalse = ["Yes", "No"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genrePicker.dataSource = self
        genrePicker.delegate = self
        genre1Text.inputView = genrePicker
        genre2Text.inputView = genrePicker
        genre3Text.inputView = genrePicker
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        categoryText.inputView = categoryPicker
        
        statusPicker.dataSource = self
        statusPicker.delegate = self
        readText.inputView = statusPicker
        
        genrePicker.tag = 0
        categoryPicker.tag = 1
        statusPicker.tag = 2
        
        let bar = UIToolbar()
        bar.translucent = true
        bar.sizeToFit()
        
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        
        let finish = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "finish")
        let label = UILabel()
        label.text = "Select a genre."
        label.textColor = UIColor.blackColor()
        label.sizeToFit()
        let message = UIBarButtonItem(customView: label)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancel")
        
        bar.setItems([cancelButton, space, message, space, finish], animated: false)
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "finish")
        let aLabel = UILabel()
        aLabel.text = "Select a category."
        aLabel.textColor = UIColor.blackColor()
        aLabel.sizeToFit()
        let aMessage = UIBarButtonItem(customView: aLabel)
        let cancel = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancel")
        
        let tools = UIToolbar()
        tools.translucent = true
        tools.sizeToFit()
        tools.setItems([cancel, space, aMessage, space, doneButton], animated: false)
        
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "finish")
        let readLabel = UILabel()
        readLabel.text = "Have you read this book before?"
        readLabel.textColor = UIColor.blackColor()
        readLabel.sizeToFit()
        let readMessage = UIBarButtonItem(customView: readLabel)
        let end = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancel")
        
        let toolBar = UIToolbar()
        toolBar.translucent = true
        toolBar.sizeToFit()
        toolBar.setItems([end, space, readMessage, space, done], animated: false)
        
        genre1Text.inputAccessoryView = bar
        genre2Text.inputAccessoryView = bar
        genre3Text.inputAccessoryView = bar
        categoryText.inputAccessoryView = tools
        readText.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func cancel()
    {
        self.view.endEditing(true)
    }
    
    func finish()
    {
        var row = genrePicker.selectedRowInComponent(0)
        if(genre1Text.isFirstResponder())
        {
            genre1Text.text = genres[row]
        }
        else if(genre2Text.isFirstResponder())
        {
            genre2Text.text = genres[row]
        }
        else if(genre3Text.isFirstResponder())
        {
            genre3Text.text = genres[row]
        }
        else if(categoryText.isFirstResponder())
        {
            row = categoryPicker.selectedRowInComponent(0)
            categoryText.text = categories[row]
        }
        else if(readText.isFirstResponder())
        {
            row = statusPicker.selectedRowInComponent(0)
            readText.text = trueFalse[row]
        }
        
        self.view.endEditing(true)
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 0){
            return genres.count
        }
        else if(pickerView.tag == 1) {
            return categories.count
        }
        else if(pickerView.tag == 2){
            return trueFalse.count
        }
        return 0
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 0){
            return genres[row]
        }
        else if(pickerView.tag == 1) {
            return categories[row]
        }
        else if(pickerView.tag == 2){
            return trueFalse[row]
        }
        return ""
    }
    
    func trueOrFalse(answer: String) -> Bool
    {
        if(answer == "Yes"){
            return true
        }
        else{
            return false
        }
    }
    
    func sortBooks() -> [Book]
    {
        var sortedBooks = [Book]()
        for aBook in allBooks.books
        {
            if((aBook.genre.contains(genre1Text.text!) || genre1Text.text! == "All") && (aBook.genre.contains(genre2Text.text!) || genre2Text.text! == "All") && (aBook.genre.contains(genre3Text.text!) || genre3Text.text == "All") && (aBook.category == categoryText.text! || categoryText.text! == "Any") && (aBook.readStatus == trueOrFalse(readText.text!) || readText.text! == "Any")){
                sortedBooks.append(aBook)
            }
        }
        return sortedBooks
    }
    
    @IBAction func filterAction(sender: UIButton) {
        booksListed = Library(books: sortBooks())
        let newVC = storyboard?.instantiateViewControllerWithIdentifier("FilteredBooks") as! FilteredBooksCollectionViewController
        newVC.filteredBooks = booksListed
        newVC.all = allBooks
        navigationController?.pushViewController(newVC, animated: true)
    }

}
