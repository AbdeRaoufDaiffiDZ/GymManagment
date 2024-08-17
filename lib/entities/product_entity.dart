// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Product extends Equatable {
  final String id;
  String name;
  double price;
  int quantity;
  int sold;
  double priceoverview;
  List<SaleRecord> saleRecords;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.sold = 0,
    this.priceoverview = 0.0,
    List<SaleRecord>? saleRecords,
  }) : saleRecords = saleRecords ?? [];

  @override
  List<Object?> get props =>
      [id, name, price, quantity, sold, priceoverview, saleRecords];

  factory Product.fromMap(Map<String, dynamic> map) {
    List saleRecordsMap = [];
    if (map['saleRecords'] != null) {
      saleRecordsMap = map['saleRecords'];
    }
    return Product(
        id: map['_id'] ?? ObjectId,
        name: map['productName'] ?? '',
        price: map['productPrice'] ?? 0.0,
        quantity: map['quantityleft'] ?? 0,
        priceoverview: map['priceoverview'] ?? 0.0,
        saleRecords: saleRecordsMap.map((e) => SaleRecord.fromMap(e)).toList(),
        sold: map['sold'] ?? 0);
  }
  Map<String, dynamic> toMap() {
    return {
      'productName': name,
      'productPrice': price,
      '_id': id,
      'priceoverview': priceoverview,
      'quantityleft': quantity,
      'saleRecords': saleRecords,
      'sold': sold
    };
  }
}

class SaleRecord extends Equatable {
  final int quantitySold;
  final DateTime dateTime;

  SaleRecord({
    required this.quantitySold,
    required this.dateTime,
  });
  Map<String, dynamic> toMap() {
    return {
      'quantitySold': quantitySold,
      'dateTime': dateTime,
    };
  }

  factory SaleRecord.fromMap(Map<String, dynamic> map) {
    return SaleRecord(
      quantitySold: map['quantitySold'] ?? 0,
      dateTime: map['dateTime'] ?? DateTime.now(),
    );
  }
  @override
  List<Object?> get props => [quantitySold, dateTime];
}
