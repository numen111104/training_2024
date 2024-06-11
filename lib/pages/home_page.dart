import 'package:flutter/material.dart';
import 'package:training_2024/pages/first_page.dart';
import 'package:training_2024/pages/profile_page.dart';
import 'package:training_2024/pages/search_page.dart';
import 'package:training_2024/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentvalue = 0;
  void onTapHandler(int index) {
    setState(() {
      currentvalue = index;
    });
  }

  List<Widget> contents = [
    const FirstPage(),
    const SearchPage(),
    const ProfilePage(),
    const SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 33,
                    backgroundColor: Colors.red,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://instagram.fcgk4-5.fna.fbcdn.net/v/t51.2885-19/447093431_1132205914667005_4657300961670120390_n.jpg?_nc_ht=instagram.fcgk4-5.fna.fbcdn.net&_nc_cat=101&_nc_ohc=pThsluqrJcYQ7kNvgFt7h-4&edm=AEhyXUkBAAAA&ccb=7-5&oh=00_AYAXexB0TsqIWaBoBteSR6rR5x26W5T6Obd-xTDdXNe_2w&oe=666D8C19&_nc_sid=cf751b',
                      ),
                      // backgroundColor: Color.fromARGB(255, 1, 46, 124),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Numenide",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
            ),
            ListTile(
              title: Text('Item 2'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        // leading: IconButton(
        //   icon: const Icon(Icons.settings),
        //   onPressed: () {},
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: contents[currentvalue],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: "Increment",
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        onTap: onTapHandler,
        currentIndex: currentvalue,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}