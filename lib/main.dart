// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_2024/data/datasources/auth_local_datasource.dart';
import 'package:training_2024/data/datasources/auth_remote_datasource.dart';
import 'package:training_2024/pages/home_page.dart';
import 'package:training_2024/presentation/auth/bloc/login/login_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/register/register_bloc.dart';
import 'package:training_2024/presentation/auth/login_page.dart';
import 'package:training_2024/theme.dart';
import 'package:training_2024/widgets/note_logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            drawerTheme: DrawerThemeData(
              backgroundColor: StyleCustome.yellow,
            ),
            primaryColor: StyleCustome.green,
            scaffoldBackgroundColor: StyleCustome.yellow,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: StyleCustome.green,
                  foregroundColor: StyleCustome.yellow),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: StyleCustome.yellow),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: StyleCustome.yellow),
              // centerTitle: true,
              backgroundColor: StyleCustome.green,
              titleTextStyle: const TextStyle(
                color: StyleCustome.yellow,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: StyleCustome.green,
              selectedItemColor: StyleCustome.blue,
              unselectedItemColor: StyleCustome.yellow,
            )),
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: ListView(
                  children: const [
                    SizedBox(
                      height: 64,
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: StyleCustome.green,
                      ),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              return snapshot.data! ? const HomePage() : const LoginPage();
            }
            return Scaffold(
              body: ListView(
                children: const [
                  SizedBox(
                    height: 64,
                  ),
                  NoteLogo(),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "IDN Notes App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: StyleCustome.green,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: StyleCustome.green,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
