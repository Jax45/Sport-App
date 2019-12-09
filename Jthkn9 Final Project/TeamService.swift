import Foundation
import Scaledrone

class TeamService {
  private let scaledrone: Scaledrone
  private let messageCallback: (String)-> Void
  
  private var room: ScaledroneRoom?
  
  init(onRecievedMessage: @escaping (String)-> Void) {
    self.messageCallback = onRecievedMessage
    self.scaledrone = Scaledrone(
        channelID: "Rco1SbwxGcGdkirM", data: nil)
    scaledrone.delegate = self
  }
  
  func connect() {
    scaledrone.connect()
  }
  func disconnect() {
    scaledrone.disconnect()
  }
  func sendMessage(_ message: String) {
    room?.publish(message: message)
  }
}

extension TeamService: ScaledroneDelegate {
    func scaledroneDidConnect(scaledrone: Scaledrone, error: Error?) {
        print("Connected to Scaledrone")
        room = scaledrone.subscribe(roomName: "observable-TeamJson",messageHistory: 1)
        room?.delegate = self
    }
    
    func scaledroneDidReceiveError(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone error", error ?? "")
    }
    
    func scaledroneDidDisconnect(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone disconnected", error ?? "")
    }

}

extension TeamService: ScaledroneRoomDelegate {
  func scaledroneRoomDidConnect(room: ScaledroneRoom, error: Error?) {
    print("Scaledrone connected to room", room.name, error ?? "")
  }

  
  func scaledroneRoomDidReceiveMessage(
    room: ScaledroneRoom,
    message: Any,
    member: ScaledroneMember?) {
    print(room)
    //print(member)
    
    messageCallback(message as! String)
  }
    
}
