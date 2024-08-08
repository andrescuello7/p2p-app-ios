import Foundation

class MessageController: ObservableObject {
    private var userFactory: UserFactory
    private var sessionFactory: SessionFactory
    let userModel: UserModel
    
    @Published public var chat: String
    
    init() {
        self.chat = ""
        self.userFactory = UserFactory.shared
        self.sessionFactory = SessionFactory.shared
        self.userModel = userFactory.getModel()
    }
    
    func SendMessage() {
        if !chat.isEmpty {
            let message_model = MessageModel(
                username: userModel.username,
                message: chat,
                type: TypeMessageEnum.me_message
            )
        userFactory.saveMessages(_message_model: message_model)
        sessionFactory.sendMessage(_message_model: message_model)
        chat = ""
        }
    }
}
