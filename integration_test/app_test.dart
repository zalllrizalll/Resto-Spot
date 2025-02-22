import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:resto_spot/main.dart';
import 'robot/detail_page_robot.dart';
import 'robot/home_page_robot.dart';
import 'robot/review_page_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Resto Spot Test', (tester) async {
    final homePageRobot = HomePageRobot(tester);
    final detailPageRobot = DetailPageRobot(tester);
    final reviewPageRobot = ReviewPageRobot(tester);

    await homePageRobot.loadUI(const MainApp());

    await homePageRobot.scrollDownListView();

    await homePageRobot.scrollUpListView();

    await homePageRobot.tapRestaurantCard();

    await detailPageRobot.scrollDownDetailPage();

    await detailPageRobot.scrollLeftMenusFoodCard();

    await detailPageRobot.scrollRightMenusFoodCard();

    await detailPageRobot.scrollLeftMenusDrinksCard();

    await detailPageRobot.scrollRightMenusDrinksCard();

    await detailPageRobot.scrollUpDetailPage();

    await detailPageRobot.tapFavourite();

    await detailPageRobot.tapReviews();

    await reviewPageRobot.addReview();

    await reviewPageRobot.editNameReview();

    await reviewPageRobot.editDescReview();

    await reviewPageRobot.tapButtonBatal();

    await reviewPageRobot.addReview();

    await reviewPageRobot.editNameReview();

    await reviewPageRobot.editDescReview();

    await reviewPageRobot.tapButtonSimpan();

    await detailPageRobot.tapOverview();

    await detailPageRobot.backHomePage();

    await homePageRobot.moveToSearchPage();

    await homePageRobot.moveToFavouritePage();

    await homePageRobot.moveToSettingPage();

    await homePageRobot.moveToHomePage();
  });
}
