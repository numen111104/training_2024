import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:training_2024/presentation/auth/bloc/add_note/add_note_bloc.dart';
import 'package:training_2024/presentation/notes/notes_page.dart';
import 'package:training_2024/widgets/custom_text_field.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isPinned = false;
  XFile? image;

  void isPinHandler(bool value) {
    setState(() {
      isPinned = value;
    });
  }

  //image picker handler
  void imagePickerHandler() async {
    final XFile? _image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = _image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Note"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              //image preview
              if (image != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.file(
                    File(image!.path),
                  ),
                ),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                controller: _titleController,
                labelText: "Title",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Title';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _contentController,
                labelText: "Content",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Content';
                  }
                  return null;
                },
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
              //image picker
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text("Pick Image"),
                    const Spacer(),
                    IconButton(
                      onPressed: imagePickerHandler,
                      icon: const Icon(Icons.image),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: BlocConsumer<AddNoteBloc, AddNoteState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is AddNoteSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Note added successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const NotesPage(),
                        ),
                        (route) => false,
                      );
                    }
                    if (state is AddNoteFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AddNoteLoading) {
                      return Center(
                        child: Lottie.asset(
                          "assets/loading.json",
                          width: 38,
                          height: 38,
                          fit: BoxFit.fill,
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() != true) {
                          return;
                        }
                        context.read<AddNoteBloc>().add(
                              AddNoteButtonPressed(
                                title: _titleController.text,
                                content: _contentController.text,
                                isPinned: isPinned,
                                image: image,
                              ),
                            );
                      },
                      child: const Text("Save"),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}
