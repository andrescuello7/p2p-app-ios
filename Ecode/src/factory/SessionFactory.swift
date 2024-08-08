import Foundation

class SessionFactory {
    static let shared = SessionFactory()
    var socketServer = SocketServer()

    init() {
        socketServer.startServer()
    }

    func saveSession(_userModel: UserModel) -> Bool {
        return socketServer.connectToPeer(
            host: _userModel.address.host,
            port: _userModel.address.port!
        )
    }
    
    func sendMessage(_message_model: MessageModel) {
        socketServer.sendMessageToAllClients(_message: _message_model.message)
    }
}
