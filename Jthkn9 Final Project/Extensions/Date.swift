import Foundation

extension Date {
    func toString(format: DateFormatOption, timeZone: TimeZone = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}
