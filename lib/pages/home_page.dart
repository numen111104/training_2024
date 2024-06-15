import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_2024/pages/first_page.dart';
import 'package:training_2024/pages/profile_page.dart';
import 'package:training_2024/pages/search_page.dart';
import 'package:training_2024/pages/setting_page.dart';
import 'package:training_2024/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:training_2024/presentation/auth/login_page.dart';
import 'package:training_2024/theme.dart';

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
                color: StyleCustome.green,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 33,
                    backgroundColor: StyleCustome.blue,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://instagram.fcgk18-1.fna.fbcdn.net/v/t51.2885-19/447093431_1132205914667005_4657300961670120390_n.jpg?_nc_ht=instagram.fcgk18-1.fna.fbcdn.net&_nc_cat=101&_nc_ohc=MCCVml3IYHIQ7kNvgEBJJ9s&edm=APHcPcMBAAAA&ccb=7-5&oh=00_AYC9_8vAxGheqY8I0MfRFZqAG2M2eTKnduCFiPJJAw15qA&oe=66702F19&_nc_sid=cf751b',
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
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSucces) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              }
              if (state is LogoutFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LogoutLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () {
                  context.read<LogoutBloc>().add(LogoutButtonPressed());
                },
              );
            },
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
      ),
    );
  }
}
