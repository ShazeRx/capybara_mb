import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_users.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChannelRespository extends Mock implements ChannelRepository {}

void main() {
  late MockChannelRespository mockChannelRespository;
  late FetchUsers usecase;

  setUp(() {
    mockChannelRespository = MockChannelRespository();
    usecase = FetchUsers(channelRepository: mockChannelRespository);
  });

  final users = List.generate(
      2,
      (index) =>
          User(id: index, username: 'some$index', email: 'some$index@body.pl'));

  test('should fetch channels', () async {
    //arrange
    when(() => mockChannelRespository.fetchUsers())
        .thenAnswer((_) async => Right(users));

    //act
    final result = await usecase(NoParams());
    verify(() => mockChannelRespository.fetchUsers());

    //assert
    verifyNoMoreInteractions(mockChannelRespository);

    expect(result, Right(users));
  });
}
