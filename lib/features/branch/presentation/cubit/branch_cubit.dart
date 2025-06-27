import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit() : super(BranchInitial());

  void selectBranch(String branchName) {
    emit(BranchSelected(branchName));
  }
}
