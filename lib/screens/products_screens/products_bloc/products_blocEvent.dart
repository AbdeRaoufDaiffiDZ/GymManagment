import 'package:admin/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductsBlocEvent extends Equatable {}

class AddProductEvent extends ProductsBlocEvent {
  final Product products;
final BuildContext context;
  AddProductEvent({required this.context,required this.products});

  @override
  List<Object?> get props => [products];
}

class GetProductsEvent extends ProductsBlocEvent {
final BuildContext context;
  GetProductsEvent({required this.context,});
  @override

  List<Object?> get props => [context];
}

class DeleteProductEvent extends ProductsBlocEvent {
  final Product product;
final BuildContext context;
  DeleteProductEvent({required this.context,required this.product});

  @override
  List<Object?> get props => [product,context];
}

class UpdateProductEvent extends ProductsBlocEvent {
  final Product product;
  final String? buyer;
  final BuildContext context;
  UpdateProductEvent({required this.buyer,required this.context,
    required this.product,
  });

  @override
  List<Object?> get props => [context,
        product,
      ];
}
