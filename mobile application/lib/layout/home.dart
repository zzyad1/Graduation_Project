import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network/shared/componants/constants.dart';
import 'package:social_network/modules/login/login.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../modules/emergency/emergency.dart';
import '../modules/eye/eye.dart';
import '../modules/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DrawerItem> drawerItems = [
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'eye',
      icon: Icons.remove_red_eye_outlined,
    ),
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'emergency',
      icon: Icons.emergency,
    ),
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'Profile',
      icon: FontAwesomeIcons.userAlt,
    ),
    DrawerItem(
      navigate: const LoginScreen(),
      title: 'Logout',
      icon: FontAwesomeIcons.signOutAlt,
    ),
  ];

  @override
  void initState() {
    super.initState();

    AppBloc.get(context).getUserData(userConst!.uid);
    //AppBloc.get(context).getPosts();
    AppBloc.get(context).getUsers();
  }

  List<Widget> screens = [
    eye(),
    Emergency(),
    profile_screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/Asset 4.png'),
              ),
            ),
            title: Text (
                'Eye control wheel chair'
            ),
          ),
          body: screens[AppBloc.get(context).currentIndex],
          drawer: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: double.infinity,
                    color: Colors.teal,
                    height: 120.0,
                    child: const Center(
                      child: Text(
                        'Eye controle wheelchair',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                      selected: index <= 2 &&
                          index == AppBloc.get(context).currentIndex,
                      leading: Icon(
                        drawerItems[index].icon,
                        color: index == drawerItems.length - 1
                            ? Colors.red
                            : null,
                      ),
                      onTap: () {
                        if (index <= 2) {
                          AppBloc.get(context).bottomChanged(index);

                          Navigator.pop(context);
                        } else if (index == drawerItems.length - 1) {
                          FirebaseAuth.instance.signOut().then((value) {
                            navigateAndFinish(context, const LoginScreen(),);
                          });
                        }
                      },
                      title: Text(
                        drawerItems[index].title,
                        style: TextStyle(
                          color: index == drawerItems.length - 1
                              ? Colors.red
                              : null,
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const MyDivider(),
                    itemCount: drawerItems.length,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppBloc.get(context).currentIndex,
            onTap: (index) {
              AppBloc.get(context).bottomChanged(index);
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                  ),
                ),
                label: 'eye',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.emergency,
                  ),
                ),
                label: 'emergency',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    FontAwesomeIcons.userAlt,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

class DrawerItem {
  final String title;
  final Widget navigate;
  final IconData icon;

  DrawerItem({
    required this.title,
    required this.navigate,
    required this.icon,
  });
}
