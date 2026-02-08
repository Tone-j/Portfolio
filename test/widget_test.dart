import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_web/main.dart';

void main() {
  testWidgets('Portfolio app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('Mongezi Tone Jali'), findsOneWidget);
  });
}
