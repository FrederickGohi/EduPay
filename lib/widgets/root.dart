import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/c_user.dart';
import '../views/drawer/ProfilePage.dart';
import '../views/Services/support.dart';
import '../views/accueil.dart';
import '../views/history/historique_paiement.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final CUser _cUser = Get.put(CUser());
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CUser(),
      initState: (state) {
        _cUser.getUser();
      },
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: activeTab,
            children: [
              Accueil(),
              Historique(),
              ProfilPage(),
            ],
          ),
          bottomNavigationBar: getBottomBar(),
        );
      },
    );
  }

  Widget getBottomBar() {
    return BottomNavigationBar(
      currentIndex: activeTab,
      onTap: (index) {
        setState(() {
          activeTab = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: "Accueil",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.arrow_right_arrow_left),
          label: "Transactions",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: "Profil",
        ),
      ],
      selectedItemColor: Theme.of(context).buttonTheme.colorScheme!.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      selectedLabelStyle: const TextStyle(fontSize: 13),
    );
  }
}
