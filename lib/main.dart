import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/book_list/cubit/book_cubit.dart';
import 'features/book_list/views/book_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cubit Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: BlocProvider(
        create: (context)=> BookCubit(),
      child: const BookListScreen(),
      ),
    );
  }
}
 
