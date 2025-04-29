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
        const Book(title: 'Catcher in the Rye', author: 'JD Sallinger', description: 'abc'),
        const Book(title: 'MoneyBall', author: 'Michael Lewis', description:'basebol'),
        const Book(title: 'Lord of the Rings', author: "J.R.R Tolkien ", description:"magic"),
        const Book(title: 'The Great Gatsby', author: 'F. Scott. Fitzgerald', description:"wealth"),
      ];  

      emit(BookLoaded(book));
    } catch (e) {
      emit(BookError('Failed to load books: $e'));
    }
  }
}