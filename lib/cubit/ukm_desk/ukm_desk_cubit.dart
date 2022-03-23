import 'package:bloc/bloc.dart';
import 'package:enforcea/model/cart_model.dart';
import 'package:enforcea/model/response/product_response.dart';
import 'package:enforcea/repository/network_exception.dart';
import 'package:enforcea/repository/product_repository.dart';
import 'package:enforcea/util/database_helper.dart';
import 'package:meta/meta.dart';

part 'ukm_desk_state.dart';

class UkmDeskCubit extends Cubit<UkmDeskState> {
  final ProductRepository productRepository;

  UkmDeskCubit(this.productRepository) : super(UkmDeskInitial());
  DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> getProductList() async {
    try {
      emit(new UkmDeskLoading());
      final productData = await productRepository.getProductList();
      final totalItemInCart = await _getTotalItemOnCart();
      emit(new UkmDeskLoaded(productData, totalItemInCart));
    } on NetworkException catch (e) {
      emit(UkmDeskError(e.toString()));
    }
  }

  Future<void> addItemToCart(CartModel _data) async {
    List<CartModel> exclude = await dbHelper.getCartListExcludeById(_data.id);
    if (exclude.length > 0) {
      emit(UkmDeskError("Hanya bisa menambahkan product yang sejenis"));
      return;
    }
    ;

    List<CartModel> result = await dbHelper.getCartListById(_data.id);
    if (result.length > 0) {
      final data = CartModel(
          id: result[0].id,
          count: result[0].count + 1,
          name: result[0].name,
          price: result[0].price,
          imageUrl: result[0].imageUrl,
          date: result[0].date);
      if (!result[0].isRenewal) {
        data.setRenewalStatus(_data.isRenewal);
      }
      await dbHelper.update(data);
    } else {
      int result = await dbHelper.insert(_data);
    }
    int _totalCart = 0;
    List<CartModel> totalResult = await dbHelper.getCartList();
    if (totalResult.length > 0) {
      totalResult.forEach((element) {
        _totalCart = _totalCart + element.count;
      });
      emit(AddItem(_totalCart));
    }
  }

  Future<bool> updateStartDate(CartModel _data) async {
    List<CartModel> result = await dbHelper.getCartListById(_data.id);
    if (result.length > 0) {
      final data = CartModel(
          id: result[0].id,
          count: result[0].count,
          name: result[0].name,
          price: result[0].price,
          imageUrl: result[0].imageUrl,
          date: _data.date);
      await dbHelper.update(data);
    }

    return true;
  }

  Future<int> _getTotalItemOnCart() async {
    int _totalCart = 0;
    List<CartModel> totalResult = await dbHelper.getCartList();
    if (totalResult.length > 0) {
      totalResult.forEach((element) {
        _totalCart = _totalCart + element.count;
      });
    }

    return _totalCart;
  }

  Future<int> getPriceItemOnCart() async {
    int _totalCart = 0;
    List<CartModel> totalResult = await dbHelper.getCartList();
    if (totalResult.length > 0) {
      totalResult.forEach((element) {
        _totalCart = _totalCart + element.price;
      });
    }

    return _totalCart;
  }
}
