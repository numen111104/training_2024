part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterSucces extends RegisterState {
  final Data data;
  RegisterSucces({required this.data});
}

final class RegisterFailed extends RegisterState {
  final String message;
  RegisterFailed({required this.message});
}
