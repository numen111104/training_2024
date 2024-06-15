import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_2024/data/datasources/note_remote_datasource.dart';
import 'package:training_2024/data/models/responses/note_response_model.dart';

part 'update_note_event.dart';
part 'update_note_state.dart';

class UpdateNoteBloc extends Bloc<UpdateNoteEvent, UpdateNoteState> {
  final NoteRemoteDatasource remote;
  UpdateNoteBloc(
    this.remote,
  ) : super(UpdateNoteInitial()) {
    on<UpdateNotePressedButton>((event, emit) async {
      emit(UpdateNoteLoading());
      final result = await remote.updateNotes(
        event.id,
        event.title,
        event.content,
        event.isPinned,
      );
      result.fold(
        (error) => emit(
          UpdateNoteFailed(message: error),
        ),
        (success) => emit(
          UpdateNoteSuccess(note: success),
        ),
      );
    });
  }
}
