import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zajel_hub/core/entities/product_entity.dart';
import 'package:zajel_hub/core/repos/products_repo/products_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productsRepo) : super(ProductsInitial());

  final ProductsRepo productsRepo;
  int productsLength = 0;
  String? selectedCategory;
  List<ProductEntity> allProducts = [];

  Future<void> getProducts() async {
    emit(ProductsLoading());
    final result = await productsRepo.getProducts();
    result.fold(
      (failure) => emit(ProductsFailure(failure.message)),
      (products) {
        allProducts = products;
        emit(ProductsSuccess(products));
      },
    );
  }

  Future<void> getBestSellingroducts() async {
    emit(ProductsLoading());
    final result = await productsRepo.getBestSellingProducts();
    result.fold((failure) => emit(ProductsFailure(failure.message)), (
      products,
    ) {
      productsLength = products.length;
      allProducts = products;
      emit(ProductsSuccess(products));
    });
  }

  void filterByCategory(String? categoryId) {
    selectedCategory = categoryId;
    if (allProducts.isEmpty) {
      return;
    }

    if (categoryId == null) {
      // Show all products
      emit(ProductsSuccess(allProducts));
    } else {
      // Filter products by category
      final filteredProducts = allProducts
          .where((product) => product.categoryId == categoryId)
          .toList();
      emit(ProductsSuccess(filteredProducts));
    }
  }
}
