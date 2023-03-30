import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/routes.dart';
import 'package:weather_app/screens/helpScreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("reach homepage screen from helpscreen", (widgetTester) async {
    await widgetTester.pumpWidget(ProviderScope(
        child: MaterialApp(
      // debugShowCheckedModeBanner: false,
      initialRoute: HelpScreen.route,
      routes: getRoutes,
    )));

    // sometime work/task is done/executed offScreen.
    // so ensurevisible make sure to not skip offScreen task
    await widgetTester.ensureVisible(find.byType(ElevatedButton));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byType(ElevatedButton));

    // wait for the test to complete.
    await widgetTester.pumpAndSettle(const Duration(seconds: 10));

    Finder textFormFieldWidget = find.text("Save/Search");
    expect(textFormFieldWidget, findsOneWidget);
  });
}
