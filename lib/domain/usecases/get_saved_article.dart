import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/entities/article.dart';
import 'package:flutter_application_prgrado/domain/repository/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
