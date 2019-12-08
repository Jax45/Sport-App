
import Foundation

extension FileManager {
    // MARK: Library Directory
    func createDirectoryInUserLibrary(atPath path: String) -> URL? {
        guard let baseCachesUrl = createLibraryDirectoryIfNeeded() else { return nil }
        
        let url = baseCachesUrl.appendingPathComponent(path)
        
        if !fileExists(atUrl: url)  {
            guard let _ = try? createDirectory(at: url, withIntermediateDirectories: true, attributes: nil) else {
                Log.error("Could not create directory at \(url)")
                return nil
            }
        }
        
        return url
    }
    
    func createLibraryDirectoryIfNeeded() -> URL? {
        guard let baseUrl = try? self.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            Log.error("Could not retrieve baseUrl for User's Library directory")
            return nil
        }
        
        if !fileExists(atUrl: baseUrl)  {
            guard let _ = try? createDirectory(at: baseUrl, withIntermediateDirectories: true, attributes: nil) else {
                Log.error("Could not create base directory at \(baseUrl.path)")
                return nil
            }
        }
        
        return baseUrl
    }
    
    // MARK: Directory and file operations
    func createDirectory(atUrl baseUrl: URL, appendingPath path: String) -> URL? {
        let url = baseUrl.appendingPathComponent(path)
        
        if !fileExists(atUrl: url)  {
            guard let _ = try? createDirectory(at: url, withIntermediateDirectories: true, attributes: nil) else {
                Log.error("Could not create directory at \(url.path)")
                return nil
            }
            
            Log.info("Directory created at \(url.path)")
        } else {
            Log.info("Directory already exists at \(url.path)")
        }
        
        return url
    }
    
    func createFile(atUrl baseUrl: URL, withName fileName: String, ofType fileType: String) -> URL? {
        let appendingPathString = "\(fileName).\(fileType)"
        let fileUrl = baseUrl.appendingPathComponent(appendingPathString)
        
        if !fileExists(atUrl: fileUrl)  {
            let success = self.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
            if !success {
                Log.error("Could not create file at \(fileUrl.path)")
                return nil
            }
            Log.info("File created at \(fileUrl.path)")
        } else {
            Log.info("File already exists at \(fileUrl.path)")
        }
        
        return fileUrl
    }
    
    func fileExists(atUrl url: URL) -> (fileExists: Bool, isDirectory: Bool) {
        var isDir : ObjCBool = false
        if fileExists(atPath: url.path, isDirectory:&isDir) {
            if isDir.boolValue {
                return (fileExists: true, isDirectory: true)
            } else {
                return (fileExists: true, isDirectory: false)
            }
        }
        
        return (fileExists: false, isDirectory: false)
    }
    
    func fileExists(atUrl url: URL) -> Bool {
        if fileExists(atPath: url.path) {
            return true
        }
        
        return false
    }
    
    func deleteFile(atUrl fileUrl: URL) -> Bool {
        let (doesExist, isDir) = fileExists(atUrl: fileUrl)
        
        if !doesExist {
            Log.info("File to be deleted at \(fileUrl.path) does not exist")
            return true
        }
        
        if isDir {
            Log.info("File at \(fileUrl.path) is directory and cannot be removed by \(#function)")
            return false
        }
        
        if !isDeletableFile(atPath: fileUrl.path) {
            Log.info("Do not have permissions to delete file at \(fileUrl.path)")
            return false
        }
        
        guard let _ = try? removeItem(at: fileUrl) else {
            Log.info("Could not delete file at \(fileUrl.path)")
            return false
        }
        
        Log.info("Deleted file at \(fileUrl.path)")
        return true
    }
    
    func contentsOfDirectory(atUrl baseUrl: URL, matchingType type: String) -> [URL]? {
        guard let directoryContents = try? contentsOfDirectory(at: baseUrl, includingPropertiesForKeys: nil, options: []) else {
            Log.info("Cannot read contents of directory \(baseUrl.path)")
            return nil
        }
         
        return directoryContents.filter { $0.pathExtension == type }
    }
    
    func save<T: Encodable>(object: T, to baseUrl: URL, withId id: String) -> Bool {
        let url = baseUrl.appendingPathComponent("\(id).json")
        do {
            let data = try JSONEncoder().encode(object)
            let _ = try data.write(to: url, options: .noFileProtection)
            return true
        } catch {
            Log.info("Problem saving json to \(baseUrl.path)")
            return false
        }
    }
    
    func read(withId id: String, at baseUrl: URL) -> Data? {
        let url = baseUrl.appendingPathComponent("\(id).json")
        
        do {
            return try Data(contentsOf: url)
        } catch {
            Log.info("Could not read json at \(baseUrl.path)")
            return nil
        }
    }
}
