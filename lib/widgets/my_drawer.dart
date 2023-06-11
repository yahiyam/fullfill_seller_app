import 'package:flutter/material.dart';
import 'package:fullfill_seller_app/authPage/auth_page.dart';
import 'package:fullfill_seller_app/global/global.dart';
import 'package:fullfill_seller_app/mainScreens/home_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreferences!.getString("photoUrl")!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Train"),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (c) => const HomeScreen()),
                        (route) => false);
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "New orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.local_shipping,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "History - Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const AuthPage()));
                    });
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
