import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/book_cubit.dart';
import '../models/book.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(book.imageURL),
        ),
        const SizedBox(height:20),
        Text('Title: ${book.title}'),Text('Author: ${book.author}'),
        Text('Description: ${book.description}'),
      ],),),
    );
  }
}