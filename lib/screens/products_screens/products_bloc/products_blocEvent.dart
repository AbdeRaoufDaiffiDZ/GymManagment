import 'package:admin/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductsBlocEvent extends Equatable {}

class AddProductEvent extends ProductsBlocEvent {
  final Product products;

  AddProductEvent({required this.products});

  @override
  List<Object?> get props => [products];
}

class GetProductsEvent extends ProductsBlocEvent {
  @override
  List<Object?> get props => [];
}

class DeleteProductEvent extends ProductsBlocEvent {
  final Product product;

  DeleteProductEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductsBlocEvent {
  final Product product;
  final String? buyer;
  UpdateProductEvent({required this.buyer,
    required this.product,
  });

  @override
  List<Object?> get props => [
        product,
      ];
}
