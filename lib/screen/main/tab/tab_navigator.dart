import 'package:todo_state_getx/screen/main/tab/tab_item.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    super.key,
    required this.tabItem,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => tabItem.firstPage,
          );
        });
  }
}
