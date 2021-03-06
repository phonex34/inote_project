import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:inote_project/modules/authentication/authentication.dart';
import 'package:inote_project/router/app_pages.dart';

class HomeScreen extends StatelessWidget {
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  // }

  static GetPage get route {
    return GetPage(name: AppRoutes.HOME, page: () => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.bloc<AuthenticationBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .bloc<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 4.0),
            Text(user.email, style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user.name ?? '', style: textTheme.headline5),
            Center(
              child: Container(
                height: 100,
                width: 100,
                child: RaisedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.PAGE1);
                    },
                    child: null),
              ),
            )
          ],
        ),
      ),
    );
  }
}
