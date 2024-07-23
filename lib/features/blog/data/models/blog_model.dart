import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.contet,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });
}
