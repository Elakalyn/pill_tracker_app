import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Modules/Home/home.dart';
import 'cubit/app_cubit.dart';
import 'firebase_options.dart';
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            
            return MaterialApp(
              
              title: 'Flutter Demo',
              home: HomeScreen(),
              debugShowCheckedModeBanner: false,
            );
          },
        ));
  }
}
