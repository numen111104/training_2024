import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_2024/data/models/responses/note_response_model.dart';
import 'package:training_2024/presentation/auth/bloc/update_note/update_note_bloc.dart';
import 'package:training_2024/presentation/notes/notes_page.dart';
import 'package:training_2024/widgets/custom_text_field.dart';
import 'package:training_2024/widgets/loading_button.dart';

class EditPage extends StatefulWidget {
  final Note note;
  const EditPage({
    super.key,
    required this.note,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isPinned = false;

  void isPinHandler(bool value) {
    setState(() {
      isPinned = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _titleController.text = widget.note.title!;
    _contentController.text = widget.note.content!;
    isPinned = widget.note.isPinned! == 1 ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            controller: _titleController,
            labelText: "Title",
          ),
          CustomTextField(
            controller: _contentController,
            labelText: "Content",
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text("Is Pinned?"),
                const Spacer(),
                Switch(
                  value: isPinned,
                  onChanged: isPinHandler,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlocConsumer<UpdateNoteBloc, UpdateNoteState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is UpdateNoteSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Update Note Successfully"),
                    ),
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotesPage()));
                }
                if (state is UpdateNoteFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is UpdateNoteLoading) {
                  return const LoadingButton();
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<UpdateNoteBloc>().add(
                          UpdateNotePressedButton(
                            id: widget.note.id!,
                            title: _titleController.text,
                            content: _contentController.text,
                            isPinned: isPinned,
                          ),
                        );
                  },
                  child: const Text("Update"),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
