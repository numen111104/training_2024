import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_2024/data/datasources/note_remote_datasource.dart';

part 'delete_note_event.dart';
part 'delete_note_state.dart';

class DeleteNoteBloc extends Bloc<DeleteNoteEvent, DeleteNoteState> {
  final NoteRemoteDatasource remote;
  DeleteNoteBloc(
    this.remote,
  ) : super(DeleteNoteInitial()) {
    on<DeleteNoteButtonPressed>((event, emit) async {
      emit(DeleteNoteLoading());
      final result = await remote.deleteNotes(
        event.id,
      );
      result.fold(
        (error) => emit(
          DeleteNoteFailed(
            message: error,
          ),
        ),
        (success) => emit(
          DeleteNoteSuccess(
            message: success,
          ),
        ),
      );
    });
  }
}
