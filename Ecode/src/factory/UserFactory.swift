import Foundation

class UserFactory: ObservableObject {
    static let shared = UserFactory()
    @Published var userModel: UserModel = UserModel(username: "", address: AddressModel(host:"0.0.0.0"), list_messages: [])

    init() {}

    func saveModel(_userModel: UserModel) -> Bool {
        userModel = _userModel
        return true
    }
    
    func getModel() -> UserModel {
        return userModel
    }
    
    func saveMessages(_message_model: MessageModel) {
        userModel.list_messages.append(_message_model)
    }
}
