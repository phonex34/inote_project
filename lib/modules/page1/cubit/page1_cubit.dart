import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page1_state.dart';

class Page1Cubit extends Cubit<Page1State> {
  Page1Cubit() : super(Page1Initial());
}
