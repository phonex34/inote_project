import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:inote_project/app.dart';
import 'package:inote_project/utilities/injection.dart';
import 'package:inote_project/utilities/simple_bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

class EnvironmentConfig {
  static const APP_NAME =
      String.fromEnvironment('DEFINE_APP_NAME', defaultValue: 'iNote');

  static const APP_SUFFIX = String.fromEnvironment('DEFINE_APP_SUFFIX');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  print('APP_NAME: ${EnvironmentConfig.APP_NAME}\n');
  print('APP_SUFFIX: ${EnvironmentConfig.APP_SUFFIX}\n');
  await configureDependencies();
  Bloc.observer = SimpleBlocObserver();
  runApp(App(authenticationRepository: AuthenticationRepository()));
}
