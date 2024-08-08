import Foundation
import SwiftUI
import Network

class SocketServer {
    private var userFactory: UserFactory
    private var listener: NWListener?
    private var connections: [NWConnection] = []
    
    init() {
        self.userFactory = UserFactory.shared
    }
    
    func startServer() {
        do {
            let port: NWEndpoint.Port = 4000
            let parameters = NWParameters.tcp
            listener = try NWListener(using: parameters, on: port)
            
            if let host: String = getWiFiAddress() {
                listener?.stateUpdateHandler = { state in
                    switch state {
                    case .ready:
                        self.userFactory.userModel.me = AddressModel(host: host)
                        print("Server listen in \(host):\(port)")
                    case .failed(let error):
                        print("Server failed with error: \(error)")
                    default:
                        break
                    }
                }
            }

            listener?.newConnectionHandler = { newConnection in
                print("New connection from \(String(describing: newConnection.endpoint))")
                self.userFactory.saveMessages(_message_model: MessageModel(
                    username: "",
                    message: "new user connected",
                    type: TypeMessageEnum.welcome
                ))
                self.handleNewConnection(connection: newConnection)
            }
            
            listener?.start(queue: .main)
        } catch {
            print("Failed to start server: \(error)")
        }
    }
    
    func connectToPeer(host: String, port: UInt16) -> Bool {
        let parameters = NWParameters.tcp
        let endpoint = NWEndpoint.hostPort(host: NWEndpoint.Host(host), port: NWEndpoint.Port(integerLiteral: port))
        let connection = NWConnection(to: endpoint, using: parameters)
        
        connection.stateUpdateHandler = { state in
            switch state {
                case .ready:
                    print("Connected to \(host):\(port)")
                    self.connections.append(connection)
                    self.receiveData(from: connection)
                case .failed(let error):
                    print("Failed to connect to \(host):\(port), error: \(error)")
                default:
                    break
            }
        }
        connection.start(queue: .main)
        return true
    }

    private func handleNewConnection(connection: NWConnection) {
        connections.append(connection)
        connection.start(queue: .main)
        receiveData(from: connection)
    }
    
    private func receiveData(from connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { data, context, isComplete, error in
            if let data = data, !data.isEmpty {
                self.handleReceivedData(data: data, from: connection)
            }
            
            if isComplete {
                connection.cancel()
                if let index = self.connections.firstIndex(where: { $0 === connection }) {
                    self.connections.remove(at: index)
                }
            } else if error == nil {
                self.receiveData(from: connection)
            }
        }
    }
    
    private func handleReceivedData(data: Data, from connection: NWConnection) {
        if let receivedString = String(data: data, encoding: .utf8) {
            self.userFactory.saveMessages(
                _message_model: MessageModel(
                    username: self.userFactory.userModel.username,
                    message: receivedString,
                    type: TypeMessageEnum.message
                )
            )
        }
    }
    
    func sendMessageToAllClients(_message: String) {
            let messageData = _message.data(using: .utf8)
            for connection in connections {
                connection.send(content: messageData, completion: .contentProcessed({ sendError in
                    if let sendError = sendError {
                        print("Error sending message to client: \(sendError)")
                    } else {
                        print("Message sent to client")
                    }
                }))
            }
        }
}
