import 'package:dartz/dartz.dart';
import 'package:flutter_cv_page/domain/repositories/cv_repository.dart';
import 'package:flutter_cv_page/utils/failure.dart';

class GetWorkExperiences {
  final CVRepository repository;

  GetWorkExperiences(this.repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> execute() {
    return repository.workExperiences();
  }
}
