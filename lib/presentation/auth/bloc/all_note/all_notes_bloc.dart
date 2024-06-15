import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_2024/data/datasources/note_remote_datasource.dart';
import 'package:training_2024/data/models/responses/all_notes_response_model.dart';

part 'all_notes_event.dart';
part 'all_notes_state.dart';

class AllNotesBloc extends Bloc<AllNotesEvent, AllNotesState> {
  final NoteRemoteDatasource remote;
  AllNotesBloc(
    this.remote,
  ) : super(AllNotesInitial()) {
    on<GetAllNotes>((event, emit) async {
      emit(AllNotesLoading());
      final result = await remote.getAllNotes();
      result.fold(
        (error) => emit(
          AllNotesFailed(
            message: error,
          ),
        ),
        (success) => emit(
          AllNotesSuccess(
            data: success,
          ),
        ),
      );
    });
  }
}
