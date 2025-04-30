import 'package:book_club/features/book_list/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit(): super(BookInitial()){
    loadBook();
  }

  Future<void> loadBook() async {
    emit(BookLoading());
    try{
      await Future.delayed(const Duration(seconds: 2));

      final book = [
        const Book(title: 'Catcher in the Rye', author: 'JD Sallinger', description: 'abc',imageURL: '../../assets/catcher_in_the_rye.jpg'),
        const Book(title: 'MoneyBall', author: 'Michael Lewis', description:'basebol',imageURL: '../../assets/money_ball.jpg'),
        const Book(title: 'Lord of the Rings', author: "J.R.R Tolkien ", description:"magic",imageURL: '../../assets/money_ball.jpg'),
        const Book(title: 'The Great Gatsby', author: 'F. Scott. Fitzgerald', description:"wealth",
        imageURL:'../../assets/money_ball.jpg'),
      ];  

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