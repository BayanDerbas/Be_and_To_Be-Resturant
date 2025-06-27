import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:web_app/core/constants/app_colors.dart';

part 'header_state.dart';

class HeaderCubit extends Cubit<HeaderState> {
  HeaderCubit() : super(HeaderInitial());

  final ScrollController scrollController = ScrollController();

  void changeHeaderColor(double offset) {
    if (offset > 50) {
      // لو مرق 50 بيكسل من السكرول
      emit(HeaderChanged(backgroundColor: AppColors.red));
    } else {
      emit(HeaderChanged(backgroundColor: Colors.transparent));
    }
  }
}