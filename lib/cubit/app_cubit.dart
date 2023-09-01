import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../Shared/Constants/constants.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  void changeDate() {
    emit(DateChangeState());
  }

  void changeMedType() {
    emit(MedTypeSelectionState());
  }

  Future<void> medicationAdd({
    required var date,
    required var dose,
    required var name,
    required var period,
    required var time,
    required var type,
    required var doses,
  }) async {
    CollectionReference parentCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference parentDocument = parentCollection.doc(user_id);
    CollectionReference subcollection = parentDocument.collection('meds');
    await subcollection.add({
      'date': date,
      'dose': dose,
      'name': name,
      'period': period,
      'time': time,
      'type': type,
      'doses': doses,
      'docID': null,
      'status': false,
    }).then((value) {
      final Map<String, dynamic> addID = {
        'docID': value.id,
      };
      subcollection.doc(value.id).update(addID);
      emit(AddMedicationState());
    });
  }

  void finishPill(id) {
    CollectionReference parentCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference parentDocument = parentCollection.doc(user_id);
    CollectionReference subcollection = parentDocument.collection('meds');
    final Map<String, dynamic> newData = {
      'status': true,
    };
    subcollection.doc(id).update(newData);
  }

  Widget doseWidget(context, index) {
    var doseSelectedTime = '00:00';
    var adjustedIndex = index + 1;
    return Row(
      children: [
        Text(
          'Dose $adjustedIndex',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            changeMedTime(context);
          },
          child: Text(
            doseSelectedTime,
            style: TextStyle(
              color: Color.fromRGBO(196, 202, 207, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Future<void> changeMedTime(context) async {
    var picked = await showTimePicker(
      context: context,
      builder: (BuildContext context, var child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      print(context);
    }
    emit(MedTimeChangeState());
  }

  void modifyDoses() async {
    emit(MedDoseModificationState());
  }

  void modifyDays() async {
    emit(MedDoseModificationState());
  }

  void modifyReminders() async {
    emit(MedDoseModificationState());
  }

  void pillSwipe() async {
    emit(pillSwipeState());
  }
}
