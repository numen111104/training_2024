import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_2024/data/datasources/auth_local_datasource.dart';
import 'package:training_2024/data/datasources/auth_remote_datasource.dart';
import 'package:training_2024/data/models/request/register_request_model.dart';
import 'package:training_2024/data/models/responses/auth_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource remote;
  RegisterBloc(this.remote) : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      final response = await remote.registerUser(event.data);
      response.fold(
        (error) => emit(RegisterFailed(message: error)),
        (succes) {
          AuthLocalDatasource().saveAuthData(succes);
          emit(RegisterSucces(data: succes));
        });
    });
  }
}
