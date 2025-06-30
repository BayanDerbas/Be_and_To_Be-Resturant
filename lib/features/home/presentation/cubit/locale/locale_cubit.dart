import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar'));

  void setArabic() => emit(const Locale('ar'));
  void setEnglish() => emit(const Locale('en'));
}
