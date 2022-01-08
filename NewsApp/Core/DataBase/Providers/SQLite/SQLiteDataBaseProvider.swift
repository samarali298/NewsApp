//
//  SQLiteDataBaseProvider.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//
import Foundation

class SQLiteDataBaseProvider: DataBaseProvider {
    
    private static var sharedInstance: SQLiteDataBaseProvider?
    
    private var database: OpaquePointer?
    private var serialDatabaseQueue: DispatchQueue
    
    // MARK: - Methods
    static func shared(databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?) -> SQLiteDataBaseProvider {
        guard let returnedSharedInstance = sharedInstance else {
            sharedInstance = SQLiteDataBaseProvider(databaseName: databaseName, extention: extention, foldersName: foldersName)
            return sharedInstance!
        }
        return returnedSharedInstance
    }
    
    public init(databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?) {
        
        let foldersPath = FilesUtility().getFullFoldersPath(foldersName: foldersName)
        if foldersName != nil {
            guard FileManagerProvider().createDirectory(foldersPath: foldersPath!)! else {
                fatalError("Can't Create Given Directory \(foldersPath!)")
            }
        }
        let fullFilePath = FilesUtility().getFullFilePath(fileName: databaseName.rawValue, extention: extention.rawValue, foldersPath: foldersPath)
        let path = FileManager().documentDirectoryPath().appendingPathComponent(fullFilePath)
        let fullDestPath = path.path
        print("samar fullDestPath \(fullDestPath)")
        
        if FileManagerProvider().checkIsFileExist(filePath: fullDestPath) {
            if sqlite3_open(fullDestPath, &database) != SQLITE_OK {
                fatalError("Failed to open database.")
            }
        } else {
            if sqlite3_open_v2(fullDestPath, &database, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE, nil) != SQLITE_OK {
                fatalError("Failed to create database.")
            }
            
        }
        serialDatabaseQueue = DispatchQueue(label: "dbSqlite")
    }
    
    deinit {
        sqlite3_close(database)
        
    }
    
    func createDataBase(_ databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?, completion: @escaping (Bool) -> Void) {
        fatalError("\(databaseName) already created in initializer")
    }
    func createTable(_ createTableQuery: CreateTableQueryInterface, completion: @escaping (Bool) -> Void) {
        serialDatabaseQueue.async { [self] in
            let createTableString = SQLiteQueryParser.parseCreateTable(createTableQuery)
            var createTableStatement: OpaquePointer?
            if sqlite3_prepare_v2(database, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
                if sqlite3_step(createTableStatement) == SQLITE_DONE {
                    completion(true)
                } else {
                    let errmsg = String(cString: sqlite3_errmsg(database))
                    fatalError("can't create table with error \(errmsg))")
                    
                }
            } else {
                let errmsg = String(cString: sqlite3_errmsg(database))
                fatalError("can't create table with error \(errmsg))")
            }
            sqlite3_finalize(createTableStatement)
        }

    }
    
    func insertInto(_ insertQuery: InsertQueryInterface, completion: @escaping (Bool) -> Void) {
        serialDatabaseQueue.async { [self] in
            
            let insertIntoTableString = SQLiteQueryParser.parseInsertIntoTable(insertQuery)
            var insertStatement: OpaquePointer?
            
            if sqlite3_prepare_v2(database, insertIntoTableString, -1, &insertStatement, nil) ==
                SQLITE_OK {
                
                var columnIndex = 1
                for column in insertQuery.columns {
                    switch column.value.self {
                    case is String:
                        sqlite3_bind_text(insertStatement, Int32(columnIndex), (column.value as AnyObject).utf8String, -1, nil)
                    case is Int:
                        let value = (column.value as? Int)!
                        sqlite3_bind_int(insertStatement, Int32(columnIndex), Int32(value))
                    case is Double, is Float:
                        sqlite3_bind_double(insertStatement, Int32(columnIndex), (column.value as? Double)!)
                    case is Date:
                        sqlite3_bind_double(insertStatement, Int32(columnIndex), (column.value as? Date)!.timeIntervalSinceReferenceDate)
                    case is Bool:
                        let bytes: Int32 = (column.value as? Bool)! ? 1 : 0
                        sqlite3_bind_int(insertStatement, Int32(columnIndex), (bytes))
                    default:
                        sqlite3_bind_null(insertStatement, Int32(columnIndex))
                    }

                    columnIndex += 1
                }
                if sqlite3_step(insertStatement) != SQLITE_DONE {
                    let errmsg = String(cString: sqlite3_errmsg(database))
                    fatalError("can't insert into table with error \(errmsg))")
                }
            } else {
                let errmsg = String(cString: sqlite3_errmsg(database))
                fatalError("can't insert into table with error \(errmsg))")
            }
            sqlite3_finalize(insertStatement)
            completion(true)
        }
    }
    
    func update(_ updateQuery: UpdateQueryInterface, completion: @escaping (Bool) -> Void) {
        serialDatabaseQueue.async { [self] in

            let updateStatementString = SQLiteQueryParser.parseUpdateStatment(updateQuery)
            var updateStatement: OpaquePointer?
            
              if sqlite3_prepare_v2(database, updateStatementString, -1, &updateStatement, nil) ==
                  SQLITE_OK {
                if sqlite3_step(updateStatement) != SQLITE_DONE {
                    let errmsg = String(cString: sqlite3_errmsg(database))
                    fatalError("can't Update table with error \(errmsg))")
                }
              } else {
                let errmsg = String(cString: sqlite3_errmsg(database))
                fatalError("can't Update table with error \(errmsg))")
              }
              sqlite3_finalize(updateStatement)
            completion(true)
        }

    }
    
    func delete(_ deleteQuery: DeleteQueryInterface, completion: @escaping (Bool) -> Void) {
        serialDatabaseQueue.async { [self] in

            let deleteStatementString = SQLiteQueryParser.parseDeleteStatment(deleteQuery)
            var deleteStatement: OpaquePointer?
            
              if sqlite3_prepare_v2(database, deleteStatementString, -1, &deleteStatement, nil) ==
                  SQLITE_OK {
                if sqlite3_step(deleteStatement) != SQLITE_DONE {
                    let errmsg = String(cString: sqlite3_errmsg(database))
                    fatalError("can't Delete from table with error \(errmsg))")
                }
              } else {
                let errmsg = String(cString: sqlite3_errmsg(database))
                fatalError("can't Delete from table with error \(errmsg))")
              }
              sqlite3_finalize(deleteStatement)
            completion(true)
        }
    }
    
    func selectFrom<T: Codable>(_ selectQuery: SelectQueryInterface, mapToModel valueModel: T.Type, completion: @escaping ([T]?) -> Void) {
        serialDatabaseQueue.async { [self] in
            let selectStatmentStr = SQLiteQueryParser.parseSelectStatment(selectQuery)
            
            var selectStatement: OpaquePointer?
            if sqlite3_prepare_v2(database, selectStatmentStr, -1, &selectStatement, nil) == SQLITE_OK {
                
                var selectedItem = Dictionary<String, Any?>()
                var key = ""
                var value: Any?
                var selectedModels: [T] = []
                
                while sqlite3_step(selectStatement) == SQLITE_ROW {
                    let columns = sqlite3_column_count(selectStatement)
                    for index in 0..<columns {
                        let name = sqlite3_column_name(selectStatement, index)
                        key = String(utf8String: name!)!
                        
                        switch sqlite3_column_type(selectStatement, index) {
                        case SQLITE_INTEGER:
                            let intValue = sqlite3_column_int(selectStatement, index)
                            value = Int(intValue)
                        case SQLITE_FLOAT:
                            let doubleValue = sqlite3_column_double(selectStatement, index)
                            value = Float(doubleValue)
                        case SQLITE_TEXT:
                            let text = sqlite3_column_text(selectStatement, index)
                            value = String(cString: text!)
                        case SQLITE_NULL:
                            value = nil
                        default:
                            break
                        }
                        selectedItem.updateValue(value, forKey: key)
                    }
                    selectedModels.append(DataBaseUtility.convertDicToObject(dic: selectedItem, mapToModel: valueModel))
                }
                completion(selectedModels)
            } else {
                let errmsg = String(cString: sqlite3_errmsg(database))
                fatalError("can't select From table with error \(errmsg)")
            }
            sqlite3_finalize(selectStatement)
        }
    }

    func removeDataBase(_ databaseName: DataBaseTitle, extention: DataBaseExtension, foldersName: [String]?, completion: @escaping (Bool) -> Void) {
        
        let result = FileManagerProvider().removeFile(fileName: databaseName.rawValue, extention: extention.rawValue, foldersName: foldersName)
            completion(result)
    }
}

class FileManagerProvider {
    func createDirectory(foldersPath: String) -> Bool? {
        let path = FileManager().documentDirectoryPath().appendingPathComponent(foldersPath)
        if !FileManager.default.fileExists(atPath: path.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch {
                return false
            }
        }
        return true
    }
    
    func checkIsFileExist(filePath: String) -> Bool {
        FileManager().fileExists(atPath: filePath)
    }
    
    func removeFile(fileName: String, extention: String, foldersName: [String]?) -> Bool {
        let foldersPath = FilesUtility().getFullFoldersPath(foldersName: foldersName)
        let fullFilePath = FilesUtility().getFullFilePath(fileName: fileName, extention: extention, foldersPath: foldersPath)
        let path = FileManager().documentDirectoryPath().appendingPathComponent(fullFilePath)
        do {
            try FileManager.default.removeItem(at: path)
            return true
        } catch {
            return false
        }
    }
}



extension FileManager {
    func documentDirectoryPath() -> URL {
        return self.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
