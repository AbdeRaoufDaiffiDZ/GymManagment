// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ProductEntity extends Equatable {
  final String id;
   String productName;
   String productPrice;
  List<DateTime> sellingDates;
  int quantityleft;

  ProductEntity(
      {required this.id,
      required this.productName,
      required this.productPrice,
      required this.sellingDates,
      required this.quantityleft});

  @override
  List<Object?> get props => [
        productName,
        productPrice,
        quantityleft,
        sellingDates,
        id,
      ];

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['_id'] ?? ObjectId,
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? '',
      quantityleft: map['quantityleft'] ?? 0,
      sellingDates: //map['sellingDates'] ?? 
      [DateTime.now()],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      '_id': id,
      'sellingDates': sellingDates,
      'quantityleft': quantityleft,
    };
  }
}
