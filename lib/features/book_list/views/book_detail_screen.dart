import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Description"),centerTitle: true,backgroundColor: Colors.brown[300],foregroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'book-image-${book.title}',
              child: Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/${book.imageURL}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 0),
            Text('Title: ${book.title}'),
            Text('Author: ${book.author}'),
            Text('Description: ${book.description}'),
          ],
        ),
      ),
    );
  }
}
