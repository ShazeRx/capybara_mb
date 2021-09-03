import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/usecases/channel/add_to_channel.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:dartz/dartz.dart';

abstract class ChannelRepository {
  Future<Either<Failure, Channel>> createChannel(ChannelParams params);

  Future<Either<Failure, Unit>> addToChannel(AddToChannelParams params);

  Future<Either<Failure, List<Channel>>> fetchChannels();
}
