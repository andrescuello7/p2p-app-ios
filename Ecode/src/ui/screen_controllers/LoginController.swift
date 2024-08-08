import Foundation
import SwiftUI

class LoginController: ObservableObject {
    public var userFactory: UserFactory
    private var sessionFactory: SessionFactory
    @Published var hostEnable: Bool
    @Published var username: String
    @Published var host: String

    init(username: String = "", host: String = "") {
        self.userFactory = UserFactory.shared
        self.sessionFactory = SessionFactory.shared
        self.hostEnable = false
        self.username = "Anonymous"
        self.host = host
    }
    
    func HostEnable() {
        hostEnable.toggle()
    }
    
    func Login() -> Bool {
        if !host.isEmpty && !username.isEmpty {
            let user_model: UserModel = UserModel(
                username: username,
                address: AddressModel(host: host),
                list_messages: []
            )
            let saveSession: Bool = sessionFactory.saveSession(_userModel: user_model)
            if saveSession {
                let saveUser: Bool = userFactory.saveModel(_userModel: user_model)
                return saveUser
            }
        }
        return false
    }
    
    func Genesis() -> Bool {
        let host: String = "0.0.0.0"
        let userModel: UserModel = UserModel(
            username: username != "" ? username : host,
            address: AddressModel(host: host),
            list_messages: []
        )
        return userFactory.saveModel(_userModel: userModel)
    }
}
