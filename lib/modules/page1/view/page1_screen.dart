import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:inote_project/modules/page1/cubit/page1_cubit.dart';
import 'package:inote_project/repository/page_repository.dart';
import 'package:inote_project/router/app_pages.dart';
import 'package:inote_project/utilities/network_exception.dart';
import 'package:inote_project/utilities/result_state.dart';

class Page1Screen extends StatelessWidget {
  const Page1Screen({Key key}) : super(key: key);
  static GetPage get route {
    return GetPage(
      name: AppRoutes.PAGE1,
      page: () => Page1Screen(),
      binding:
          BindingsBuilder(() => {Get.put<PageRepository>(PageRepository())}),
    );
  }

  @override
  Widget build(BuildContext context) {
    PageRepository _repo = Get.find<PageRepository>();
    return BlocProvider(
        create: (context) => Page1Cubit(_repo)..postData(),
        child: Scaffold(
          appBar: AppBar(title: Text("test")),
          body: BlocBuilder<Page1Cubit, ResultState<dynamic>>(
            builder: (context, state) {
              return state.when(loading: () {
                return Center(child: CircularProgressIndicator());
              }, idle: () {
                return Container();
              }, data: (data) {
                // return dataWidget(data);
                return Container(color: Colors.red);
              }, error: (NetworkExceptions error) {
                return Center(
                    child: Text(NetworkExceptions.getErrorMessage(error)));
              });
            },
          ),
        ));
  }
}
