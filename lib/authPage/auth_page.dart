import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/colors.dart';
import '../provider/auth_page_tabs_provider.dart';
import 'tabs/login_form.dart';
import 'tabs/sign_up_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final tabProvider = Provider.of<AuthTabsProvider>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                expandedHeight: screen.height / 3,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    alignment: Alignment.center,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                bottom: TabBar(
                  labelColor: black,
                  indicatorColor: indicatorColor,
                  splashFactory: NoSplash.splashFactory,
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  isScrollable: true,
                  controller: tabProvider.tabController,
                  tabs: const [
                    Tab(text: "Login"),
                    Tab(text: "Sign-up"),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: tabProvider.tabController,
            children: const [
              LoginForm(),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
