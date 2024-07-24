import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogDetailsScreen extends StatelessWidget {
  final Blog blog;
  const BlogDetailsScreen({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(blog.title)
        ],
      ),
    );
  }
}
