import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'swipeablecardtest_widget.dart' show SwipeablecardtestWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SwipeablecardtestModel extends FlutterFlowModel<SwipeablecardtestWidget> {
  ///  Local state fields for this component.

  List<String> cardTexts = [
    'Hello World1',
    'Hello World2',
    'Hello World3',
    'Hello World4',
    'Hello World5'
  ];
  void addToCardTexts(String item) => cardTexts.add(item);
  void removeFromCardTexts(String item) => cardTexts.remove(item);
  void removeAtIndexFromCardTexts(int index) => cardTexts.removeAt(index);
  void insertAtIndexInCardTexts(int index, String item) =>
      cardTexts.insert(index, item);
  void updateCardTextsAtIndex(int index, Function(String) updateFn) =>
      cardTexts[index] = updateFn(cardTexts[index]);

  List<String> cardFlippedTexts = [
    'Flipped1',
    'Flipped2',
    'Flipped3',
    'Flipped4'
  ];
  void addToCardFlippedTexts(String item) => cardFlippedTexts.add(item);
  void removeFromCardFlippedTexts(String item) => cardFlippedTexts.remove(item);
  void removeAtIndexFromCardFlippedTexts(int index) =>
      cardFlippedTexts.removeAt(index);
  void insertAtIndexInCardFlippedTexts(int index, String item) =>
      cardFlippedTexts.insert(index, item);
  void updateCardFlippedTextsAtIndex(int index, Function(String) updateFn) =>
      cardFlippedTexts[index] = updateFn(cardFlippedTexts[index]);

  List<String> currentCardText = [];
  void addToCurrentCardText(String item) => currentCardText.add(item);
  void removeFromCurrentCardText(String item) => currentCardText.remove(item);
  void removeAtIndexFromCurrentCardText(int index) =>
      currentCardText.removeAt(index);
  void insertAtIndexInCurrentCardText(int index, String item) =>
      currentCardText.insert(index, item);
  void updateCurrentCardTextAtIndex(int index, Function(String) updateFn) =>
      currentCardText[index] = updateFn(currentCardText[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
  }

  @override
  void dispose() {}
}
