import 'package:web_socket_channel/web_socket_channel.dart';

abstract class SocketClient {
  WebSocketChannel connect(int channelId);
  Future<void> sendMessage();
}
