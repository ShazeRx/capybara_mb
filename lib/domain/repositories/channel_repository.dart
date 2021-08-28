import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel.dart';
import 'package:capybara_app/domain/usecases/chat/add_to_channel.dart';
import 'package:capybara_app/domain/usecases/chat/create_channel.dart';
import 'package:dartz/dartz.dart';

abstract class ChannelRepository {
  Future<Either<Failure, Channel>> createChannel(ChannelParams params);

  Future<Either<Failure, void>> addToChannel(
      AddToChannelParams params);

  Future<Either<Failure, List<Channel>>> fetchChannels();
}
