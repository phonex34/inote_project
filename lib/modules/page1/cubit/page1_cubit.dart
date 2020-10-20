import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:inote_project/models/generic_pagination.dart';
import 'package:inote_project/models/user.dart';
import 'package:inote_project/repository/page_repository.dart';
import 'package:loading_hud/loading_hud.dart';
import 'package:get/get.dart';

part 'page1_state.dart';

class Page1Cubit extends Cubit<Page1State> {
  Page1Cubit(this._repo)
      : assert(_repo != null),
        super(Page1Initial());
  final PageRepository _repo;
  final _loadingHud = Get.find<LoadingHud>();

  Future<void> initData() async {
    // _loadingHud.show();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // fetch data
      _loadingHud.show();
    });

    try {
      final a = await _repo.getAllListNews();
      _loadingHud.dismiss();
      return;
    } catch (e) {
      print(e);
    }
  }
}
