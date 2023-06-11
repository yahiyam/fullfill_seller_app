import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AuthTabsProvider with ChangeNotifier {
  late TabController _tabController;

  TabController get tabController => _tabController;

  AuthTabsProvider() {
    _tabController = TabController(length: 2, vsync: VsyncProxy());
  }

  void changeTab(int index) {
    _tabController.animateTo(index);
    notifyListeners();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class VsyncProxy implements TickerProvider {
  @override
  Ticker createTicker(onTick) => Ticker(onTick);
}
