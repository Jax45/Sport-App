import Foundation
import Scaledrone

class ChatService {
  private let scaledrone: Scaledrone
  private let messageCallback: (Message)-> Void
  
  private var room: ScaledroneRoom?
  
  init(member: Member, onRecievedMessage: @escaping (Message)-> Void) {
    let defaults = UserDefaults.standard
    
    self.messageCallback = onRecievedMessage
    
    
    if let auth = defaults.object(forKey: "Auth") as? Int {
        if auth == 1 || auth == 2{
            //Auth full
            self.scaledrone = Scaledrone(
              channelID: "Paak7Nu9EAqSdL89",
              data: member.toJSON)
            
        }
        else{
            self.scaledrone = Scaledrone(
              channelID: "drfKnVvI6vxzNlRC",
              data: member.toJSON)
        }
    }
    else{
        self.scaledrone = Scaledrone(
        channelID: "drfKnVvI6vxzNlRC",
        data: member.toJSON)
    }
    scaledrone.delegate = self
  }
  
  func connect() {
    scaledrone.connect()
  }
  func sendMessage(_ message: String) {
    room?.publish(message: message)
  }
}

extension ChatService: ScaledroneDelegate {
    func scaledroneDidConnect(scaledrone: Scaledrone, error: Error?) {
        print("Connected to Scaledrone")
        room = scaledrone.subscribe(roomName: "observable-GroupChat",messageHistory: 100)
        room?.delegate = self
    }
    
    func scaledroneDidReceiveError(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone error", error ?? "")
    }
    
    func scaledroneDidDisconnect(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone disconnected", error ?? "")
    }

}

extension ChatService: ScaledroneRoomDelegate {
  func scaledroneRoomDidConnect(room: ScaledroneRoom, error: Error?) {
    print("Scaledrone connected to room", room.name, error ?? "")
  }
  
  func scaledroneRoomDidReceiveMessage(
    room: ScaledroneRoom,
    message: Any,
    member: ScaledroneMember?) {
    print(room)
    //print(member)
    let stringMessage = message as! String
    print(stringMessage)
    let decoder = JSONDecoder()
    guard
        
        let jsonData = stringMessage.data(using: .utf8),
        
        let msg = try? decoder.decode(JsonMessage.self, from: jsonData)
        
//        let data = message as? [String: Any],
//        let text = data["message"] as? String,
      //let memberData = member?.clientData,
      //let member = Member(fromJSON: message)
    else {
      print("Could not parse data.")
      return
    }
    
    let message = Message(
        member: Member(name: msg.name, color: UIColor(hex: msg.color)),
      text: msg.message,
      messageId: UUID().uuidString)
    messageCallback(message)
  }
    
}
