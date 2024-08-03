
part of 'products_bloc.dart';

sealed class ProductsBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IinitialState extends ProductsBlocState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends ProductsBlocState {
  final List<ProductEntity> products;

  SuccessState({required this.products});

  @override
  List<Object?> get props => [products];
}

class LoadingState extends ProductsBlocState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends ProductsBlocState {
  final String error;

  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}