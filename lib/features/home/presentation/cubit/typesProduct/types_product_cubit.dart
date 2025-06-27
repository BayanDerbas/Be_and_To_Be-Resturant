import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/app_images.dart';

part 'types_product_state.dart';

class ProductTypesCubit extends Cubit<ProductTypesState> {
  ProductTypesCubit() : super(ProductTypesInitial());

  final Map<String, List<Map<String, String>>> _productTypes = {
    'مناقيش': [
      {'name': 'زعتر', 'image':AppImages.zaatar, 'price': '10'},
      {'name': 'لحمة', 'image': AppImages.meet, 'price': '15'},
    ],
    'بيتزا': [
      {'name': 'مارغريتا', 'image': AppImages.zaatar, 'price': '25.000'},
      {'name': 'بيبروني', 'image': AppImages.meet, 'price': '300.000'},
    ],
    'جبنة': [
      {'name': 'عكاوي', 'image': AppImages.zaatar, 'price': '18'},
      {'name': 'موزاريلا', 'image': AppImages.meet, 'price': '22'},
    ],
  };

  void loadTypesForProduct(String productName) {
    final types = _productTypes[productName];
    if (types != null) {
      emit(ProductTypesLoaded(types: types));
    } else {
      emit(const ProductTypesFailure(message: 'لا توجد أنواع لهذا المنتج'));
    }
  }
}
