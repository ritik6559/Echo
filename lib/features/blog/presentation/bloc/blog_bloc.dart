import 'dart:io';

import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_use_case.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;

  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
    required GetAllBlogsUseCase getAllBlogsUseCase,
  })  : _getAllBlogsUseCase = getAllBlogsUseCase,
        _uploadBlogUseCase = uploadBlogUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));

    on<BlogUpload>(_onBlogUpload);

    on<BlogFetchAllBlogs>(_blogFetchAllBlogs);
  }

  void _blogFetchAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogsUseCase(NoParams());

    res.fold(
      (l) => emit(
        BlogFailure(l.message),
      ),
      (r) => emit(
        BlogDisplaySuccess(r),
      ),
    );
  }

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlogUseCase(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    res.fold(
      (l) => emit(
        BlogFailure(l.message),
      ),
      (r) => emit(
        BlogUploadSuccess(),
      ),
    );
  }
}
