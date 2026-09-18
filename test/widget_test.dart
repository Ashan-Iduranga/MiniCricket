// Basic widget tests for the Mini Cricket app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mini_cricket/main.dart';

void main() {
  testWidgets('Starts with 0 runs, 6 balls and a Bat button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiniCricketApp());

    expect(find.text('Runs'), findsOneWidget);
    expect(find.text('Balls'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Bat'), findsOneWidget);
  });

  testWidgets('Tapping Bat starts a spin and shows a Ball button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiniCricketApp());

    await tester.tap(find.widgetWithText(ElevatedButton, 'Bat'));
    await tester.pump();

    expect(find.widgetWithText(ElevatedButton, 'Ball'), findsOneWidget);

    // Let the spin animation finish and settle on a result.
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Either the innings continues (Bat button back) or it ended in
    // a wicket/no balls left (Restart button shown).
    final hasBat = find.widgetWithText(ElevatedButton, 'Bat').evaluate().isNotEmpty;
    final hasRestart =
        find.widgetWithText(ElevatedButton, 'Restart').evaluate().isNotEmpty;
    expect(hasBat || hasRestart, isTrue);
  });
}
