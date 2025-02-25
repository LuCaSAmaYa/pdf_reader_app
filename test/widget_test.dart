import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_reader_app/main.dart'; // Asegúrate de que esta ruta sea correcta

void main() {
  testWidgets('MyApp widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp()); // Corrección aquí

    // Verify that our counter starts at 0.
    expect(find.text('PDF Reader App'), findsOneWidget); // Cambia esto por un widget que exista en tu app.

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('1'), findsOneWidget);
  });
}