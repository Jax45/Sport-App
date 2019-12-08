import Foundation

// Application Session singleton
class ApplicationSession {
    static let sharedInstance = ApplicationSession()
    
    var persistence: AppPersistenceInterface?
    
    private init() {
        if let appStorageUrl = FileManager.default.createDirectoryInUserLibrary(atPath: "NWAApp"),
            let persistence = AppPersistence(atUrl: appStorageUrl, withDirectoryName: "teams") {
            self.persistence = persistence
        }
    }
}
