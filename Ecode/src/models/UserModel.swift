import Foundation

struct UserModel {
    var me: AddressModel?
    var username: String
    var address: AddressModel
    var list_messages: [MessageModel]
}
