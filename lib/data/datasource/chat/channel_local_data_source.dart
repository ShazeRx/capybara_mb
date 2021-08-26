import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/data/models/channel_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChannelLocalDataSource {
  Future<List<ChannelModel>> fetchChannels();

  Future<void> cacheChannels(List<ChannelModel> channels);
}

class ChannelLocalDataSourceImpl implements ChannelLocalDataSource {
  final SharedPreferences _sharedPreferences;

  ChannelLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : this._sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheChannels(List<ChannelModel> channels) {
    return _sharedPreferences.setString(CachedValues.channels,
        ChannelModel.fromListToJson(channels).toString());
  }

  @override
  Future<List<ChannelModel>> fetchChannels() {
    final jsonString = this._sharedPreferences.getString(CachedValues.channels);
    if (jsonString == null) throw CacheException();
    return Future.value(ChannelModel.fromJsonToList(json.decode(jsonString)));
  }
}
