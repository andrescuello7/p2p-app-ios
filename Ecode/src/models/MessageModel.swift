import Foundation

struct MessageModel: Identifiable, Hashable {
    var id = UUID()
    var username: String
    var message: String
    var type: TypeMessageEnum
}
