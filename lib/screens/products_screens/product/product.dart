import 'package:admin/const/loading.dart';
import 'package:admin/screens/products_screens/product/KK.dart';
import 'package:admin/entities/product_entity.dart';
import 'package:flutter/material.dart';

import 'package:admin/screens/products_screens/products_bloc/products_bloc.dart';
import 'package:admin/screens/products_screens/products_bloc/products_blocEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ProductDashboard extends StatefulWidget {
  @override
  _ProductDashboardState createState() => _ProductDashboardState();
}

class _ProductDashboardState extends State<ProductDashboard> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  String? _editingId;
  int count = 0;
  @override
  void initState() {
    super.initState();
    _filteredProducts = _products;
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addProduct() {
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

    if (_nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      Product newProduct = Product(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        // ignore: deprecated_member_use
        id: mongo.ObjectId().toHexString(),
      );
      productsBloc.add(AddProductEvent(products: newProduct));

      setState(() {
        _products.add(newProduct);
        _filteredProducts = _products;
        _nameController.clear();
        _priceController.clear();
        _quantityController.clear();
      });
    }
  }

  void _editProduct(
      String id, int index, String name, double price, int quantity) {
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
    Product productEdited =
        Product(name: name, price: price, quantity: quantity, id: id);
    productsBloc.add(UpdateProductEvent(product: productEdited));

    setState(() {
      _products[index] = productEdited;
      _filteredProducts = _products;
    });
  }

  void _updateQuantity(Product product, int change) {
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
    int index = _products.indexOf(product);
    if (_products[index].quantity + change >= 0) {
      if (change < 0) {
        _products[index].saleRecords.add(
              SaleRecord(
                quantitySold: change.abs(),
                dateTime: DateTime.now(),
              ),
            );
      }
      _products[index].quantity += change;
      if (change < 0) {
        int saleQuantity = change.abs();
        _products[index].sold += saleQuantity;
        _products[index].priceoverview += _products[index].price;
      }
      productsBloc.add(UpdateProductEvent(product: _products[index]));
    }
    setState(() {
      _filteredProducts = _products;
    });
  }

  void _removeProduct(Product product) {
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

    productsBloc.add(DeleteProductEvent(product: product));
    _products.remove(product);

    setState(() {
      _filteredProducts = _products;
    });
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 100),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffFFA05D).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a name...',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: const Color(0xff202020).withOpacity(0.88),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.search,
                        color: Color(0xff202020).withOpacity(0.5)),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xffF9F9F9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(child: _inputField(_nameController, 'Product', false)),
                SizedBox(width: 10),
                Expanded(
                    child:
                        _inputField(_priceController, 'Product Price', true)),
                SizedBox(width: 10),
                Expanded(
                    child: _inputField(_quantityController, 'Quantity', true)),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addProduct,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Color(0xffFFA05D)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _productList(),
        ],
      ),
    );
  }

  Widget _inputField(
      TextEditingController controller, String hint, bool numberOrNot) {
    return TextFormField(
      controller: controller,
      keyboardType: numberOrNot ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }

  Widget _productList() {
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 100),
      child: BlocBuilder<ProductsBloc, ProductsBlocState>(
          builder: (context, state) {
        if (state is SuccessState) {
          // _allItems = state.products;
          if (count == 0) {
            _filteredProducts = state.products;
            _products = _filteredProducts;
            count++;
          }

          // _filteredItems
          //     .sort((a, b) => a.quantityleft.compareTo(b.quantityleft));
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
              final product = _filteredProducts[index];
              final isEditing = _editingId == _filteredProducts[index].id;
              final _editNameController =
                  TextEditingController(text: product.name);
              final _editPriceController =
                  TextEditingController(text: product.price.toString());
              final _editQuantityController =
                  TextEditingController(text: product.quantity.toString());

              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Color(0xffFAFAFA),
                      title: Center(
                        child: Text(
                          'Sale Records for ${product.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      content: Container(
                        width: MediaQuery.of(context).size.width *
                            0.4, // Adjust the width as needed ,
                        height: MediaQuery.of(context).size.height *
                            0.4, // Adjust the width as needed
                        child: Scrollbar(
                          controller:
                              scrollController, // Attach the ScrollController

                          thumbVisibility: true,
                          thickness: 8.0,
                          radius: Radius.circular(8),
                          trackVisibility: true,
                          child: SingleChildScrollView(
                            controller:
                                scrollController, // Attach the ScrollController

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: product.saleRecords.isEmpty
                                  ? [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text('No sale records',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )
                                    ]
                                  : product.saleRecords.map((record) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              formatDateTime(record.dateTime),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey.shade300,
                                            thickness: 1,
                                          ),
                                        ],
                                      );
                                    }).toList(),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xffFFA05D).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Close',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: AnimatedCard(
                  child: Card(
                    color: product.quantity <= 0
                        ? Color.fromARGB(255, 255, 197, 197)
                        : Colors.grey.shade100,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      title: Center(
                        child: isEditing
                            ? Form(
                                key: _editFormKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _editNameController,
                                      decoration: InputDecoration(
                                          hintText: 'Name',
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a name';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _editPriceController,
                                      decoration: InputDecoration(
                                          hintText: 'Product Price',
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a price';
                                        }
                                        if (double.tryParse(value) == null) {
                                          return 'Invalid price';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _editQuantityController,
                                      decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        hintText: 'Quantity',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a quantity';
                                        }
                                        if (int.tryParse(value) == null) {
                                          return 'Invalid quantity';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      subtitle: isEditing
                          ? SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Product Price : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff202020)
                                              .withOpacity(0.8),
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${product.price.toStringAsFixed(2)} DA',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Quantity : ',
                                        style: TextStyle(
                                          color: Color(0xff202020)
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${product.quantity}',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Sold : ',
                                        style: TextStyle(
                                          color: Color(0xff202020)
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${product.sold}',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Sale price : ',
                                        style: TextStyle(
                                          color: Color(0xff202020)
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${product.priceoverview} DA',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(isEditing ? Icons.check : Icons.edit,
                                color: isEditing ? Colors.green : Colors.blue),
                            onPressed: () {
                              if (isEditing) {
                                if (_editFormKey.currentState?.validate() ??
                                    false) {
                                  _editProduct(
                                    product.id,
                                    index,
                                    _editNameController.text,
                                    double.parse(_editPriceController.text),
                                    int.parse(_editQuantityController.text),
                                  );
                                  setState(() {
                                    _editingId = null;
                                  });
                                }
                              } else {
                                setState(() {
                                  _editingId = product.id;
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.green),
                            onPressed: () => _updateQuantity(product, 1),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.red),
                            onPressed: () => _updateQuantity(product, -1),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeProduct(product),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is IinitialState) {
          productsBloc.add(GetProductsEvent());
          return Loading();
        } else if (state is ErrorState) {
          productsBloc.add(GetProductsEvent());

          return Loading();
        } else {
          return Loading();
        }
      }),
    ));
  }
}
