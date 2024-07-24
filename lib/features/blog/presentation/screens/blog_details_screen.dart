import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/uitls/calculate_reading_time.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'By ${blog.posterName}',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              '${blog.updatedAt} . ${calculateReadingTime(blog.content)} min',
              style: const TextStyle(
                color: AppPallete.greyColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network('https://hpyhycuhxoqdjzkpbpag.supabase.co/storage/v1/object/public/blog_images/0309bcd0-49db-11ef-9fb0-0d6785907b1e'),
            ),
          ],
        ),
      ),
    );
  }
}
