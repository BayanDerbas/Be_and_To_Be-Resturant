import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/constants/app_colors.dart';
import 'package:web_app/features/cart/presentation/widgets/CustomOrderDetailsForm.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/CustomCart.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = context.read<CartCubit>();
        final tableController = TextEditingController(
          text: state.tableNumber ?? '',
        );
        final noteController = TextEditingController(text: state.note ?? '');

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
                  builder:
                      (_) => AlertDialog(
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
                  builder:
                      (_) => AlertDialog(
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
                showDialog(
                  context: context,
                  builder:
                      (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          width: 600,
                          height: 500,
                          decoration: BoxDecoration(
                            color: AppColors.smooky,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DefaultTabController(
                            length: 3,
                            child: Builder(
                              builder: (context) {
                                final TabController tabController =
                                    DefaultTabController.of(context);

                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    ValueListenableBuilder(
                                      valueListenable: tabController.animation!,
                                      builder: (context, value, _) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(3, (index) {
                                            final isSelected =
                                                tabController.index == index;
                                            final labels = [
                                              'إرسال إلى العنوان',
                                              'استلام ذاتي',
                                              'طلب على الطاولة',
                                            ];
                                            return GestureDetector(
                                              onTap: () {
                                                tabController.animateTo(index);
                                              },
                                              child: AnimatedContainer(
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      isSelected ? 20 : 15,
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      isSelected
                                                          ? AppColors.orange
                                                          : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  labels[index],
                                                  style: TextStyle(
                                                    color:
                                                        isSelected
                                                            ? Colors.white
                                                            : Colors.grey,
                                                    fontSize:
                                                        isSelected ? 16 : 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          CustomOrderDetailsForm(
                                            title: 'طلب إرسال إلى عنوان',
                                            includeAddress: true,
                                            includeTableNumber: false,
                                            totalPrice: state.totalPrice,
                                            selectedCoupon: state.selectedCoupon,
                                            availableCoupons: state.coupons,
                                            onSelectCoupon: (coupon) {
                                              cartCubit.selectCoupon(coupon);
                                            },
                                            onSendOrder: () {
                                              cartCubit.updateNote(noteController.text);
                                            },
                                            addressController: TextEditingController(),
                                            noteController: noteController,
                                          ),
                                          CustomOrderDetailsForm(
                                            title: 'طلب استلام ذاتي',
                                            includeAddress: false,
                                            includeTableNumber: false,
                                            totalPrice: state.totalPrice,
                                            selectedCoupon: state.selectedCoupon,
                                            availableCoupons: state.coupons,
                                            onSelectCoupon: (coupon) {
                                              cartCubit.selectCoupon(coupon);
                                            },
                                            onSendOrder: (){
                                              cartCubit.updateNote(noteController.text);
                                            },
                                            noteController: noteController,
                                          ),
                                          CustomOrderDetailsForm(
                                            title: 'طلب على الطاولة',
                                            includeAddress: false,
                                            includeTableNumber: true,
                                            totalPrice: state.totalPrice,
                                            selectedCoupon: state.selectedCoupon,
                                            availableCoupons: state.coupons,
                                            onSelectCoupon: (coupon) {
                                              cartCubit.selectCoupon(coupon);
                                            },
                                            onSendOrder: () {
                                              cartCubit.updateNote(noteController.text);
                                              cartCubit.updateTableNumber(tableController.text);
                                              print(
                                                "sending order with table: ${tableController.text} note: ${noteController.text}",
                                              );
                                            },
                                            tableNumberController: tableController,
                                            noteController: noteController,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
