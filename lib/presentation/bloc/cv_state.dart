part of 'cv_bloc.dart';

class CVState extends Equatable {
  final RequestState state;
  final String message;
  final ProfileEntity? profileEntity;
  final List<Map<String, dynamic>> socials;
  final List<Map<String, dynamic>> workExperiences;

  const CVState({
    required this.state,
    required this.message,
    required this.profileEntity,
    required this.socials,
    required this.workExperiences,
  });

  CVState copyWith({
    RequestState? state,
    String? message,
    ProfileEntity? profileEntity,
    List<Map<String, dynamic>>? socials,
    List<Map<String, dynamic>>? workExperiences,
  }) {
    return CVState(
      state: state ?? this.state,
      message: message ?? this.message,
      profileEntity: profileEntity ?? this.profileEntity,
      socials: socials ?? this.socials,
      workExperiences: workExperiences ?? this.workExperiences,
    );
  }

  @override
  List<Object?> get props => [
        state,
        message,
        profileEntity,
        socials,
        workExperiences,
      ];

  factory CVState.initial() {
    return const CVState(
      state: RequestState.initial,
      message: '',
      profileEntity: null,
      socials: [{}],
      workExperiences: [{}],
    );
  }
}
