part of 'update_note_bloc.dart';

@immutable
sealed class UpdateNoteEvent {}

class UpdateNotePressedButton extends UpdateNoteEvent {
  final int id;
  final String title;
  final String content;
  final bool isPinned;

  UpdateNotePressedButton({
    required this.id,
    required this.title,
    required this.content,
    required this.isPinned,
  });
}
