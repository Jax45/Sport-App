//
//  MessageViewController.swift
//  Jthkn9's Final Project
//
//  Created by user159466 on 12/6/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit
import MessageKit
class MessageViewController: MessagesViewController  {
    var chatService: ChatService!
    var messages: [Message] = []
    var member: Member!
    
    static func instanceOfParent() -> UINavigationController {
        let navigationController = UINavigationController.with(storyboardName: "Message")
        //let viewController = navigationController.rootViewController(asType: MessageViewController.self)
        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chatService = ChatService(member: member, onRecievedMessage: {
          [weak self] message in
          self?.messages.append(message)
          self?.messagesCollectionView.reloadData()
          self?.messagesCollectionView.scrollToBottom(animated: true)
        })

        chatService.connect()
        //member = Member(name: .randomName, color: .random)
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        // Do any additional setup after loading the view.
    }
    func setupProfile(member: Member){
        self.member = member
    }
    

}

extension MessageViewController: MessagesDataSource {
    
  func numberOfSections(
    in messagesCollectionView: MessagesCollectionView) -> Int {
    return messages.count
  }
  
  func currentSender() -> SenderType {
    return Sender(senderId: member.name, displayName: member.name)
  }
  
  func messageForItem(
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> MessageType {
    
    return messages[indexPath.section]
  }
  
  func messageTopLabelHeight(
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CGFloat {
    
    return 12
  }
  
  func messageTopLabelAttributedText(
    for message: MessageType,
    at indexPath: IndexPath) -> NSAttributedString? {
    
    return NSAttributedString(
      string: message.sender.displayName,
      attributes: [.font: UIFont.systemFont(ofSize: 12)])
  }
}

extension MessageViewController: MessagesLayoutDelegate {
  func heightForLocation(message: MessageType,
    at indexPath: IndexPath,
    with maxWidth: CGFloat,
    in messagesCollectionView: MessagesCollectionView) -> CGFloat {
    
    return 0
  }
}
extension MessageViewController: MessagesDisplayDelegate {
  func configureAvatarView(
    _ avatarView: AvatarView,
    for message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) {
    
    let message = messages[indexPath.section]
    let color = message.member.color
    avatarView.backgroundColor = color
  }
}
extension MessageViewController: MessageInputBarDelegate {
    func inputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String){
        var message = ""
        let lines = text.split{$0.isNewline}
        for line in lines{
            message += "\(line)\\n"
        }
        let jsonString: String = """
        {
            "message": "\(message)",
            "name": "\(member.name)",
            "color": "\(member.color.hexString)"
        }
        """
        chatService.sendMessage(jsonString)
        inputBar.inputTextView.text = ""
  }
}
