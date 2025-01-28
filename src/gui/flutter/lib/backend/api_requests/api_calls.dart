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
  static GetFlashcardSetTagsCall getFlashcardSetTagsCall =
      GetFlashcardSetTagsCall();
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
  Future<ApiCallResponse> call({
    int? setId,
    String? question = '',
    String? answer = '',
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "set_id": "${setId}",
  "question": "${escapeStringForJson(question)}",
  "answer": "${escapeStringForJson(answer)}"
}''';
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

class AddTagCall {
  Future<ApiCallResponse> call({
    String? name = '',
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}"
}''';
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

class AddFlashcardSetTagCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
    int? tagId,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "tag_id": "${tagId}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardSetTag',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/tags/add',
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

class AddFlashcardSetCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? description = '',
    bool? isPublic,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "description": "${escapeStringForJson(description)}",
  "is_public": "${isPublic}"
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
  Future<ApiCallResponse> call({
    int? userId,
    int? flashcardId,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${userId}",
  "flashcard_id": "${flashcardId}"
}''';
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

class AddFlashcardSetFavoriteCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "set_id": "${flashcardSetId}"
}''';
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

class GetFlashcardSetTagsCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getFlashcardSetTags',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/get-tags/',
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
    String? question = '',
    String? answer = '',
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
"question": "${escapeStringForJson(question)}",
"answer": "${escapeStringForJson(answer)}",
}''';
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

class EditTagCall {
  Future<ApiCallResponse> call({
    int? tagId = 0,
    String? name = '',
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}"
}''';
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

class EditFlashcardSetCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
    int? flashcardsViewed,
    int? totalStudyTime,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "flashcards_viewed": "${flashcardsViewed}",
  "total_study_time": "${totalStudyTime}"
}''';
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
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
    int? tagId,
  }) async {
    final baseUrl = ApiCallsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "tag_id": "${tagId}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardSetTag',
        apiUrl: '${baseUrl}flashcard-sets/${flashcardSetId}/tags/delete/',
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

    final ffApiRequestBody = '''
{
  "set_id": "${flashcardSetId}"
}''';
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

/// End Api calls Group Code

/// Start Api calls stats Group Code

class ApiCallsStatsGroup {
  static String getBaseUrl() => 'localhost:8000/api/';
  static Map<String, String> headers = {};
  static DeleteFlashcardSetStatsCall deleteFlashcardSetStatsCall =
      DeleteFlashcardSetStatsCall();
  static GetFlashcardSetStatsCall getFlashcardSetStatsCall =
      GetFlashcardSetStatsCall();
  static UpdateFlashcardSetStatsCall updateFlashcardSetStatsCall =
      UpdateFlashcardSetStatsCall();
  static AddFlashcardSetStatsCall addFlashcardSetStatsCall =
      AddFlashcardSetStatsCall();
  static AddFlashcardStatsPercentCall addFlashcardStatsPercentCall =
      AddFlashcardStatsPercentCall();
  static AddFlashcardStatsStagesCall addFlashcardStatsStagesCall =
      AddFlashcardStatsStagesCall();
  static AddFlashcardStatsSimpleCall addFlashcardStatsSimpleCall =
      AddFlashcardStatsSimpleCall();
  static GetFlashcardStatsPercentCall getFlashcardStatsPercentCall =
      GetFlashcardStatsPercentCall();
  static DeleteFlashcardStatsPercentCall deleteFlashcardStatsPercentCall =
      DeleteFlashcardStatsPercentCall();
  static UpdateFlashcardStatsPercentCall updateFlashcardStatsPercentCall =
      UpdateFlashcardStatsPercentCall();
  static GetFlashcardStatsSimpleCall getFlashcardStatsSimpleCall =
      GetFlashcardStatsSimpleCall();
  static DeleteFlashcardStatsSimpleCall deleteFlashcardStatsSimpleCall =
      DeleteFlashcardStatsSimpleCall();
  static UpdateFlashcardStatsSimpleCall updateFlashcardStatsSimpleCall =
      UpdateFlashcardStatsSimpleCall();
  static GetFlashcardStatsStagesCall getFlashcardStatsStagesCall =
      GetFlashcardStatsStagesCall();
  static DeleteFlashcardStatsStagesCall deleteFlashcardStatsStagesCall =
      DeleteFlashcardStatsStagesCall();
  static UpdateFlashcardStatsStagesCall updateFlashcardStatsStagesCall =
      UpdateFlashcardStatsStagesCall();

  static final interceptors = [
    AddAccessTokenToApiCallInterceptor(),
  ];
}

class DeleteFlashcardSetStatsCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardSetStats',
        apiUrl: '${baseUrl}flashcard-set-stats/${flashcardSetId}/delete/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class GetFlashcardSetStatsCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getFlashcardSetStats',
        apiUrl: '${baseUrl}flashcard-set-stats/${flashcardSetId}/get/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class UpdateFlashcardSetStatsCall {
  Future<ApiCallResponse> call({
    int? flashcardSetId = 0,
    int? flashcardsViewed,
    int? totalStudyTime,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "flashcards_viewed": "${flashcardsViewed}",
  "total_study_time": "${totalStudyTime}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'updateFlashcardSetStats',
        apiUrl: '${baseUrl}flashcard-set-stats/${flashcardSetId}/update/',
        callType: ApiCallType.PUT,
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class AddFlashcardSetStatsCall {
  Future<ApiCallResponse> call({
    int? userId,
    int? setId,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${userId}",
  "set_id": "${setId}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardSetStats',
        apiUrl: '${baseUrl}flashcard-set-stats/add/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class AddFlashcardStatsPercentCall {
  Future<ApiCallResponse> call({
    int? userId,
    int? flashcardId,
    int? viewCount,
    String? learningStage = '',
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${userId}",
  "flashcard_id": "${flashcardId}",
  "view_count": "${viewCount}",
  "learning_stage": "${escapeStringForJson(learningStage)}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardStatsPercent',
        apiUrl: '${baseUrl}flashcard-stats-percent/add/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class AddFlashcardStatsStagesCall {
  Future<ApiCallResponse> call({
    int? userId,
    int? flashcardId,
    int? viewCount,
    int? stage,
    bool? learned,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${userId}",
  "flashcard_id": "${flashcardId}",
  "view_count": "${viewCount}",
  "stage": "${stage}",
  "learned": "${learned}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardStatsStages',
        apiUrl: '${baseUrl}flashcard-stats-stages/add/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class AddFlashcardStatsSimpleCall {
  Future<ApiCallResponse> call({
    int? userId,
    int? flashcardId,
    int? viewCount,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "user_id": "${userId}",
  "flashcard_id": "${flashcardId}",
  "view_count": "${viewCount}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'addFlashcardStatsSimple',
        apiUrl: '${baseUrl}flashcard-stats-simple/add/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class GetFlashcardStatsPercentCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getFlashcardStatsPercent',
        apiUrl: '${baseUrl}flashcard-stats-percent/${statsId}/get/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class DeleteFlashcardStatsPercentCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardStatsPercent',
        apiUrl: '${baseUrl}flashcard-stats-percent/${statsId}/delete/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class UpdateFlashcardStatsPercentCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
    int? viewCount,
    String? learningStage = '',
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "view_count": "${viewCount}",
  "learning_stage": "${escapeStringForJson(learningStage)}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'updateFlashcardStatsPercent',
        apiUrl: '${baseUrl}flashcard-stats-percent/${statsId}/update/',
        callType: ApiCallType.PUT,
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class GetFlashcardStatsSimpleCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getFlashcardStatsSimple',
        apiUrl: '${baseUrl}flashcard-stats-simple/${statsId}/get/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class DeleteFlashcardStatsSimpleCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardStatsSimple',
        apiUrl: '${baseUrl}flashcard-stats-simple/${statsId}/delete/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class UpdateFlashcardStatsSimpleCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
    int? viewCount,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "view_count": "${viewCount}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'updateFlashcardStatsSimple',
        apiUrl: '${baseUrl}flashcard-stats-simple/${statsId}/update/',
        callType: ApiCallType.PUT,
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class GetFlashcardStatsStagesCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'getFlashcardStatsStages',
        apiUrl: '${baseUrl}flashcard-stats-stages/${statsId}/get/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class DeleteFlashcardStatsStagesCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'deleteFlashcardStatsStages',
        apiUrl: '${baseUrl}flashcard-stats-stages/${statsId}/delete/',
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

class UpdateFlashcardStatsStagesCall {
  Future<ApiCallResponse> call({
    int? statsId = 0,
    int? viewCount,
    int? stage,
    bool? learned,
  }) async {
    final baseUrl = ApiCallsStatsGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "view_count": "${viewCount}",
  "stage": "${stage}",
  "learned": "${learned}"
}''';
    return FFApiInterceptor.makeApiCall(
      // ignore: prefer_const_constructors - can be mutated by interceptors
      ApiCallOptions(
        callName: 'updateFlashcardStatsStages',
        apiUrl: '${baseUrl}flashcard-stats-stages/${statsId}/update/',
        callType: ApiCallType.PUT,
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

      ApiCallsStatsGroup.interceptors,
    );
  }
}

/// End Api calls stats Group Code

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
