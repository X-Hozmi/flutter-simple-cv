import 'package:equatable/equatable.dart';
import 'package:flutter_cv_page/domain/entities/profile_entity.dart';

class ProfileModel extends Equatable {
  final Map<String, dynamic> profile;
  final List<String> competencies;
  final List<String> stacks;
  final List<Map<String, dynamic>> educations;

  const ProfileModel({
    required this.profile,
    required this.competencies,
    required this.stacks,
    required this.educations,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      profile: Map<String, dynamic>.from(json['data']['profile']),
      competencies: List<String>.from(json['data']['competencies']),
      stacks: List<String>.from(json['data']['stacks']),
      educations: List<Map<String, dynamic>>.from(json['data']['educations']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile,
      'competencies': competencies,
      'stacks': stacks,
      'educations': educations,
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      profile: profile,
      competencies: competencies,
      stacks: stacks,
      educations: educations,
    );
  }

  @override
  List<Object?> get props => [profile, competencies, stacks, educations];
}
