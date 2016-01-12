//
//  Library.swift
//  MyLibrary
//
//  Created by Xinyu Zhao on 1/6/16.
//  Copyright © 2016 Xinyu Zhao. All rights reserved.
//

import UIKit

class Library: NSObject {
    
    var books: [Book]
    
    init(books: [Book])
    {
        self.books = books
    }
    
}
