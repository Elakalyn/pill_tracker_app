import 'package:flutter/material.dart';

class widgetTest extends StatelessWidget {
  const widgetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
  body: Center(
    child: Column(children: [
          Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(236, 237, 239, 1)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Your plan is almost done!',
                         
                          style: TextStyle(
                              fontSize: 24,
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
                              '13% more than a week ago',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(140, 142, 151, 1)),
                            ),
                          ],
                        )
                      ],
                    )
                  ]),
                ),
              ),
         
    ]),
  ),
    );
  }
}