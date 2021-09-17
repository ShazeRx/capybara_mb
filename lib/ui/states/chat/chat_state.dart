import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';

abstract class ChatState implements Disposable {
  BehaviorSubject<List<IOWebSocketChannel>> get channels$;

  void setChannels(List<IOWebSocketChannel> channels);
}
