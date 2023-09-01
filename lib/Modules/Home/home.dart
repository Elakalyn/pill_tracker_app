// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../Shared/Constants/constants.dart';
import '../../cubit/app_cubit.dart';
import '../Add Medications/add_medication.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');
        DocumentReference userDocumentRef = usersCollection.doc(user_id);
        dynamic medsCollectionRef = userDocumentRef
            .collection('meds')
            .where('date', isEqualTo: today)
            .where('status', isEqualTo: false);

        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addMedication()),
                  );
                },
                child: Icon(Icons.add_rounded),
                elevation: 0),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hey, UserName!',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(140, 142, 151, 1)),
                        ),
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.more_vert,
                                color: Color.fromRGBO(25, 29, 48, 1)),
                            onPressed: () {})
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          currentDay,
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        // This is the IconButton I'm talking about
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () async {
                            var selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100));
                            if (selectedDate != null) {
                              dynamic dayName =
                                  DateFormat('EEEE').format(selectedDate);

                              currentDay = dayName.toString();
                              DateFormat formatter = DateFormat('dd/MM/yyyy');
                              today = formatter.format(selectedDate);
                              print(dayName);
                              print(today);
                              AppCubit.get(context).changeDate();
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromRGBO(236, 237, 239, 1)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '''Your plan
is almost done!''',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.keyboard_arrow_up_outlined,
                                      color: Colors.lightGreen,
                                    ),
                                    Text(
                                      '13% than a week ago',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(140, 142, 151, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            SimpleCircularProgressBar(
                              maxValue: 100,
                              size: 85,
                              valueNotifier: ValueNotifier(78),
                              mergeMode: true,
                              progressColors: [
                                Color.fromRGBO(103, 183, 121, 1)
                              ],
                              backColor: Color.fromRGBO(233, 243, 225, 1),
                              onGetText: (double value) {
                                TextStyle centerTextStyle = TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(103, 183, 121, 1));

                                return Text(
                                  '${value.toInt()}%',
                                  style: centerTextStyle,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    StreamBuilder<QuerySnapshot>(
                        stream: medsCollectionRef.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          final QuerySnapshot? querySnapshot = snapshot.data;

                          if (querySnapshot == null) {
                            print('DATA DOES NOT EXIST.');
                            return Text(
                              'No data available',
                            );
                          }

                          return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final DocumentSnapshot<Object?> document =
                                    querySnapshot.docs[index];

                                return MedWidget(
                                  name: document['name'],
                                  dose: document['dose'],
                                  period: document['period'],
                                  type: document['type'],
                                  date: document['date'],
                                  time: document['time'],
                                  docID: document['docID'],
                                  status: document['status'],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                              itemCount: querySnapshot.docs.length);
                        }),
                    SizedBox(height: 65),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MedWidget extends StatelessWidget {
  MedWidget({
    super.key,
    required this.name,
    required this.dose,
    required this.period,
    required this.type,
    required this.date,
    required this.time,
    required this.docID,
    required this.status,
  });

  late var name;
  late var dose;
  late var period;
  late var type;
  late var date;
  late var time;
  late var docID;
  late var status;

  late Widget mImage;

  @override
  Widget build(BuildContext context) {
    if (type == 'pill') {
      mImage = Image.asset('assets/images/pill.png');
    } else if (type == 'tablet') {
      mImage = Image.asset('assets/images/tablet.png');
    } else if (type == 'ampoule') {
      mImage = Image.asset('assets/images/ampoule.png');
    }
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        height: 115,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(236, 237, 239, 1)),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Expanded(
          child: Icon(
            Icons.check,
            size: 48,
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).finishPill(docID);
        print('TAPPED');
      },
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 115,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(236, 237, 239, 1)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Row(
                children: [
                  Expanded(child: mImage),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          dose,
                          style: TextStyle(
                            color: Color.fromRGBO(140, 142, 151, 1),
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '$period days',
                            style: TextStyle(
                              color: Color.fromRGBO(140, 142, 151, 1),
                              fontSize: 16,
                            ),
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
