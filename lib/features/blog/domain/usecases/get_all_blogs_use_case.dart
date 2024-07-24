import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogsUseCase(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
