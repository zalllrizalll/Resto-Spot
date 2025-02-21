import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:resto_spot/main.dart';
import 'package:resto_spot/pages/detail/detail_page.dart';
import 'robot/home_page_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Page Test', () {
    testWidgets('should display a home page', (tester) async {
      final homePageRobot = HomePageRobot(tester);

      await homePageRobot.loadUI(const MainApp());

      await homePageRobot.scrollListView();

      await homePageRobot.tapRestaurantCard();

      expect(find.byType(DetailPage), findsOneWidget);
    });
  });
}
