import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_tracker_app/cubit/app_cubit.dart';

import '../../Shared/Constants/constants.dart';

var medType;
var medTypeValidator = false;
var medName;
var medDose;
var selectedMedType;
var doseCount = 1;
var dex;
var days;
var reminders = false;
var reminder5mColor = Color.fromRGBO(196, 202, 207, 1);
var reminder10mColor = Color.fromRGBO(196, 202, 207, 1);
var reminder15mColor = Color.fromRGBO(196, 202, 207, 1);
var reminder20mColor = Color.fromRGBO(196, 202, 207, 1);
var reminder30mColor = Color.fromRGBO(196, 202, 207, 1);
List<String> doses = [];
var validateDoses = false;

void incDose(context) {
  doseCount = doseCount + 1;
  print(doseCount);
  AppCubit.get(context).modifyDoses();
}

class addMedication extends StatelessWidget {
  const addMedication({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var formKey = GlobalKey<FormState>();
        var nc = TextEditingController();
        var dc = TextEditingController();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Step 1 out of 2:",
                      style: TextStyle(
                        color: Color.fromRGBO(140, 142, 151, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add medication",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedType = 1;
                          AppCubit.get(context).changeMedType();
                          print('tapped');
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(242, 246, 247, 1),
                                minRadius: 32,
                                maxRadius: 32,
                                child: Image.asset(
                                  'assets/images/tablet.png',
                                )),
                            if (selectedType == 1)
                              Positioned(
                                  left: 45,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color.fromRGBO(103, 183, 121, 1),
                                    size: 18,
                                  ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedType = 2;
                          AppCubit.get(context).changeMedType();
                          print('tapped');
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(242, 246, 247, 1),
                                minRadius: 32,
                                maxRadius: 32,
                                child: Image.asset(
                                  'assets/images/pill.png',
                                )),
                            if (selectedType == 2)
                              Positioned(
                                  left: 45,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color.fromRGBO(103, 183, 121, 1),
                                    size: 18,
                                  ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedType = 3;
                          AppCubit.get(context).changeMedType();
                          print('tapped');
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(242, 246, 247, 1),
                                minRadius: 32,
                                maxRadius: 32,
                                child: Image.asset(
                                  'assets/images/ampoule.png',
                                )),
                            if (selectedType == 3)
                              Positioned(
                                  left: 45,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color.fromRGBO(103, 183, 121, 1),
                                    size: 18,
                                  ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: medTypeValidator,
                    child: Text(
                        'Please select the type of your medication from the choices above.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the name of your medication.';
                      }
                      return null;
                    },
                    controller: nc,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(196, 202, 207, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please specify the doses of your medication.';
                      }
                      return null;
                    },
                    controller: dc,
                    decoration: InputDecoration(
                      hintText: 'e.g. Single dose, 1 tablet',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(196, 202, 207, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print(selectedType);
                        if (selectedType != null) {
                          print('med type not null');
                          if (formKey.currentState!.validate()) {
                            print('forms not not null');
                            if (selectedType == 1) {
                              medType = 'tablet';
                            } else if (selectedType == 2) {
                              medType = 'pill';
                            } else if (selectedType == 3) {
                              medType = 'ampoule';
                            }
                            medName = nc.text;
                            medDose = dc.text;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addMedication2()),
                            );
                          }
                        } else {
                          medTypeValidator = true;
                          AppCubit.get(context).changeMedType();
                        }
                      },
                      onLongPress: () {
                        medName = 'Test Medication';
                        medDose = 'Test Description';
                        medType = 'tablet';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addMedication2()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation:
                            0, // Set the elevation to 0 to remove the shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Color(
                            0xFF1892FA), // Set the hex color value as the button background color
                      ),
                      child: Text(
                        'Schedule',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class addMedication2 extends StatelessWidget {
  const addMedication2({super.key});

  @override
  Widget build(BuildContext context) {
    if (medType == 'tablet') {
      selectedMedType = Image.asset('assets/images/tablet.png');
    } else if (medType == 'pill') {
      selectedMedType = Image.asset('assets/images/pill.png');
    } else if (medType == 'ampoule') {
      selectedMedType = Image.asset('assets/images/ampoule.png');
    }

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Step 2 out of 2:",
                      style: TextStyle(
                        color: Color.fromRGBO(140, 142, 151, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Schedule",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        height: 115,
                        child: Row(
                          children: [
                            Container(
                              height: 115,
                              width: 5,
                              color: Color.fromRGBO(242, 246, 247, 1),
                            ),
                            Expanded(child: selectedMedType),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    medName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    medDose,
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
                                      '$days days left',
                                      style: TextStyle(
                                        color: Color.fromRGBO(196, 202, 207, 1),
                                        fontSize: 16,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: doseCount,
                          itemBuilder: (context, index) {
                            dex = index;
                            return doseWidget();
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: validateDoses,
                    child: Text('Please schedule the timing of your doses',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        incDose(context);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.black,
                        ),
                        backgroundColor: Color.fromRGBO(242, 246, 247, 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    width: double.maxFinite,
                    color: const Color.fromARGB(255, 196, 196, 196),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          initialValue: '0',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a time period for your medication.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          onFieldSubmitted: (v) {
                            days = v;
                            AppCubit.get(context).modifyDays();
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(196, 202, 207, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Days',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Reminders',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                          value: reminders,
                          onChanged: (v) {
                            reminders = v;
                            AppCubit.get(context).modifyReminders();
                          }),
                    ],
                  ),
                  Visibility(
                    visible: reminders,
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'in',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(196, 202, 207, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              reminder5mColor = Colors.black;
                              AppCubit.get(context).modifyReminders();
                            },
                            child: Text(
                              '5 m',
                              style: TextStyle(
                                fontSize: 20,
                                color: reminder5mColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              reminder10mColor = Colors.black;
                              AppCubit.get(context).modifyReminders();
                            },
                            child: Text(
                              '10 m',
                              style: TextStyle(
                                fontSize: 20,
                                color: reminder10mColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              reminder15mColor = Colors.black;
                              AppCubit.get(context).modifyReminders();
                            },
                            child: Text(
                              '15 m',
                              style: TextStyle(
                                fontSize: 20,
                                color: reminder15mColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              reminder20mColor = Colors.black;
                              AppCubit.get(context).modifyReminders();
                            },
                            child: Text(
                              '20 m',
                              style: TextStyle(
                                fontSize: 20,
                                color: reminder20mColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              reminder30mColor = Colors.black;
                              AppCubit.get(context).modifyReminders();
                            },
                            child: Text(
                              '30 m',
                              style: TextStyle(
                                fontSize: 20,
                                color: reminder30mColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (doses.isNotEmpty) {
                          AppCubit.get(context)
                              .medicationAdd(
                            date: today,
                            dose: medDose,
                            name: medName,
                            period: days,
                            time: doses.first,
                            type: medType,
                            doses: doses,
                          )
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            doses.clear();
                          });
                        } else {
                          validateDoses = true;
                          AppCubit.get(context).modifyDoses();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation:
                            0, // Set the elevation to 0 to remove the shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Color(
                            0xFF1892FA), // Set the hex color value as the button background color
                      ),
                      child: Text(
                        'Schedule',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class doseWidget extends StatefulWidget {
  const doseWidget({super.key});
  @override
  State<doseWidget> createState() => _doseWidgetState();
}

class _doseWidgetState extends State<doseWidget> {
  var doseSelectedTime;
  var adjustedIndex = dex + 1;

  @override
  void initState() {
    super.initState();
    doseSelectedTime = '00:00';
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () async {
            var picked = await showTimePicker(
              context: context,
              builder: (BuildContext context, var child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              setState(() {
                doseSelectedTime = picked.format(context);
                doses.add(doseSelectedTime);
                print(doseSelectedTime);
              });
            }
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
}
