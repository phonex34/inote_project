import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:get/get.dart';
import 'package:inote_project/modules/authentication/authentication.dart';
import 'package:inote_project/router/app_pages.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return Bloc.RepositoryProvider.value(
      value: authenticationRepository,
      child: Bloc.BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  // final _navigatorKey = GlobalKey<NavigatorState>();

  // NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // navigatorKey: _navigatorKey,
      defaultTransition: Transition.cupertino,
      builder: (context, child) {
        return Bloc.BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                Get.offAllNamed(AppRoutes.HOME, predicate: (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                // _navigator.pushAndRemoveUntil<void>(
                //   LoginScreen.route(),
                //   (route) => false,
                // );
                Get.offAllNamed(AppRoutes.LOGIN, predicate: (route) => false);

                break;
              default:
                break;
            }
            return Container();
          },
          child: child,
        );
      },
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      // initialRoute: InputDecoration,
      // onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
