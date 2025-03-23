import 'package:flutter_cv_page/data/datasources/cv_local_data_sources.dart';
import 'package:flutter_cv_page/data/repositories/cv_repository_impl.dart';
import 'package:flutter_cv_page/domain/repositories/cv_repository.dart';
import 'package:flutter_cv_page/domain/usecases/profile_usecase.dart';
import 'package:flutter_cv_page/domain/usecases/social_usecase.dart';
import 'package:flutter_cv_page/domain/usecases/work_experience_usecase.dart';
import 'package:flutter_cv_page/presentation/bloc/cv_bloc.dart';
import 'package:flutter_cv_page/widgets/cubit/hover_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Blocs
  locator.registerFactory(
    () => CVBloc(
      getProfileUseCase: locator(),
      getSocialsUseCase: locator(),
      getWorkExperiencesUseCase: locator(),
    ),
  );

  // Cubits
  locator.registerFactory(() => HoverCubit());

  // CV Usecases
  locator.registerLazySingleton(() => GetProfile(locator()));
  locator.registerLazySingleton(() => GetSocials(locator()));
  locator.registerLazySingleton(() => GetWorkExperiences(locator()));

  // Repositories
  locator.registerLazySingleton<CVRepository>(
    () => CVRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // Data Sources
  locator.registerLazySingleton<CVLocalDataSource>(
    () => CVLocalDataSourceImpl(),
  );
}
