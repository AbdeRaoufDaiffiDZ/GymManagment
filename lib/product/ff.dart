class Product {
  String name;
  double price;
  int quantity;
  int sold;
  double priceoverview;
  List<SaleRecord> saleRecords;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    this.sold = 0,
    this.priceoverview = 0.0,
    List<SaleRecord>? saleRecords,
  }) : saleRecords = saleRecords ?? [];
}

class SaleRecord {
  final int quantitySold;
  final DateTime dateTime;

  SaleRecord({
    required this.quantitySold,
    required this.dateTime,
  });
}
