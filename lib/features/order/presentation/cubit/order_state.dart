part of 'order_cubit.dart';

class OrderState extends Equatable {
  final String name;
  final String image;
  final List<String> types;
  final String? selectedType;
  final int quantity;
  final int unitPrice;
  final int totalPrice;

  const OrderState({
    required this.name,
    required this.image,
    required this.types,
    this.selectedType,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  OrderState copyWith({
    String? name,
    String? image,
    List<String>? types,
    String? selectedType,
    int? quantity,
    int? unitPrice,
    int? totalPrice,
  }) {
    return OrderState(
      name: name ?? this.name,
      image: image ?? this.image,
      types: types ?? this.types,
      selectedType: selectedType ?? this.selectedType,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [name, image, types, selectedType, quantity, unitPrice, totalPrice];
}