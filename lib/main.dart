// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:training_2024/data/datasources/auth_local_datasource.dart';
import 'package:training_2024/data/datasources/auth_remote_datasource.dart';
import 'package:training_2024/data/datasources/note_remote_datasource.dart';
import 'package:training_2024/presentation/auth/bloc/add_note/add_note_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/all_note/all_notes_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/delete_note/delete_note_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/login/login_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/register/register_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/update_note/update_note_bloc.dart';
import 'package:training_2024/presentation/auth/login_page.dart';
import 'package:training_2024/presentation/notes/notes_page.dart';
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
          create: (context) => RegisterBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AddNoteBloc(
            NoteRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => AllNotesBloc(
            NoteRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteNoteBloc(
            NoteRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateNoteBloc(
            NoteRemoteDatasource(),
          ),
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
                foregroundColor: StyleCustome.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: StyleCustome.green,
                foregroundColor: StyleCustome.yellow,
                focusColor: StyleCustome.darkYellow),
            switchTheme: SwitchThemeData(
              thumbColor: WidgetStateProperty.all(StyleCustome.green),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: StyleCustome.yellow),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: StyleCustome.yellow),
              centerTitle: false,
              backgroundColor: StyleCustome.green,
              titleTextStyle: const TextStyle(
                color: StyleCustome.yellow,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: StyleCustome.green,
              selectedItemColor: StyleCustome.darkYellow,
              unselectedItemColor: StyleCustome.yellow,
            )),
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    const NoteLogo(),
                    const Text(
                      "IDN Notes App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: StyleCustome.green,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Lottie.asset(
                          "assets/loading.json",
                          width: 80,
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              return snapshot.data! ? const NotesPage() : const LoginPage();
            }
            return Scaffold(
              body: ListView(
                children: const [
                  SizedBox(height: 32),
                  NoteLogo(),
                  SizedBox(height: 16),
                  Text(
                    "IDN Notes App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: StyleCustome.green,
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: CircularProgressIndicator(
                        color: StyleCustome.green,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
