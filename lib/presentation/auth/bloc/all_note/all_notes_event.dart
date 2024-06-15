part of 'all_notes_bloc.dart';

@immutable
sealed class AllNotesEvent {}

 final class GetAllNotes extends AllNotesEvent {}