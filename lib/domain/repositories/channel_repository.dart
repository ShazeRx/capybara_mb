import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel.dart';
import 'package:dartz/dartz.dart';

abstract class ChannelRepository {
  Future<Either<Failure, Channel>> createChannel(String name);

  Future<Either<Failure, Channel>> addToChannel(
      String channelId, String userId);

  Future<Either<Failure, List<Channel>>> fetchChannels();
}
