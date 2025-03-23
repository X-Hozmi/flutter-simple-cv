part of 'cv_bloc.dart';

abstract class CVEvent extends Equatable {
  const CVEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

class GetProfileEvent extends CVEvent {
  const GetProfileEvent();

  @override
  List<Object> get props => [];
}

class GetSocialsEvent extends CVEvent {
  const GetSocialsEvent();

  @override
  List<Object> get props => [];
}

class GetWorkExperiencesEvent extends CVEvent {
  const GetWorkExperiencesEvent();

  @override
  List<Object> get props => [];
}
