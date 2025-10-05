import 'dart:convert';

import 'package:zajel_hub/constants.dart';
import 'package:zajel_hub/core/services/shared_preferences_singleton.dart';
import 'package:zajel_hub/features/auth/data/models/user_model.dart';
import 'package:zajel_hub/features/auth/domain/entites/user_entity.dart';

UserEntity getUser() {
  var jsonString = Prefs.getString(kUserData);
  var userEntity = UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}
