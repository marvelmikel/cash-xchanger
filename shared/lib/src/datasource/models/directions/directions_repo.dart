import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'open_auto_complete/auto_complete_model.dart';
import 'open_directions/open_directions_model.dart';

class DirectionsRepository {
  static const String _openUrl = 'https://api.openrouteservice.org/';

  final Dio _dio = Dio();
  Future<OpenDirections?> getOpenDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio
        .get('${_openUrl}v2/directions/driving-car', queryParameters: {
      'api_key': '5b3ce3597851110001cf6248615716482e0d468f853eb9864d40c2ae',
      'start': '${origin.longitude},${origin.latitude}',
      'end': '${destination.longitude},${destination.latitude}'
    });

    if (response.statusCode == 200) {
      return OpenDirections.fromJson(response.data);
    }
    return null;
  }

  Future<AutoCompleteModel?> getOpenAutoComplete({
    required String query,
  }) async {
    print('this is query keyword $query');
    try {
      final response =
          await _dio.get('${_openUrl}geocode/autocomplete', queryParameters: {
        'api_key': '5b3ce3597851110001cf6248615716482e0d468f853eb9864d40c2ae',
        'text': query,
        'boundary.country': 'NG',
        'sources': 'openstreetmap',
      });

      if (response.statusCode == 200) {
        return AutoCompleteModel.fromJson(response.data);
      }
      return null;
    } catch (_, stackTrace) {
      debugPrint('this the the Mo Fo error $_');
      debugPrint('this the the Mo Fo stackTrace $stackTrace');
      rethrow;
    }
  }
}

final directionsRepoProvider = Provider((ref) => DirectionsRepository());
