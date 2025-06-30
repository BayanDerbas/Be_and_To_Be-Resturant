import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/constants/app_colors.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/CustomCart.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();

        return Center(
          child: Container(
            width: 600,
            height: 500,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.smooky,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Customcard(
              items: state.items,
              totalPrice: state.totalPrice,
              minOrderPrice: state.minOrderPrice,
              onItemTap: (item) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('حذف ${item.name}?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          cartCubit.removeItem(item);
                        },
                        child: const Text('نعم'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('لا'),
                      ),
                    ],
                  ),
                );
              },
              onIncreaseQuantity: (item) {
                cartCubit.increaseQuantity(item);
              },
              onDecreaseQuantity: (item) {
                cartCubit.decreaseOrRemoveItem(item);
              },
              onDeleteItem: (item) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('هل أنت متأكد من حذف ${item.name}?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          cartCubit.removeItem(item);
                        },
                        child: const Text('نعم'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('لا'),
                      ),
                    ],
                  ),
                );
              },
              onNext: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم الانتقال للخطوة التالية')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}