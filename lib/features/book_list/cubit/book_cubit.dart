import 'package:book_club/features/book_list/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit(): super(BookInitial()){
    init();
  }

  void init(){
    loadBook();
  }

  Future<void> loadBook() async {
    emit(BookLoading());
    try{
      await Future.delayed(const Duration(seconds: 2));

      final book = [
        Book(title: 'Catcher in the Rye', author: 'JD Sallinger', description: lorem(paragraphs: 1,words: 30),imageURL: 'catcher_in_the_rye.jpg'),
        Book(title: 'MoneyBall', author: 'Michael Lewis', description:lorem(paragraphs: 1,words: 30),imageURL: 'money_ball.jpg'),
        Book(title: 'Lord of the Rings', author: "J.R.R Tolkien ", description:lorem(paragraphs: 1,words: 30),imageURL: 'lord_of_the_rings.jpg'),
        Book(title: 'The Great Gatsby', author: 'F. Scott. Fitzgerald', description:lorem(paragraphs: 1,words: 30),
        imageURL:'the_great_gatsby.jpg'),
      ];  

      book.sort((a,b) => a.author.compareTo(b.author));
      emit(BookLoaded(book));
    } catch (e) {
      emit(BookError('Failed to load books: $e'));
    }
  }
  void sortByTitle() {
    if (state is BookLoaded) {
      final book = (state as BookLoaded).books;
      emit(BookLoaded(
        List.from(book)..sort((a, b) => a.title.compareTo(b.title)),
      ));
    }
  }

  void sortByAuthor() {
    if (state is BookLoaded) {
      final book = (state as BookLoaded).books;
      emit(BookLoaded(
        List.from(book)..sort((a, b) => a.author.compareTo(b.author)),
      ));
    }
  }
}