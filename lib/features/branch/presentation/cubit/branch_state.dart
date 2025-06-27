part of 'branch_cubit.dart';

@immutable
abstract class BranchState {}

class BranchInitial extends BranchState {}

class BranchSelected extends BranchState {
  final String branchName;

  BranchSelected(this.branchName);
}
