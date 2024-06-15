import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:training_2024/data/datasources/note_remote_datasource.dart';
import 'package:training_2024/data/models/responses/note_response_model.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NoteRemoteDatasource remote;
  AddNoteBloc(
    this.remote,
  ) : super(AddNoteInitial()) {
    on<AddNoteButtonPressed>((event, emit) async {
      emit(AddNoteLoading());
      final result = await remote.addNote(
        event.title,
        event.content,
        event.isPinned,
        event.image,
      );

      result.fold(
        (error) => emit(
          AddNoteFailed(message: error),
        ),
        (succes) => emit(
          AddNoteSuccess(data: succes),
        ),
      );
    });
  }
}
