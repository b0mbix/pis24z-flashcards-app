import '/backend/api_requests/api_calls.dart';
import '/components/card_row_widget.dart';
import '/components/input_row_widget.dart';
import '/components/new_set_dialog_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'add_cards_widget.dart' show AddCardsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddCardsModel extends FlutterFlowModel<AddCardsWidget> {
  ///  Local state fields for this page.

  List<dynamic> setNames = [];
  void addToSetNames(dynamic item) => setNames.add(item);
  void removeFromSetNames(dynamic item) => setNames.remove(item);
  void removeAtIndexFromSetNames(int index) => setNames.removeAt(index);
  void insertAtIndexInSetNames(int index, dynamic item) =>
      setNames.insert(index, item);
  void updateSetNamesAtIndex(int index, Function(dynamic) updateFn) =>
      setNames[index] = updateFn(setNames[index]);

  List<int> setIds = [];
  void addToSetIds(int item) => setIds.add(item);
  void removeFromSetIds(int item) => setIds.remove(item);
  void removeAtIndexFromSetIds(int index) => setIds.removeAt(index);
  void insertAtIndexInSetIds(int index, int item) => setIds.insert(index, item);
  void updateSetIdsAtIndex(int index, Function(int) updateFn) =>
      setIds[index] = updateFn(setIds[index]);

  List<dynamic> currentSetCards = [];
  void addToCurrentSetCards(dynamic item) => currentSetCards.add(item);
  void removeFromCurrentSetCards(dynamic item) => currentSetCards.remove(item);
  void removeAtIndexFromCurrentSetCards(int index) =>
      currentSetCards.removeAt(index);
  void insertAtIndexInCurrentSetCards(int index, dynamic item) =>
      currentSetCards.insert(index, item);
  void updateCurrentSetCardsAtIndex(int index, Function(dynamic) updateFn) =>
      currentSetCards[index] = updateFn(currentSetCards[index]);

  int? current;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getAllSets)] action in AddCards widget.
  ApiCallResponse? apiResultmhw;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue2;
  FormFieldController<List<String>>? dropDownValueController2;
  // Models for CardRow dynamic component.
  late FlutterFlowDynamicModels<CardRowModel> cardRowModels;

  @override
  void initState(BuildContext context) {
    cardRowModels = FlutterFlowDynamicModels(() => CardRowModel());
  }

  @override
  void dispose() {
    cardRowModels.dispose();
  }
}
