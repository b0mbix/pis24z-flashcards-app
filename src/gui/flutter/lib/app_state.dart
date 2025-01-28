import 'package:flutter/material.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<String> _InputRows = [];
  List<String> get InputRows => _InputRows;
  set InputRows(List<String> value) {
    _InputRows = value;
  }

  void addToInputRows(String value) {
    InputRows.add(value);
  }

  void removeFromInputRows(String value) {
    InputRows.remove(value);
  }

  void removeAtIndexFromInputRows(int index) {
    InputRows.removeAt(index);
  }

  void updateInputRowsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    InputRows[index] = updateFn(_InputRows[index]);
  }

  void insertAtIndexInInputRows(int index, String value) {
    InputRows.insert(index, value);
  }

  List<String> _SetNames = [
    'Spinach',
    'German',
    'Warhammer 40k',
    'Autism explained 101'
  ];
  List<String> get SetNames => _SetNames;
  set SetNames(List<String> value) {
    _SetNames = value;
  }

  void addToSetNames(String value) {
    SetNames.add(value);
  }

  void removeFromSetNames(String value) {
    SetNames.remove(value);
  }

  void removeAtIndexFromSetNames(int index) {
    SetNames.removeAt(index);
  }

  void updateSetNamesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    SetNames[index] = updateFn(_SetNames[index]);
  }

  void insertAtIndexInSetNames(int index, String value) {
    SetNames.insert(index, value);
  }

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(String value) {
    _accessToken = value;
  }

  String _refreshToken = '';
  String get refreshToken => _refreshToken;
  set refreshToken(String value) {
    _refreshToken = value;
  }
}
