import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({
    required String name,
    required String image,
    required int unitPrice,
    required List<String> types,
  }) : super(OrderState(
    name: name,
    image: image,
    types: types,
    selectedType: null,
    quantity: 1,
    unitPrice: unitPrice,
    totalPrice: unitPrice,
  ));

  void increase() {
    final newQty = state.quantity + 1;
    emit(state.copyWith(
      quantity: newQty,
      totalPrice: newQty * state.unitPrice,
    ));
  }

  void decrease() {
    if (state.quantity > 1) {
      final newQty = state.quantity - 1;
      emit(state.copyWith(
        quantity: newQty,
        totalPrice: newQty * state.unitPrice,
      ));
    }
  }

  void selectType(String newType) {
    emit(state.copyWith(selectedType: newType));
  }
}