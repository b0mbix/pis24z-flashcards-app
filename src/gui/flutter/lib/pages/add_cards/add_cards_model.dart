import '/components/card_row_widget.dart';
import '/components/input_row_widget.dart';
import '/components/new_set_dialog_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'add_cards_widget.dart' show AddCardsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddCardsModel extends FlutterFlowModel<AddCardsWidget> {
  ///  State fields for stateful widgets in this page.

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
