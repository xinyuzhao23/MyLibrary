//
//  EditViewController.swift
//  MyLibrary
//
//  Created by Xinyu Zhao on 1/8/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var genrePicker = UIPickerView()
    var categoryPicker = UIPickerView()
    var statusPicker = UIPickerView()
    var genres = ["Adventure", "Animals", "Art", "Autobiography/Biography", "Classic", "Comedy", "Computer Science", "Cooking", "Crime", "Diary", "Drama", "Essay", "Fairy Tales", "Fantasy", "Graphic Novel", "History", "Horror", "Journal", "Math", "Memoir", "Mystery", "Mythology", "Realistic Fiction", "Religion", "Romance", "Science", "Science Fiction", "Short Story", "Sports", "Technology", "Tragedy", "Travel"]
    var categories = ["Fiction", "Nonfiction"]
    var trueFalse = ["Yes", "No"]
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var pageText: UITextField!
    @IBOutlet weak var categoryText: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var readText: UITextField!
    
    @IBOutlet weak var genre3Text: UITextField!
    @IBOutlet weak var genre2Text: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var favQuoteText: UITextField!
    @IBOutlet weak var checkBox: UIButton!
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paper = UIImageView(image: UIImage(named: "paper"))
        paper.frame.size.width = view.frame.width
        paper.frame.size.height = view.frame.height
        view.addSubview(paper)
        view.sendSubviewToBack(paper)
        titleText.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        authorText.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        genreTextField.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        genre2Text.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        genre3Text.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        categoryText.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        pageText.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        readText.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        favQuoteText.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        
        titleText.text = book.title
        authorText.text = book.author
        genreTextField.text = book.genre[0]
        genre2Text.text = book.genre[1]
        genre3Text.text = book.genre[2]
        categoryText.text = book.category
        pageText.text = String(book.pages)
        
        if(book.readStatus == true){
            readText.text = "Yes"
        }
        else{
            readText.text = "No"
        }
        
        if(book.favorite == true){
            checkBox.setImage(UIImage(named: "checked"), forState: .Normal)
        }
        else{
            checkBox.setImage(UIImage(named: "unchecked"), forState: .Normal)
        }
        favQuoteText.text = book.favoriteQuote
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "dismiss")
        
        genrePicker.dataSource = self
        genrePicker.delegate = self
        self.genreTextField.inputView = genrePicker
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
        
        genreTextField.inputAccessoryView = bar
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
        if(genreTextField.isFirstResponder())
        {
            genreTextField.text = genres[row]
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

    @IBAction func empty(sender: UITextField) {
        if(sender.text == "")
        {
            saveButton.enabled = false
        }
        else{
            saveButton.enabled = true
        }
    }
    
    @IBAction func save(sender: UIButton) {
        book.title = titleText.text
        book.author = authorText.text
        
        book.genre.removeAll()
        book.genre.append(genreTextField.text!)
        book.genre.append(genre2Text.text!)
        book.genre.append(genre3Text.text!)
        book.category = categoryText.text
        
        if(Int(pageText.text!) != nil){
            book.pages = Int(pageText.text!)
        }
        else{
            book.pages = 0
        }
        book.readStatus = trueOrFalse(readText.text!)
        
        var fav = false
        if((checkBox.imageView!.image == UIImage(named: "unchecked")))
        {
            fav = false
        }
        else if((checkBox.imageView!.image == UIImage(named: "checked")))
        {
            fav = true
        }
        book.favorite = fav
        book.favoriteQuote = favQuoteText.text
        navigationController?.popViewControllerAnimated(true)
    }
    
    func trueOrFalse(answer: String) -> Bool
    {
        if(answer == "Yes"){
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func check(sender: UIButton) {
        if((sender.imageView!.image == UIImage(named: "unchecked.png")))
        {
            checkBox.setImage(UIImage(named: "checked.png"), forState: UIControlState.Normal)
        }
        else if((sender.imageView!.image == UIImage(named: "checked.png")))
        {
            checkBox.setImage(UIImage(named: "unchecked.png"), forState: UIControlState.Normal)
        }
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
