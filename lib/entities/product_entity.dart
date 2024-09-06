// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  String name;
  double price;
  int quantity;
  int soldHomme;
  int soldFemme;

  double priceoverview;
  double priceoverviewfemme;

  List<SaleRecord> saleRecords;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.soldHomme = 0,
    this.soldFemme = 0,
    this.priceoverview = 0.0,
    this.priceoverviewfemme = 0.0,
    List<SaleRecord>? saleRecords,
  }) : saleRecords = saleRecords ?? [];

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        quantity,
        soldHomme,
        soldFemme,
        priceoverview,
        saleRecords
      ];

  factory Product.fromMap(Map<String, dynamic> map) {
    List saleRecordsMap = [];
    late double? productPrice;
    late double? priceoverview;
    late double? priceoverviewfemme;

    if (map['saleRecords'] != null) {
      saleRecordsMap = map['saleRecords'];
    }
    if (map['productPrice'] is int) {
      productPrice = map['productPrice'].toDouble();
    } else {
      productPrice = map['productPrice'];
    }
    if (map['priceoverview'] is int) {
      priceoverview = map['priceoverview'].toDouble();
    } else {
      priceoverview = map['priceoverview'];
    }
    if (map['priceoverviewfemme'] != null && map['priceoverviewfemme'] is int) {
      priceoverviewfemme = map['priceoverviewfemme'].toDouble();
    } else {
      priceoverviewfemme = map['priceoverviewfemme'];
    }

    return Product(
        id: map['_id'] ?? "",
        name: map['productName'] ?? '',
        price: productPrice ?? 0.0,
        quantity: map['quantityleft'] ?? 0,
        priceoverview: priceoverview ?? 0.0,
        saleRecords: saleRecordsMap.map((e) => SaleRecord.fromMap(e)).toList(),
        priceoverviewfemme: priceoverviewfemme ?? 0.0,
        soldHomme: map['soldHomme'] ?? 0,
        soldFemme: map['soldFemme'] ?? 0);
  }
  Map<String, dynamic> toMap() {
    return {
      'productName': name,
      'productPrice': price,
      '_id': id,
      'priceoverview': priceoverview,
      'quantityleft': quantity,
      'saleRecords': saleRecords,
      'priceoverviewfemme': priceoverviewfemme,
      'soldHomme': soldHomme,
      'soldFemme': soldFemme
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
