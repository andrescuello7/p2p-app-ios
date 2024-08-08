import Foundation

class MessagesFactory {
    static let shared = MessagesFactory()
    private(set) var messageModels: [MessageModel] = []

    private init() {}

    func saveModel(_messageModel: MessageModel) {
        messageModels.append(_messageModel)
    }
    
    // Función para obtener todos los mensajes
    func getMessages() -> [MessageModel] {
        return messageModels
    }

    // Función para eliminar todos los mensajes
    func clearMessages() {
        messageModels.removeAll()
    }
}
