import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:training_2024/data/datasources/config.dart';
import 'package:training_2024/presentation/auth/bloc/all_note/all_notes_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/delete_note/delete_note_bloc.dart';
import 'package:training_2024/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:training_2024/presentation/auth/login_page.dart';
import 'package:training_2024/presentation/notes/add_page.dart';
import 'package:training_2024/presentation/notes/detail_page.dart';
import 'package:training_2024/theme.dart';
import 'package:training_2024/widgets/note_logo.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    context.read<AllNotesBloc>().add(GetAllNotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Notes"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                if (state is LogoutSucces) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
                  return Lottie.asset(
                    "assets/loading.json",
                    width: 38,
                    height: 38,
                    fit: BoxFit.fill,
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
        body: BlocBuilder<AllNotesBloc, AllNotesState>(
          builder: (context, state) {
            if (state is AllNotesLoading) {
              return Center(
                child: Lottie.asset(
                  "assets/loading.json",
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
              );
            }
            if (state is AllNotesFailed) {
              return const Center(
                child: Text("Failed to load notes"),
              );
            }
            if (state is AllNotesSuccess) {
              if (state.data.data!.isEmpty) {
                return const Center(
                  child: Text("Empty T_T"),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final note = state.data.data![index];
                  return Container(
                    key: ValueKey(note.id),
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: StyleCustome.darkYellow,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (note.image != null)
                          Hero(
                            tag: note.id!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                '${Config.baseUrl}/images/${note.image!}',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, _, __) {
                                  return Image.asset(
                                    "assets/logo/notes.png",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note.title!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                note.content!.length < 15
                                    ? note.content!
                                    : "${note.content!.substring(0, 15)}...",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BlocConsumer<DeleteNoteBloc, DeleteNoteState>(
                                listener: (context, state) {
                                  if (state is DeleteNoteSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Note Deleted Successfully"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    context
                                        .read<AllNotesBloc>()
                                        .add(GetAllNotes());
                                  }
                                  if (state is DeleteNoteFailed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.message),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is DeleteNoteLoading) {
                                    return Center(
                                      child: Lottie.asset(
                                        "assets/loading.json",
                                        width: 38,
                                        height: 38,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }
                                  return IconButton(
                                    onPressed: () {
                                      context.read<DeleteNoteBloc>().add(
                                          DeleteNoteButtonPressed(
                                              id: note.id!));
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.redAccent,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailPage(note: note);
                                  }));
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.data.data!.length,
              );
            }
            return ListView(children: const [
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
            ]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
