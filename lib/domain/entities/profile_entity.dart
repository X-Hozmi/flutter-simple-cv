import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final Map<String, dynamic> profile;
  final List<String> competencies;
  final List<String> stacks;
  final List<Map<String, dynamic>> educations;

  const ProfileEntity({
    required this.profile,
    required this.competencies,
    required this.stacks,
    required this.educations,
  });

  @override
  List<Object?> get props => [
        profile,
        competencies,
        stacks,
        educations,
      ];
}
