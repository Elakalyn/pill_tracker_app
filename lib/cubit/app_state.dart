part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class DateChangeState extends AppState {}
final class MedTypeSelectionState extends AppState {}
final class MedTimeChangeState extends AppState {}
