part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final int totalPrice;
  final int minOrderPrice;

  const CartState({
    required this.items,
    required this.totalPrice,
    required this.minOrderPrice,
  });

  CartState copyWith({
    List<CartItem>? items,
    int? totalPrice,
    int? minOrderPrice,
  }) {
    return CartState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      minOrderPrice: minOrderPrice ?? this.minOrderPrice,
    );
  }

  @override
  List<Object> get props => [items, totalPrice, minOrderPrice];
}