part of 'write_bloc.dart';

@immutable
sealed class WriteState {}

abstract class WriteActionState extends WriteState {}

final class WriteInitial extends WriteState {}

final class WriteLoading extends WriteState {}

class WriteSucess extends WriteState {
  final String buttonName;
  WriteSucess({required this.buttonName});
}

class BackToHome extends WriteActionState {}

final class WriteError extends WriteActionState {}
