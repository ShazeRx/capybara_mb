import 'package:capybara_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockDataConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(
      connectionChecker: mockDataConnectionChecker,
    );
  });

  group('check connection', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        // Arrange
        final tHasConnectionFuture = Future.value(true);

        when(() => mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);

        // Act
        // NOTICE: We're NOT awaiting the result
        final result = networkInfo.isConnected;

        // Assert
        verify(() => mockDataConnectionChecker.hasConnection);

        expect(result, tHasConnectionFuture);
      },
    );
  });
}
