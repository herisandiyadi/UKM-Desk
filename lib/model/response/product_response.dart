/// success : true
/// data : [{"product_id":6,"product_category":1,"product_name":"UKM Desk Small","product_desc":"We believe that quality tax advice should assessible for all tax payers including the UMKM. By having good tax advice and tax knowledge, we expect them able to fulfill their tax obligations better. We help them to develop tax literacy so it will be useful in improving tax management in their business, optimize available tax facilities, achieve efficient and effective tax operations","product_content":"<div class=\"card h-100\">\r\n                        <h3 class=\"card-header\">UKM Desk Small</h3>\r\n                        <ul class=\"list-group list-group-flush\">\r\n                            <li class=\"list-group-item\">Laporan Keuangan</li>\r\n                            <li class=\"list-group-item\">Penjualan & Pembelian</li>\r\n                            <li class=\"list-group-item\">Buku Besar</li>\r\n                            <li class=\"list-group-item\">Rekonsiliasi Bank</li>\r\n                            <li class=\"list-group-item\">Transaksi Berulang</li>\r\n                            <li class=\"list-group-item\">Daftar Kontak</li>\r\n                            <li class=\"list-group-item\">Multi Pengguna</li>\r\n                            <li class=\"list-group-item\">Keamanan & Support</li>\r\n                            <li class=\"list-group-item\">Monitor Inventori</li>\r\n                            <li class=\"list-group-item\">Managemen Aset</li>\r\n                            <li class=\"list-group-item\">Tag Transaksi</li>                            \r\n                            <li class=\"list-group-item\">SPT PPh Pasal 4(2)</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 21</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 23</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 25</li>\r\n                        </ul>\r\n                    </div>","product_price":"3000000","product_discount_price":"2500000","product_images":"/assets/produk/icon_umkm.png","product_thumb":"/assets/produk/thumb_umkm.png","product_tag":"ukm, umkm","status":"on","created_at":null,"updated_at":"2020-08-18 08:51:16"},{"product_id":1,"product_category":1,"product_name":"UKM Desk Medium","product_desc":"We believe that quality tax advice should assessible for all tax payers including the UMKM. By having good tax advice and tax knowledge, we expect them able to fulfill their tax obligations better. We help them to develop tax literacy so it will be useful in improving tax management in their business, optimize available tax facilities, achieve efficient and effective tax operations","product_content":"<div class=\"card h-100\">\r\n                        <h3 class=\"card-header\">UKM Desk Medium</h3>\r\n                        <ul class=\"list-group list-group-flush\">\r\n                            <li class=\"list-group-item\">Laporan Keuangan</li>\r\n                            <li class=\"list-group-item\">Penjualan & Pembelian</li>\r\n                            <li class=\"list-group-item\">Buku Besar</li>\r\n                            <li class=\"list-group-item\">Rekonsiliasi Bank</li>\r\n                            <li class=\"list-group-item\">Transaksi Berulang</li>\r\n                            <li class=\"list-group-item\">Daftar Kontak</li>\r\n                            <li class=\"list-group-item\">Multi Pengguna</li>\r\n                            <li class=\"list-group-item\">Keamanan & Support</li>\r\n                            <li class=\"list-group-item\">Monitor Inventori</li>\r\n                            <li class=\"list-group-item\">Managemen Aset</li>\r\n                            <li class=\"list-group-item\">Tag Transaksi</li>\r\n                            <li class=\"list-group-item\">Penagihan, Pemesanan & Pengiriman</li>\r\n                            <li class=\"list-group-item\">Multi Gudang & Lokasi Produk</li>\r\n                            <li class=\"list-group-item\">Multi Mata Uang</li>\r\n                            <li class=\"list-group-item\">Produk Bundle</li>\r\n                            <li class=\"list-group-item\">Anggaran Keuangan</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPN</li>\r\n                            <li class=\"list-group-item\">SPT PPh Pasal 4(2)</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 21</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 23</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 25</li>\r\n                        </ul>\r\n                    </div>","product_price":"4500000","product_discount_price":"3500000","product_images":"/assets/produk/icon_umkm.png","product_thumb":"/assets/produk/thumb_umkm.png","product_tag":"ukm, umkm","status":"on","created_at":null,"updated_at":"2020-08-18 08:51:01"}]

class ProductResponse {
  bool _success;
  List<Data> _data;

  bool get success => _success;
  List<Data> get data => _data;

  ProductResponse({
      bool success, 
      List<Data> data}){
    _success = success;
    _data = data;
}

  ProductResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : 6
/// product_category : 1
/// product_name : "UKM Desk Small"
/// product_desc : "We believe that quality tax advice should assessible for all tax payers including the UMKM. By having good tax advice and tax knowledge, we expect them able to fulfill their tax obligations better. We help them to develop tax literacy so it will be useful in improving tax management in their business, optimize available tax facilities, achieve efficient and effective tax operations"
/// product_content : "<div class=\"card h-100\">\r\n                        <h3 class=\"card-header\">UKM Desk Small</h3>\r\n                        <ul class=\"list-group list-group-flush\">\r\n                            <li class=\"list-group-item\">Laporan Keuangan</li>\r\n                            <li class=\"list-group-item\">Penjualan & Pembelian</li>\r\n                            <li class=\"list-group-item\">Buku Besar</li>\r\n                            <li class=\"list-group-item\">Rekonsiliasi Bank</li>\r\n                            <li class=\"list-group-item\">Transaksi Berulang</li>\r\n                            <li class=\"list-group-item\">Daftar Kontak</li>\r\n                            <li class=\"list-group-item\">Multi Pengguna</li>\r\n                            <li class=\"list-group-item\">Keamanan & Support</li>\r\n                            <li class=\"list-group-item\">Monitor Inventori</li>\r\n                            <li class=\"list-group-item\">Managemen Aset</li>\r\n                            <li class=\"list-group-item\">Tag Transaksi</li>                            \r\n                            <li class=\"list-group-item\">SPT PPh Pasal 4(2)</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 21</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 23</li>\r\n                            <li class=\"list-group-item\">SPT Masa PPh Pasal 25</li>\r\n                        </ul>\r\n                    </div>"
/// product_price : "3000000"
/// product_discount_price : "2500000"
/// product_images : "/assets/produk/icon_umkm.png"
/// product_thumb : "/assets/produk/thumb_umkm.png"
/// product_tag : "ukm, umkm"
/// status : "on"
/// created_at : null
/// updated_at : "2020-08-18 08:51:16"

class Data {
  int _productId;
  int _productCategory;
  String _productName;
  String _productDesc;
  String _productContent;
  String _productPrice;
  String _productDiscountPrice;
  String _productImages;
  String _productThumb;
  String _productTag;
  String _status;
  dynamic _createdAt;
  String _updatedAt;

  int get productId => _productId;
  int get productCategory => _productCategory;
  String get productName => _productName;
  String get productDesc => _productDesc;
  String get productContent => _productContent;
  String get productPrice => _productPrice;
  String get productDiscountPrice => _productDiscountPrice;
  String get productImages => _productImages;
  String get productThumb => _productThumb;
  String get productTag => _productTag;
  String get status => _status;
  dynamic get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Data({
      int productId, 
      int productCategory, 
      String productName, 
      String productDesc, 
      String productContent, 
      String productPrice, 
      String productDiscountPrice, 
      String productImages, 
      String productThumb, 
      String productTag, 
      String status, 
      dynamic createdAt, 
      String updatedAt}){
    _productId = productId;
    _productCategory = productCategory;
    _productName = productName;
    _productDesc = productDesc;
    _productContent = productContent;
    _productPrice = productPrice;
    _productDiscountPrice = productDiscountPrice;
    _productImages = productImages;
    _productThumb = productThumb;
    _productTag = productTag;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _productId = json["product_id"];
    _productCategory = json["product_category"];
    _productName = json["product_name"];
    _productDesc = json["product_desc"];
    _productContent = json["product_content"];
    _productPrice = json["product_price"];
    _productDiscountPrice = json["product_discount_price"];
    _productImages = json["product_images"];
    _productThumb = json["product_thumb"];
    _productTag = json["product_tag"];
    _status = json["status"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["product_id"] = _productId;
    map["product_category"] = _productCategory;
    map["product_name"] = _productName;
    map["product_desc"] = _productDesc;
    map["product_content"] = _productContent;
    map["product_price"] = _productPrice;
    map["product_discount_price"] = _productDiscountPrice;
    map["product_images"] = _productImages;
    map["product_thumb"] = _productThumb;
    map["product_tag"] = _productTag;
    map["status"] = _status;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    return map;
  }

}