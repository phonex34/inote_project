import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:inote_project/modules/page1/cubit/page1_cubit.dart';
import 'package:inote_project/repository/page_repository.dart';
import 'package:inote_project/router/app_pages.dart';

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
      create: (context) => Page1Cubit(_repo)..initData(),
      child: BlocListener<Page1Cubit, Page1State>(
        listener: (context, state) {
          // TODO: implement listener
          final cubit = context.bloc<Page1Cubit>();
          switch (state.runtimeType) {
            case Page1Initial:
              cubit.initData();
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text("test")),
          body: Container(color: Colors.red),
        ),
      ),
    );
  }
}
