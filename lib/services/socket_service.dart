import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.on('receiveMessage', (data) {
      print('New message received: $data');
    });
  }

  void sendMessage(String text, String from, String to) {
    socket.emit('sendMessage', {
      'text': text,
      'from': from,
      'to': to,
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
