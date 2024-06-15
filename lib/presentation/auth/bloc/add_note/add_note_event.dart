part of 'add_note_bloc.dart';

@immutable
sealed class AddNoteEvent {}

class AddNoteButtonPressed extends AddNoteEvent {
  final String title;
  final String content;
  final bool isPinned;
  final XFile? image;

  AddNoteButtonPressed({
    required this.title,
    required this.content,
    required this.isPinned,
    this.image,
  });
}
