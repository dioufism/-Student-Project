//
//  DBManager.swift
//  StudentContactProject
//
//  Created by ousmane diouf on 11/8/20.
//

import Foundation
import SQLite3

enum SqliteError: Error {
    case invalidDirectoryUrl
    case invalidBundleUrl
    case copyFailed
    case openingDbError
    case prepareFailed
    case tableCreationError
    case insertFailed
    case deleteFailed
}

protocol DatabaseProvider {
    var dbPath: String {get}
    var dbName: String {get}
    var dbPointer: OpaquePointer? {get}
}

class DBManager: DatabaseProvider {
    var dbName: String
    var dbPath: String = ""
    var dbPointer: OpaquePointer?
    
    required init(dbName: String = "StudentContact.db") {
        self.dbName = dbName
    }
    
    deinit {
        sqlite3_close(self.dbPointer)
    }
    
    private func createDbIfNeeded() throws {
        
        func copyOfDb(at destinationPath: String) throws {
            guard let bundlePath = Bundle.main.resourceURL?.appendingPathComponent(self.dbName) else {
                throw SqliteError.invalidBundleUrl
            }
            if FileManager.default.fileExists(atPath: destinationPath) {
                print("file Exist")
            } else if FileManager.default.fileExists(atPath: bundlePath.path) {
                print("database isn't present in the bundle ")
                do {
                    try FileManager.default.copyItem(atPath: bundlePath.path, toPath: destinationPath)
                } catch {
                    throw SqliteError.copyFailed
                }
            }
        }
        
        do {
            guard let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                        throw SqliteError.invalidDirectoryUrl
                    }
                    self.dbPath = docDirectory.appendingPathComponent(self.dbName).path
                    try copyOfDb(at: self.dbPath)
                } catch let error as SqliteError {
                    throw error
                }
            }
    private func openDbConnection() throws -> OpaquePointer? {
        var opaquePointer: OpaquePointer?
        if sqlite3_open(self.dbPath, &opaquePointer) == SQLITE_OK {
            //open the database
            return opaquePointer
        } else {
            // db openning failed
            throw SqliteError.openingDbError
        }
    }
    func closeDbConnection() {
            sqlite3_close(self.dbPointer)
        }
    func startDatabase() {
            try? self.createDbIfNeeded()
            self.dbPointer = try? self.openDbConnection()
        }
    func preparedb(query: String) throws -> OpaquePointer? {
            var localPointer: OpaquePointer?
            if sqlite3_prepare_v2(self.dbPointer, query, -1, &localPointer, nil) == SQLITE_OK {
                print("prepare success")
                return localPointer
            } else {
                print("prepare failed")
                throw SqliteError.prepareFailed
            }
        }
    func finalizeStatement(dbHandler: OpaquePointer?) {
            sqlite3_finalize(dbHandler)
        }
        
        func executeStatement(dbHandler: OpaquePointer?) throws {
            defer {
                sqlite3_finalize(dbHandler)
            }
            guard  sqlite3_step(dbHandler) == SQLITE_DONE else {
                throw SqliteError.tableCreationError
            }
            print("Statement executed successfully")
        }
}

