import 'package:bloc/bloc.dart';
import 'package:get/get.dart' as Getx;
import 'package:logger/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  final logger = Getx.Get.find<Logger>();
  @override
  void onEvent(Bloc bloc, Object event) {
    // print(event);
    logger.i("event: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    // print(error);
    logger.e("error: $error");
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    // print(change);
    logger.w("change: $change");
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // print(transition);
    logger.d("transition: $transition");
    super.onTransition(bloc, transition);
  }
}
