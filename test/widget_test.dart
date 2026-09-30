import 'package:flutter_test/flutter_test.dart';
import 'package:campus_vaults/main.dart';

void main() {
  testWidgets('Campus Vaults app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusVaultsApp());

    expect(find.text('Campus Vaults'), findsOneWidget);
    expect(find.text('Welcome to Campus Vaults'), findsOneWidget);
  });
}