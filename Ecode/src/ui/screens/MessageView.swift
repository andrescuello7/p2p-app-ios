import Foundation
import SwiftUI

struct MessageView: View, Equatable, Hashable {
    @ObservedObject private var userFactory = UserFactory.shared
    @StateObject private var _con = MessageController()
    
    static func == (lhs: MessageView, rhs: MessageView) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine("MessageView")
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Spacer().frame(height: 60)
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(userFactory.userModel.list_messages, id: \.self) { item in
                            HStack {
                                if item.type == TypeMessageEnum.welcome{
                                    Text(item.message)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.1))
                                        .foregroundColor(.white.opacity(0.3))
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                        .frame(maxWidth: 250, alignment: .center)
                                } else if item.type == TypeMessageEnum.message {
                                    MessageBubble(message: item.message, isCurrentUser: false)
                                    Spacer()
                                } else {
                                    Spacer()
                                    MessageBubble(message: item.message, isCurrentUser: true)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                HStack {
                    TextField("", text: $_con.chat)
                        .padding(5)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                    
                    Button(action: {
                        _con.SendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.black)
                            .padding(5)
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(50)
                    }
                }
                .padding()
                .frame(height: 50)
                .background(Color.secondary.opacity(0.1))
            }
            
            VStack {
                Text(_con.userModel.me?.host ?? _con.userModel.address.host)
                    .padding()
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(height: 60)
            .background(Color.secondary.opacity(0.1))
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct MessageBubble: View {
    let message: String
    let isCurrentUser: Bool
    
    var body: some View {
        Text(message)
            .padding(10)
            .background(isCurrentUser ? Color.green.opacity(0.4) : Color.secondary.opacity(0.3))
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(maxWidth: 250, alignment: isCurrentUser ? .trailing : .leading)
            .padding(isCurrentUser ? .leading : .trailing, 50)
    }
}
