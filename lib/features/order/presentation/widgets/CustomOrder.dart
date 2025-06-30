import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomOrder extends StatelessWidget {
  final String name;
  final List<String> type;
  final String? selectedType;
  final String image;
  final int quantity;
  final int totalPrice;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onAddToCart;
  final Function(String) onSelectType;

  const CustomOrder({
    super.key,
    required this.name,
    required this.type,
    required this.image,
    required this.quantity,
    required this.totalPrice,
    required this.onIncrease,
    required this.onDecrease,
    required this.onAddToCart,
    required this.onSelectType,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              color: AppColors.smooky,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 200,   // العرض المطلوب
                    height: 200,  // الطول المطلوب
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children:
                        type.map((t) {
                          final isSelected = t == selectedType;
                          return ChoiceChip(
                            label: Text(
                              t,
                              style: const TextStyle(color: AppColors.white),
                            ),
                            selected: isSelected,
                            selectedColor: AppColors.orange,
                            backgroundColor: AppColors.black2,
                            checkmarkColor: AppColors.white,
                            onSelected: (_) => onSelectType(t),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: AppColors.orange),
                        onPressed: onDecrease,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "$quantity",
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.black1,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: AppColors.orange),
                        onPressed: onIncrease,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "SYR $totalPrice",
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: AppColors.black1,
                    ),
                    label: const Text(
                      "أضف إلى السلة",
                      style: TextStyle(color: AppColors.black1),
                    ),
                    onPressed: onAddToCart,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 28,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
