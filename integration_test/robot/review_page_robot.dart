import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ReviewPageRobot {
  final WidgetTester tester;

  ReviewPageRobot(this.tester);

  final buttonAddReview = const ValueKey('buttonAddReview');
  final textNameReview = const ValueKey('nameReview');
  final textDescReview = const ValueKey('descReview');
  final buttonBatal = const ValueKey('buttonBatal');
  final buttonSimpan = const ValueKey('buttonSimpan');

  Future<void> addReview() async {
    await tester.tap(find.byKey(buttonAddReview));
    await tester.pumpAndSettle();
  }

  Future<void> editNameReview() async {
    await tester.tap(find.byKey(textNameReview));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(textNameReview), 'Yasmine');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> editDescReview() async {
    await tester.tap(find.byKey(textDescReview));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(textDescReview), 'Mantap!');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> tapButtonBatal() async {
    await tester.tap(find.byKey(buttonBatal));
    await tester.pumpAndSettle();
  }

  Future<void> tapButtonSimpan() async {
    await tester.tap(find.byKey(buttonSimpan));
    await tester.pumpAndSettle();
  }
}
