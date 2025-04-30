import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/book_cubit.dart';
import '../models/book.dart';
import '../views/book_detail_screen.dart';

class SortButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isActive;

  const SortButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.black87,
        backgroundColor: isActive ? Colors.blue : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: Icon(icon, size: 18),
      label: Text(text),
      onPressed: onPressed,
    );
  }
}

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book List (Cubit)')),
      body: Column(
        children: [
          // Sorting controls
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<BookCubit, BookState>(
              builder: (context, state) {
                final isTitleSorted =
                    state is BookLoaded && _isListSortedByTitle(state.books);
                final isAuthorSorted =
                    state is BookLoaded && _isListSortedByAuthor(state.books);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SortButton(
                      icon: Icons.sort_by_alpha,
                      text: 'Title',
                      isActive: isTitleSorted,
                      onPressed: () => context.read<BookCubit>().sortByTitle(),
                    ),
                    const SizedBox(width: 8),
                    SortButton(
                      icon: Icons.person,
                      text: 'Author',
                      isActive: isAuthorSorted,
                      onPressed: () => context.read<BookCubit>().sortByAuthor(),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<BookCubit, BookState>(
              builder: (context, state) {
                if (state is BookInitial || state is BookLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookError) {
                  return Center(child: Text(state.message));
                } else if (state is BookLoaded) {
                  return _buildBookList(state.books, context);
                }
                return const Center(child: Text('No books available'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

bool _isListSortedByTitle(List<Book> books) {
  for (int i = 0; i < books.length - 1; i++) {
    if (books[i].title.compareTo(books[i + 1].title) > 0) {
      return false;
    }
  }
  return true;
}

bool _isListSortedByAuthor(List<Book> books) {
  for (int i = 0; i < books.length - 1; i++) {
    if (books[i].author.compareTo(books[i + 1].author) > 0) {
      return false;
    }
  }
  return true;
}

Widget _buildBookList(List<Book> books, BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: books.length,
    itemBuilder: (context, index) {
      final book = books[index];
      return Container(
        width: 160,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailScreen(book: book),
                    ),
                  );
                },
                child: Hero(
                  tag: 'book-image-${book.title}',
                  child: Container(
                    width: 140,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/${book.imageURL}'),
                      
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
