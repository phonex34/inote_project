import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inote_project/repository/page_repository.dart';

part 'page1_state.dart';

class Page1Cubit extends Cubit<Page1State> {
  Page1Cubit(this._repo)
      : assert(_repo != null),
        super(Page1Initial());
  final PageRepository _repo;

  Future<void> initData() async {
    try {
      final a = await _repo.getAllListNews();
    } catch (e) {
      print(e);
    }
  }
}
