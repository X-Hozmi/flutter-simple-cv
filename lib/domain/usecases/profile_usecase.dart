import 'package:dartz/dartz.dart';
import 'package:flutter_cv_page/domain/entities/profile_entity.dart';
import 'package:flutter_cv_page/domain/repositories/cv_repository.dart';
import 'package:flutter_cv_page/utils/failure.dart';

class GetProfile {
  final CVRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, ProfileEntity>> execute() {
    return repository.profile();
  }
}
