import 'dart:convert';
import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/constants/http_methods.dart';
import 'package:capybara_app/core/http/http_client.dart';
import 'package:capybara_app/data/models/channel/channel_model.dart';
import 'package:capybara_app/data/requests/channel/add_to_channel_request.dart';
import 'package:capybara_app/data/requests/channel/channel_request.dart';
import 'package:dartz/dartz.dart';

abstract class ChannelRemoteDataSource {
  Future<ChannelModel> createChannel(ChannelRequest request);

  Future<Unit> addToChannel(AddToChannelRequest request);

  Future<List<ChannelModel>> fetchChannels();
}

class ChannelRemoteDataSourceImpl implements ChannelRemoteDataSource {
  final HttpClient _client;

  ChannelRemoteDataSourceImpl({required HttpClient client})
      : this._client = client;

  @override
  Future<Unit> addToChannel(AddToChannelRequest request) async {
    return await this._client.invoke(
        url: Api.channelUrl, method: HttpMethods.post, body: request.toJson());
  }

  @override
  Future<ChannelModel> createChannel(ChannelRequest request) async {
    final response = await this._client.invoke(
        url: Api.channelUrl, method: HttpMethods.post, body: request.toJson());
    return ChannelModel.fromJson(json.decode(response));
  }

  @override
  Future<List<ChannelModel>> fetchChannels() async {
    final response =
        await this._client.invoke(url: Api.channelUrl, method: HttpMethods.get);
    return ChannelModel.fromJsonToList(json.decode(response));
  }
}
