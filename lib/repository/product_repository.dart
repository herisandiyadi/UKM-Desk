import 'package:enforcea/api_helper/apiBaseHelper.dart';
import 'package:enforcea/constants.dart';
import 'package:enforcea/model/response/product_response.dart';
import 'package:enforcea/util/cache_util.dart';

abstract class IProductRepository {
  Future<ProductResponse> getProductList();
}

class ProductRepository implements IProductRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<ProductResponse> getProductList() async {
    final response = await _helper.get("produk", "");
    return ProductResponse.fromJson(response);
  }
}
