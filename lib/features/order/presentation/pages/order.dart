import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/widgets/CustomCart.dart';
import '../cubit/order_cubit.dart';
import '../widgets/CustomOrder.dart';

class Order extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final List<String> types;

  const Order({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(
        name: name,
        image: image,
        unitPrice: price,
        types: types,
      ),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          final cubit = context.read<OrderCubit>();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomOrder(
              name: state.name,
              image: state.image,
              type: state.types,
              selectedType: state.selectedType,
              quantity: state.quantity,
              totalPrice: state.totalPrice,
              onIncrease: cubit.increase,
              onDecrease: cubit.decrease,
              onSelectType: cubit.selectType,
              onAddToCart: () {
                final cubit = context.read<CartCubit>();
                cubit.addItem(CartItem(
                  name: state.name,
                  type: state.selectedType,
                  image: state.image,
                  quantity: state.quantity,
                  unitPrice: state.unitPrice,
                ));
                Navigator.of(context).pop();
              },

            ),
          );
        },
      ),
    );
  }
}