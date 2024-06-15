import 'package:flutter/material.dart';
import 'package:training_2024/data/datasources/config.dart';
import 'package:training_2024/data/models/responses/note_response_model.dart';
import 'package:training_2024/presentation/notes/edit_page.dart';
import 'package:training_2024/theme.dart';

class DetailPage extends StatelessWidget {
  final Note note;

  const DetailPage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.title!,
        ),
        backgroundColor: StyleCustome.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (note.image != null) const SizedBox(height: 16),
            if (note.image != null)
              Text("Note Image", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            if (note.image != null)
              Hero(
                tag: note.id!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${Config.baseUrl}/images/${note.image!}',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text("Note", style: Theme.of(context).textTheme.titleLarge),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  note.content!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditPage(
                      note: note,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: StyleCustome.green,
              ),
              child: const Text(
                "Edit Note",
                style:  TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
