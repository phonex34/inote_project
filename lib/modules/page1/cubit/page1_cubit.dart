import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:inote_project/models/generic_pagination.dart';
import 'package:inote_project/models/user.dart';
import 'package:inote_project/repository/page_repository.dart';
import 'package:inote_project/utilities/network_exception.dart';
import 'package:inote_project/utilities/result_state.dart';
import 'package:loading_hud/loading_hud.dart';
import 'package:get/get.dart';

part 'page1_state.dart';

class Page1Cubit extends Cubit<ResultState<dynamic>> {
  Page1Cubit(this._repo)
      : assert(_repo != null),
        super(Idle());
  final PageRepository _repo;
  final _loadingHud = Get.find<LoadingHud>();

  Future<void> initData() async {
    // _loadingHud.show();
    emit(ResultState.loading());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // fetch data
      _loadingHud.show();
    });
    try {
      final data = await _repo.getAllListNewsFailed();
      _loadingHud.dismiss();
      emit(ResultState.data(data: data));
      return;
    } catch (e) {
      _loadingHud.dismiss();
      emit(ResultState.error(error: NetworkExceptions.getDioException(e)));
    }
  }

  Future<void> postData() async {
    // _loadingHud.show();
    emit(ResultState.loading());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // fetch data
      _loadingHud.show();
    });
    try {
      final data = await _repo.postData();
      _loadingHud.dismiss();
      emit(ResultState.data(data: data));
      return;
    } catch (e) {
      _loadingHud.dismiss();
      emit(ResultState.error(error: NetworkExceptions.getDioException(e)));
    }
  }
}
