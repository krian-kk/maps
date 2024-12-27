part of 'user_bloc.dart';

@immutable
sealed class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> user;

  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
