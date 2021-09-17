import 'package:capybara_app/data/datasource/chat/chat_remote_data_source.dart';
import 'package:capybara_app/ui/states/chat/chat_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatState extends Mock implements ChatState {}

void main() {
  late ChatRemoteDataSource chatRemoteDataSource;
  late MockChatState mockChatState;
  setUp(() {
    mockChatState = MockChatState();
    chatRemoteDataSource = ChatRemoteDataSourceImpl();
  });
  group('fetch last 10 messages',(){
    test('should fetch the last 10 messages',(){

    });
  });
  group('fetch last 10 messages from timestamp',(){

  });
  group('send message',(){

  });
  group('join chat session',(){

  });
}
