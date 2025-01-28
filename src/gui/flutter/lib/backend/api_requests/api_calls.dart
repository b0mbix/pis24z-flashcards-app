import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';
import 'interceptors.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Api calls Group Code

class ApiCallsGroup {
  static String getBaseUrl() => 'http://localhost:8000/api/';
  static Map<String, String> headers = {};
  static AddFlashcardCall addFlashcardCall = AddFlashcardCall();
  static AddTagCall addTagCall = AddTagCall();
  static AddFlashcardSetTagCall addFlashcardSetTagCall =
      AddFlashcardSetTagCall();
  static AddFlashcardSetCall addFlashcardSetCall = AddFlashcardSetCall();
  static AddFlashcardFavoriteCall addFlashcardFavoriteCall =
      AddFlashcardFavoriteCall();
  static AddFlashcardSetFavoriteCall addFlashcardSetFavoriteCall =
      AddFlashcardSetFavoriteCall();
  static GetFlashcardCall getFlashcardCall = GetFlashcardCall();
  static GetTagCall getTagCall = GetTagCall();
  static GetFlashcardSetCall getFlashcardSetCall = GetFlashcardSetCall();
  static EditFlashcardCall editFlashcardCall = EditFlashcardCall();
  static EditTagCall editTagCall = EditTagCall();
  static EditFlashcardSetCall editFlashcardSetCall = EditFlashcardSetCall();
  static DeleteFlashcardCall deleteFlashcardCall = DeleteFlashcardCall();
  static DeleteTagCall deleteTagCall = DeleteTagCall();
  static DeleteFlashcardSetTagCall deleteFlashcardSetTagCall =
      DeleteFlashcardSetTagCall();
  static DeleteFlashcardSetCall deleteFlashcardSetCall =
      DeleteFlashcardSetCall();
  static DeleteFlashcardFavoriteCall deleteFlashcardFavoriteCall =
      DeleteFlashcardFavoriteCall();
  static DeleteFlashcardSetFavoriteCall deleteFlashcardSetFavoriteCall =
      DeleteFlashcardSetFavoriteCall();

  static final interceptors = [
    AddAccessTokenToApiCallInterceptor(),
  ];
}

class AddFlashcardCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcard',
        apiUrl: '${baseUrl}flashcards/add/',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class AddTagCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addTag',
        apiUrl: '${baseUrl}tags/add/',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class AddFlashcardSetTagCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardSetTag',
        apiUrl: '${baseUrl}flashcard-sets/tags/add/',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class AddFlashcardSetCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? desc = '',
    bool? isPublic,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "description": "${escapeStringForJson(desc)}",
  "is_public": ${isPublic}
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardSet',
        apiUrl: '${baseUrl}flashcard-sets/add/',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class AddFlashcardFavoriteCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardFavorite',
        apiUrl: '${baseUrl}flashcard-favorites/add/',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class AddFlashcardSetFavoriteCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardSetFavorite',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/set-favorite/',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class GetFlashcardCall {
  Future<ApiCallResponse> call({
    int? flashcardId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getFlashcard',
        apiUrl: '${baseUrl}flashcards/${flashcardId}/get/',
        callType: ApiCallType.GET,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class GetTagCall {
  Future<ApiCallResponse> call({
    int? tagId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getTag',
        apiUrl: '${baseUrl}tags/${tagId}/get/',
        callType: ApiCallType.GET,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class GetFlashcardSetCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getFlashcardSet',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/get/',
        callType: ApiCallType.GET,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class EditFlashcardCall {
  Future<ApiCallResponse> call({
    int? flashcardId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'editFlashcard',
        apiUrl: '${baseUrl}flashcards/${flashcardId}/update/',
        callType: ApiCallType.PUT,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class EditTagCall {
  Future<ApiCallResponse> call({
    int? tagId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'editTag',
        apiUrl: '${baseUrl}tags/${tagId}/update/',
        callType: ApiCallType.PUT,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class EditFlashcardSetCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'editFlashcardSet',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/update/',
        callType: ApiCallType.PUT,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class DeleteFlashcardCall {
  Future<ApiCallResponse> call({
    int? flashcardId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcard',
        apiUrl: '${baseUrl}flashcards/${flashcardId}/delete/',
        callType: ApiCallType.DELETE,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class DeleteTagCall {
  Future<ApiCallResponse> call({
    int? tagId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteTag',
        apiUrl: '${baseUrl}tags/${tagId}/delete/',
        callType: ApiCallType.DELETE,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class DeleteFlashcardSetTagCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardSetTag',
        apiUrl: '${baseUrl}flashcard-sets/tags/delete',
        callType: ApiCallType.DELETE,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class DeleteFlashcardSetCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardSet',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/delete/',
        callType: ApiCallType.DELETE,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class DeleteFlashcardFavoriteCall {
  Future<ApiCallResponse> call({
    int? flashcardId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardFavorite',
        apiUrl: '${baseUrl}flashcard-favorites/${flashcardId}/delete/',
        callType: ApiCallType.DELETE,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

class DeleteFlashcardSetFavoriteCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardSetFavorite',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/unset-favorite',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      ApiCallsGroup.interceptors,
    );
  }
}

/// End Api calls Group Code

/// Start Api callssss Group Code

class ApiCallssssGroup {
  static String getBaseUrl() => 'http://localhost:8000/api/';
  static Map<String, String> headers = {};
  static GetAllSetsCall getAllSetsCall = GetAllSetsCall();
  static GetSetDataCall getSetDataCall = GetSetDataCall();
  static GetShuffledSetCall getShuffledSetCall = GetShuffledSetCall();
  static AddSetCall addSetCall = AddSetCall();
}

class GetAllSetsCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = ApiCallssssGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getAllSets',
        apiUrl: '${baseUrl}flashcard-sets/public/',
        callType: ApiCallType.GET,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      interceptors,
    );
  }

  static final interceptors = [
    AddAccessTokenToApiCallInterceptor(),
  ];

  List<int>? setId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? setName(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? setDescription(dynamic response) => (getJsonField(
        response,
        r'''$[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  dynamic cardCount(dynamic response) => getJsonField(
        response,
        r'''$[:].flashcards_count''',
      );
}

class GetSetDataCall {
  Future<ApiCallResponse> call({
    int? setId = 4,
  }) async {
    final baseUrl = ApiCallssssGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSetData',
      apiUrl: '${baseUrl}flashcard-sets/${setId}/get/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetShuffledSetCall {
  Future<ApiCallResponse> call({
    int? setId,
  }) async {
    final baseUrl = ApiCallssssGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getShuffledSet',
        apiUrl: '${baseUrl}study/1/set/${setId}/get-shuffled/',
        callType: ApiCallType.GET,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: true,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      interceptors,
    );
  }

  static final interceptors = [
    AddAccessTokenToApiCallInterceptor(),
  ];
}

class AddSetCall {
  Future<ApiCallResponse> call({
    String? setName = '',
    String? setDesc = '',
    bool? isPrivate = false,
  }) async {
    final baseUrl = ApiCallssssGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(setName)}",
  "description": "${escapeStringForJson(setDesc)}",
  "is_public": "${isPrivate}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addSet',
        apiUrl: '${baseUrl}flashcard-sets/add/',
        callType: ApiCallType.POST,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},
        body: ffApiRequestBody,
        bodyType: BodyType.JSON,
        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      interceptors,
    );
  }

  static final interceptors = [
    AddAccessTokenToApiCallInterceptor(),
  ];
}

/// End Api callssss Group Code

/// Start ngrokTests Group Code

class NgrokTestsGroup {
  static String getBaseUrl() =>
      'https://b20b-109-243-0-190.ngrok-free.app/api/';
  static Map<String, String> headers = {};
  static GetSetDataaaCall getSetDataaaCall = GetSetDataaaCall();
}

class GetSetDataaaCall {
  Future<ApiCallResponse> call({
    int? setId = 4,
  }) async {
    final baseUrl = NgrokTestsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getSetDataaa',
      apiUrl: '${baseUrl}flashcard-sets/${setId}/get/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? setName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  String? setDesc(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  List? flashcardsData(dynamic response) => getJsonField(
        response,
        r'''$.flashcards''',
        true,
      ) as List?;
  List? tagsData(dynamic response) => getJsonField(
        response,
        r'''$.tags''',
        true,
      ) as List?;
}

/// End ngrokTests Group Code

class RegisterUserCall {
  static Future<ApiCallResponse> call({
    String? userLogin = '',
    String? userPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${escapeStringForJson(userLogin)}",
  "password": "${escapeStringForJson(userPassword)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'registerUser',
      apiUrl: 'http://localhost:8000/api/register/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginUserCall {
  static Future<ApiCallResponse> call({
    String? userLogin = '',
    String? userPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${escapeStringForJson(userLogin)}",
  "password": "${escapeStringForJson(userPassword)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'loginUser',
      apiUrl: 'http://localhost:8000/api/login/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class TestAuthCall {
  static Future<ApiCallResponse> call() async {
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'testAuth',
        apiUrl: 'http://localhost:8000/api/test-auth/',
        callType: ApiCallType.GET,
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        headers: {},
        // ignore: prefer_const_literals_to_create_immutables - can be mutated by interceptors
        params: {},

        returnBody: true,
        encodeBodyUtf8: false,
        decodeUtf8: false,
        cache: false,
        isStreamingApi: false,
        alwaysAllowBody: false,
      ),

      interceptors,
    );
  }

  static final interceptors = [
    AddAccessTokenToApiCallInterceptor(),
  ];
}

class RefreshTokenCall {
  static Future<ApiCallResponse> call({
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "refresh": "${escapeStringForJson(refreshToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'refreshToken',
      apiUrl: 'http://localhost:8000/api/token/refresh/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
