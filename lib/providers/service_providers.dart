import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/core/utils/network_info.dart';
import 'package:news_reader/data/datasources/api_service.dart';
import 'package:news_reader/data/datasources/local_storage_service.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('Must be overridden in main');
});

final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfo(ref.read(connectivityProvider));
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
