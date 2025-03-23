import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_cv_page/data/models/profile_model.dart';
import 'package:flutter_cv_page/utils/exception.dart';

abstract class CVLocalDataSource {
  Future<ProfileModel> profile();
  Future<List<Map<String, dynamic>>> socials();
  Future<List<Map<String, dynamic>>> workExperiences();
}

class CVLocalDataSourceImpl implements CVLocalDataSource {
  @override
  Future<ProfileModel> profile() async {
    try {
      final String jsonString = await rootBundle.loadString('cv/profile.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return ProfileModel.fromJson(jsonMap);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> socials() async {
    try {
      final String jsonString = await rootBundle.loadString('cv/socials.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return List<Map<String, dynamic>>.from(jsonList);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> workExperiences() async {
    try {
      final String jsonString =
          await rootBundle.loadString('cv/experiences.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return List<Map<String, dynamic>>.from(jsonList);
    } catch (e) {
      throw CacheException();
    }
  }
}
