import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  
  void changeDate(){
    emit(DateChangeState());
  }
void changeMedType(){
    emit(MedTypeSelectionState());
  }
  void changeMedTime(){
    emit(MedTimeChangeState());
  }
  void modifyDoses()
  {
    emit(MedDoseModificationState());
  }
    var sdate;
}
