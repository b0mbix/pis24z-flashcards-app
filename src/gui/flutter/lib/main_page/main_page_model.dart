import '/components/main_set_data_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'main_page_widget.dart' show MainPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainPageModel extends FlutterFlowModel<MainPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Slider widget.
  double? sliderValue;
  // Models for MainSetData dynamic component.
  late FlutterFlowDynamicModels<MainSetDataModel> mainSetDataModels;

  @override
  void initState(BuildContext context) {
    mainSetDataModels = FlutterFlowDynamicModels(() => MainSetDataModel());
  }

  @override
  void dispose() {
    mainSetDataModels.dispose();
  }
}
