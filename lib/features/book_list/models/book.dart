import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String title;
  final String author;
  final String description;
  final String imageURL;

  const Book({
    required this.title,
    required this.author,
    required this.description,
    required this.imageURL,
  });

  @override
  List<Object?> get props => [title, author, description, imageURL];
}
