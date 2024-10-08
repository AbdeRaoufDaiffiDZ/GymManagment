import 'dart:async';

import 'package:admin/entities/product_entity.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/screens/products_screens/products_bloc/products_blocEvent.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_blocState.dart';

final MongoDatabase dataSource = MongoDatabase();
final collectionName = "Prodcuts";

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsBlocState> {
  ProductsBloc() : super(IinitialState()) {
    on<ProductsBlocEvent>((event, emit) async {
      if (event is AddProductEvent) { ////////////////   the widget will not be updated the update will be done in database at same time in the widget data without getting it from databse
        final result = await dataSource.InsertProduct(
            product: event.products, collectionName: collectionName, context: event.context);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        }
      } else if (event is GetProductsEvent) { ////////////////   the widget will be updated by emitting new state when getting data from database
        emit(LoadingState());
        final data =
            await dataSource.RetriveProducts(collectionName: collectionName, context: event.context);
        data.isRight
            ? emit(SuccessState(products: data.right))
            : emit(ErrorState(error: data.left.message));
      } else if (event is DeleteProductEvent) { ////////////////   the widget will not be updated the update will be done in database at same time in the widget data without getting it from databse
        final result = await dataSource.DeleteProduct(
            product: event.product, collectionName: collectionName, context: event.context);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        }
      } else if (event is UpdateProductEvent) { ////////////////   the widget will not be updated the update will be done in database at same time in the widget data without getting it from databse
        final result = await dataSource.UpdateProductData(
            product: event.product, collectionName: collectionName, id: event.buyer, context: event.context);
        if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
