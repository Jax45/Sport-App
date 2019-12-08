import Foundation
import UIKit
import MessageKit

struct Member {
  let name: String
  let color: UIColor
}
struct JsonMessage: Codable{
    let message: String
    let color: String
    let name: String
}

struct Message {
  let member: Member
  let text: String
  let messageId: String
}
extension Message: MessageType {
    
  var sender: SenderType {
    return Sender(senderId: member.name, displayName: member.name)
  }
  
  var sentDate: Date {
    return Date()
  }
  
  var kind: MessageKind {
    return .text(text)
  }
}

extension Member {
  var toJSON: Any {
    return [
      "name": name,
      "color": color.hexString
    ]
  }
  
  init?(fromJSON json: String) {
    let jsonData = json.data(using: .utf8)!
    let decoder = JSONDecoder()
    guard
        let msg = try? decoder.decode(JsonMessage.self, from: jsonData)
        //let name = msg.name,
        //let hexColor = msg.color
    else {
      print("Couldn't parse Member")
      return nil
    }
    
    self.name = msg.name
    self.color = UIColor(hex: msg.color)
  }
}
