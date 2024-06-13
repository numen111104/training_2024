import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_2024/data/datasources/auth_local_datasource.dart';
import 'package:training_2024/data/datasources/auth_remote_datasource.dart';
import 'package:training_2024/data/models/responses/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource remote;
  LoginBloc(this.remote) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      final response = await remote.login(event.email, event.password);
      response.fold(
        (error) => emit(LoginFailed(message: error)),
        (success) {
          AuthLocalDatasource().saveAuthData(success);
          emit(
            LoginSucces(data: success),
          );
        },
      );
    });
  }
}
