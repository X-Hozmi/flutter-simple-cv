import 'package:flutter_bloc/flutter_bloc.dart';

class HoverCubit extends Cubit<bool> {
  HoverCubit() : super(false);

  void enter() => emit(true);
  void exit() => emit(false);
}
