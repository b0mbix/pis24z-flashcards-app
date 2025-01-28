// Automatic FlutterFlow imports
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/backend/api_requests/api_interceptor.dart';
import '/backend/api_requests/api_calls.dart';

class FixedOnAuthErrorRefreshTokenInterceptor extends FFApiInterceptor {
  @override
  Future<ApiCallOptions> onRequest({
    required ApiCallOptions options,
  }) async {
    // Perform any necessary calls or modifications to the [options] before
    // the API call is made.
    return options;
  }

  @override
  Future<ApiCallResponse> onResponse({
    required ApiCallResponse response,
    required Future<ApiCallResponse> Function() retryFn,
  }) async {
    if (!(response?.succeeded ?? true)) {
      ApiCallResponse refreshResponse = await RefreshTokenCall.call(
        refreshToken: FFAppState().refreshToken,
      );
      if ((refreshResponse?.succeeded ?? true)) {
        String newAccessToken = getJsonField(
          (refreshResponse?.jsonBody ?? ''),
          r'''$["access"]''',
        ).toString();

        FFAppState().update(() {
          FFAppState().accessToken = newAccessToken;
        });

        await RefreshTokenCall.call(
          refreshToken: FFAppState().accessToken,
        );

        //return await TestAuthCall.call();
        return response;
      } else {
        return response;
      }
    }
    return response;
  }
}
