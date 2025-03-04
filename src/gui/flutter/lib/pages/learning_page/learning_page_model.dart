import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/swipeablecardtest/swipeablecardtest_widget.dart';
import 'dart:ui';
import 'learning_page_widget.dart' show LearningPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LearningPageModel extends FlutterFlowModel<LearningPageWidget> {
  ///  Local state fields for this page.

  String currenSetName = 'xd';

  ///  State fields for stateful widgets in this page.

  // Model for swipeablecardtest component.
  late SwipeablecardtestModel swipeablecardtestModel;

  @override
  void initState(BuildContext context) {
    swipeablecardtestModel =
        createModel(context, () => SwipeablecardtestModel());
  }

  @override
  void dispose() {
    swipeablecardtestModel.dispose();
  }
}
