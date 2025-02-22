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

    const nameReview = 'Yasmine';

    for (int i = 0; i < nameReview.length; i++) {
      await tester.enterText(find.byKey(textNameReview), nameReview.substring(0, i + 1));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> editDescReview() async {
    await tester.tap(find.byKey(textDescReview));
    await tester.pumpAndSettle();

    const descReview = 'Mantap!';

    for (int i = 0; i < descReview.length; i++) {
      await tester.enterText(find.byKey(textDescReview), descReview.substring(0, i + 1));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));
    }
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
