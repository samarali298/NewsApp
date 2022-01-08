//
//  FilesUtility.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//


import Foundation

class FilesUtility {
    /**
     Retrieves Full Folders Path.
     - Parameters:
       - foldersName: folders Name for file if needed.
     - returns: Concatenated String for Full Folders Path
     */
    func getFullFoldersPath(foldersName: [String]?) -> String? {
        guard let foldersArray = foldersName else { return nil }
        return foldersArray.joined(separator: "/")
        
    }
    
    /**
     Retrieves Full Path.
     - Parameters:
       - fileName: name for file.
       - extention: extention for file .
       - foldersPath: folder Name for file if needed.
     - returns: Concatenated String for Full Path
     */
    func getFullFilePath(fileName: String, extention: String, foldersPath: String?) -> String {
        
        if foldersPath != nil {
            return foldersPath! + "/" + fileName + "." + extention
        } else {
            return fileName + "." + extention
        }
    }
    
}
