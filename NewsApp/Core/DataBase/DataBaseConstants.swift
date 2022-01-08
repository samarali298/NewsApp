//
//  DataBaseEnums.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

enum DataBaseTitle: String {
    case newsApp = "NewsApp"
}

enum DataBaseExtension: String {
    case sqlite
    case db
}
enum TableTitle: String {
    case countries = "Country"
    case categories = "Category"
    case articals = "Artical"
}

enum DatabaseConstants: String {
    case insertInto = "INSERT INTO"
    case values = "VALUES"
    case from = "FROM"
    case on = "ON"
    case update = "UPDATE"
    case set = "SET"
    case delete = "DELETE"
}

enum SelectStatmentType: String {
    case select = "SELECT "
    case selectAll = "SELECT *"
}

enum SelectColumnsOperation: String {
    case min = "MIN"
    case max = "MAX"
    case sum = "SUM"
    case count = "COUNT"
    case avg = "AVG"
}

enum SelectConditionCases: String {
    case limitCondition = "LIMIT {n}"
    case whereCondition = "WHERE"
    case orderByCondition = "ORDER BY"
    case groupByCondition = "GROUP BY"
}

enum WhereConditionMultiColumnsCases: String {
    case andCondition = "AND"
    case orCondition = "OR"
}

enum WhereConditionOperations: String {
    case equalOperation = "="
    case greaterThanOperation = ">"
    case lessThanOperation = "<"
    case greaterThanOrEqualOperation = ">="
    case lessThanOrEqualOperation = "<="
    case notEqualOperation = "<>"
    case betweenOperation = "BETWEEN"
    case notBetweenOperation = "NOT BETWEEN"
    case likeOperation = "LIKE"
    case inOperation = "IN"
    case isNull = "IS NULL"
    case isNotNull = "IS NOT NULL"
}

enum LikeWhereValue: String {
    case startsWith = "?%"
    case endsWith = "%?"
    case inAnyPosition = "%?%"
    case startWithAndEndWith = "?%?"
    case startWithOneOfChar = "[?]%" /// WHERE ColumnName LIKE '[abc]%';
    case notStartWithOneOfChar = "![?]%" /// WHERE ColumnName LIKE '[!abc]%';
}

enum JoinCase: String {
    case innerJoin = "INNER JOIN"
    case leftJoin = "LEFT JOIN"
    case rightJoin = "RIGHT JOIN"
}

enum DataBaseType {
    case sqlite
    //TODO
//    case coreData
}

enum AvailableDBDataType: String {
    case string = "String"
    case integer = "Int"
    case double = "Double"
    case float = "Float"
    
}

enum SQLiteDataType: String {
    case text = "TEXT"
    case integer = "INTEGER"
    case real = "REAL"
}
