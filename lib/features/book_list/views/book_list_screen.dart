import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/book_cubit.dart';
import '../models/book.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List (Cubit)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: ()=> context.read<BookCubit>().loadBook(),
          ),
        ],
      ),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state){
          if(state is BookInitial || state is BookLoading){
            return const Center(child: CircularProgressIndicator());
          }else if (state is BookError){
            return Center(child: Text(state.message));
          }else if (state is BookLoaded){
            return _buildBookList(state.books, context);
          } else{
            return const Center(child: Text('Fuck'));
          }
        },)
    );
  }
}

Widget _buildBookList(List<Book> book, BuildContext context){
  return ListView.builder(
    itemCount: book.length,
    itemBuilder: (context, index){
      final b = book[index];
      return ListTile(
        leading: CircleAvatar(child: Text(b.title[0])),
        title: Text(b.title),
        subtitle: Text(b.author),
        onTap: () {
          // Navigation logic here
        },
      );
    },
  );
}
