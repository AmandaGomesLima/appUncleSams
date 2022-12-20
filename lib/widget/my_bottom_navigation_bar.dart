import 'package:flutter/material.dart';
import 'package:uncle_sam/pages/schedule.dart';
import 'package:uncle_sam/pages/history.dart';
import 'package:uncle_sam/pages/profile.dart';
import 'package:uncle_sam/pages/about.dart';

enum TabItem {
  profile,
  schedule,
  history,
  about
}

Map<TabItem, String> tabName = {
  TabItem.profile: 'Perfil',
  TabItem.schedule: 'Agendar',
  TabItem.history: 'Agendamentos',
  TabItem.about: 'Sobre'
};

Map<TabItem, IconData> tabIcon = {
  TabItem.profile: Icons.person,
  TabItem.schedule: Icons.edit_calendar_rounded,
  TabItem.history: Icons.history,
  TabItem.about: Icons.cut
};

final ValueNotifier currentTabIndex = ValueNotifier(TabItem.profile.index);

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  final List<Widget> _children = [
    const ProfilePage(),
    const SchedulePage(),
    const HistoryPage(),
    const AboutPage(),
  ];

  void onSelectTab(TabItem value) {
    setState(() {
      currentTabIndex.value = value.index;
    });
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({required TabItem tabItem}) {
    String? name = tabName[tabItem];
    IconData? icon = tabIcon[tabItem];

    return BottomNavigationBarItem(
        icon: Icon(icon),
        label: name
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[currentTabIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem(tabItem: TabItem.profile),
            _buildBottomNavigationBarItem(tabItem: TabItem.schedule),
            _buildBottomNavigationBarItem(tabItem: TabItem.history),
            _buildBottomNavigationBarItem(tabItem: TabItem.about),
          ],
          currentIndex: currentTabIndex.value,
          selectedItemColor: const Color.fromARGB(255, 199, 61, 48),
          onTap: (index) => onSelectTab(
            TabItem.values[index],
          ),
        )
    );
  }

}
