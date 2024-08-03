import 'dart:async';

import 'package:admin/entities/product_entity.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/screens/products_screens/8session_bloc/bloc/products_blocEvent.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_blocState.dart';

final MongoDatabase dataSource = MongoDatabase();
final collectionName = "Prodcuts";

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  ProductsBloc() : super(IinitialState()) {
    on<ProductsBlocEvent>((event, emit) async {
      if (event is AddUserEvent) {
        emit(LoadingState());
        final result = await dataSource.InsertProduct(
            product: event.products, collectionName: collectionName);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data =
              await dataSource.RetriveProducts(collectionName: collectionName);
          data.isRight
              ? emit(SuccessState(products: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      } else if (event is GetUsersEvent) {
        emit(LoadingState());
        final data =
            await dataSource.RetriveProducts(collectionName: collectionName);
        data.isRight
            ? emit(SuccessState(products: data.right))
            : emit(ErrorState(error: data.left.message));
      } else if (event is DeleteUserEvent) {
        emit(LoadingState());
        final result = await dataSource.DeleteProduct(
            product: event.products, collectionName: collectionName);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data =
              await dataSource.RetriveProducts(collectionName: collectionName);
          data.isRight
              ? emit(SuccessState(products: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      } else if (event is UpdateUserEvent) {
        emit(LoadingState());
        final result = await dataSource.UpdateProductData(
            product: event.products, collectionName: collectionName);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        } else {
          final data =
              await dataSource.RetriveProducts(collectionName: collectionName);
          data.isRight
              ? emit(SuccessState(products: data.right))
              : emit(ErrorState(error: data.left.message));
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    MongoDatabase.close();
  }
}
