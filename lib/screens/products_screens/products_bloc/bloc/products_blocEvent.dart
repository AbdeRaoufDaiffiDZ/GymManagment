import 'package:admin/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductsBlocEvent extends Equatable {}

class AddUserEvent extends ProductsBlocEvent {
  final ProductEntity products;

  AddUserEvent({required this.products});

  @override
  List<Object?> get props => [products];
}

class GetUsersEvent extends ProductsBlocEvent {
  @override
  List<Object?> get props => [];
}

class DeleteUserEvent extends ProductsBlocEvent {
  final ProductEntity products;

  DeleteUserEvent({required this.products});

  @override
  List<Object?> get props => [products];
}

class UpdateUserEvent extends ProductsBlocEvent {
  final ProductEntity products;

  UpdateUserEvent({
    required this.products,
  });

  @override
  List<Object?> get props => [
        products,
      ];
}
