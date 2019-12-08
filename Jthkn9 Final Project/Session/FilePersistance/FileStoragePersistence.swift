import Foundation

protocol FileStoragePersistence {
    var directoryUrl: URL { get }
    var fileType: String { get }
}

extension FileStoragePersistence {
    var files: [URL] { return FileManager.default.contentsOfDirectory(atUrl: directoryUrl, matchingType: fileType) ?? [] }

    var names: [String] { return files.map { $0.baseName }}
    
    @discardableResult
    func addFile(withName name: String) -> Bool {
        let url = FileManager.default.createFile(atUrl: directoryUrl, withName: name, ofType: fileType)
        return url != nil
        
        
    }
    //this will delete all the files.
    func removeAllDataInDirectory() {
        for filePath in names {
            print("\(filePath) was deleted.")
            removeFile(withName: filePath)
        }
    }
    
    @discardableResult
    func removeFile(withName name: String) -> Bool {
        let fileUrl = directoryUrl.appendingPathComponent("\(name).\(fileType)")
        return FileManager.default.deleteFile(atUrl: fileUrl)
    }
    
    @discardableResult
    func save<T: Encodable>(object: T, withId id: String) -> Bool {
        return FileManager.default.save(object: object, to: directoryUrl, withId: id)
    }

    func read(fileWithId id: String) -> Data? {
        return FileManager.default.read(withId: id, at: directoryUrl)
    }
}
