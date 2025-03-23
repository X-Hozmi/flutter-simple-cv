import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv_page/domain/entities/profile_entity.dart';
import 'package:flutter_cv_page/domain/usecases/profile_usecase.dart';
import 'package:flutter_cv_page/domain/usecases/social_usecase.dart';
import 'package:flutter_cv_page/domain/usecases/work_experience_usecase.dart';
import 'package:flutter_cv_page/utils/state_enum.dart';

part 'cv_event.dart';
part 'cv_state.dart';

class CVBloc extends Bloc<CVEvent, CVState> {
  final GetProfile getProfileUseCase;
  final GetSocials getSocialsUseCase;
  final GetWorkExperiences getWorkExperiencesUseCase;

  CVBloc({
    required this.getProfileUseCase,
    required this.getSocialsUseCase,
    required this.getWorkExperiencesUseCase,
  }) : super(CVState.initial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final result = await getProfileUseCase.execute();

      await result.fold(
        (failure) async {
          emit(state.copyWith(
            state: RequestState.error,
            message: failure.message,
          ));
        },
        (success) async {
          emit(state.copyWith(
            state: RequestState.loaded,
            message: '',
            profileEntity: success,
          ));
        },
      );
    });

    on<GetSocialsEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final result = await getSocialsUseCase.execute();

      await result.fold(
        (failure) async {
          emit(state.copyWith(
            state: RequestState.error,
            message: failure.message,
          ));
        },
        (success) async {
          emit(state.copyWith(
            state: RequestState.loaded,
            message: '',
            socials: success,
          ));
        },
      );
    });

    on<GetWorkExperiencesEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final result = await getWorkExperiencesUseCase.execute();

      await result.fold(
        (failure) async {
          emit(state.copyWith(
            state: RequestState.error,
            message: failure.message,
          ));
        },
        (success) async {
          emit(state.copyWith(
            state: RequestState.loaded,
            message: '',
            workExperiences: success,
          ));
        },
      );
    });
  }
}
