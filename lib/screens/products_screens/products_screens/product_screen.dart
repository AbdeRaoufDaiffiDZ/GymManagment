// // ignore_for_file: deprecated_member_use

// import 'package:admin/entities/product_entity.dart';
// import 'package:admin/const/loading.dart';
// import 'package:admin/data/mongo_db.dart';
// import 'package:admin/screens/products_screens/products_bloc/products_bloc.dart';
// import 'package:admin/screens/products_screens/products_bloc/products_blocEvent.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mongo_dart/mongo_dart.dart' as mongo;

// int count = 0;
// bool edit = false;
// bool checkDate = false;
// late ProductEntity productEdit;

// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({Key? key}) : super(key: key);

//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<ProductsScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _productPriceController = TextEditingController();
//   final TextEditingController _productQuantityController =
//       TextEditingController();

//   final MongoDatabase monog = MongoDatabase();
//   final startingDate = DateTime.now();

//   List<ProductEntity> _allItems = [];
//   List<ProductEntity> _filteredItems = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredItems = _allItems;
//     _searchController.addListener(_filterItems);
//   }

//   void _filterItems() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredItems = _allItems.where((item) {
//         return item.productName.toLowerCase().contains(query);
//       }).toList();
//     });
//   }

//   void _addProfile(ProductEntity? product) {
//     final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

//     if (_nameController.text.isNotEmpty &&
//         _productPriceController.text.isNotEmpty &&
//         _productQuantityController.text.isNotEmpty) {
//       if (edit) {
//         ProductEntity newProduct = ProductEntity(
//             id: productEdit.id,
//             productName: _nameController.text,
//             productPrice: _productPriceController.text,
//             sellingDates: productEdit.sellingDates,
//             quantityleft: int.parse(_productQuantityController.text));

//         productsBloc.add(UpdateProductEvent(product: newProduct));

//         setState(() {
//           _allItems.forEach((element) {
//             if (element.id == newProduct.id) {
//               element.productName = newProduct.productName;
//               element.productPrice = newProduct.productPrice;
//               element.quantityleft = newProduct.quantityleft;
//             }
//           });
//         });
//       } else {
//         ProductEntity newProduct = ProductEntity(
//             id: mongo.ObjectId().toHexString(),
//             productName: _nameController.text,
//             productPrice: _productPriceController.text,
//             sellingDates: [],
//             quantityleft: int.parse(_productQuantityController.text));

//         productsBloc.add(AddProductEvent(products: newProduct));

//         setState(() {
//           _allItems.add(newProduct);
//         });
//       }
//       _nameController.clear();
//       _productPriceController.clear();
//       _productQuantityController.clear();
//     }
//     _filteredItems = _allItems;
//     count = 0;
//     edit = false;
//     checkDate = false;
//   }

//   void _editProfile(ProductEntity product) {
//     setState(() {
//       _nameController.text = product.productName;
//       _productPriceController.text = product.productPrice;
//       _productQuantityController.text = product.quantityleft.toString();
//       edit = true;
//     });
//     productEdit = product;
//   }

//   void _deleteProfile(ProductEntity product) {
//     final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
//     productsBloc.add(DeleteProductEvent(product: product));
//     setState(() {
//       _allItems.removeWhere((element) => element.id == product.id);
//     });
//     count = 0;
//   }

//   /*void _renewProfile(User_Data user) {
//     final Unlimited_PlanBloc _unlimited_bloc =
//         BlocProvider.of<Unlimited_PlanBloc>(context);
//     user.endDate = DateTime.now().add(const Duration(days: 30));
//     _unlimited_bloc.add(UpdateUserEvent(user: user));
//   }
// */
//   // void _toggleSessionMark(User_Data user, bool value) {
//   //   setState(() {
//   //     user.isSessionMarked = value;
//   //     count = 0;
//   //   });
//   //   User_Data user_data = User_Data(
//   //       isSessionMarked: user.isSessionMarked,
//   //       sessionLeft: user.sessionLeft,
//   //       id: user.id,
//   //       fullName: user.fullName,
//   //       plan: user.plan,
//   //       startingDate: user.startingDate,
//   //       endDate: user.endDate,
//   //       credit: user.credit,
//   //       lastCheckDate: user.lastCheckDate);
//   //   if (value) {
//   //     // Implement the checkbox functionality if needed
//   //     user_data.isSessionMarked = true;
//   //     user_data.sessionLeft =
//   //         user_data.sessionLeft <= 0 ? 0 : user_data.sessionLeft - 1;
//   //     user_data.lastCheckDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   //   } else {
//   //     user_data.isSessionMarked = false;
//   //     user_data.sessionLeft = user_data.sessionLeft + 1;
//   //     user_data.lastCheckDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   //   }
//   //   final Session_16_PlanBloc session_16_planBloc =
//   //       BlocProvider.of<Session_16_PlanBloc>(context);
//   //   session_16_planBloc.add(UpdateUserEvent(user: user_data));
//   // }

//   void _renewProfile(ProductEntity productEntity) {
//     final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
//     productEntity.sellingDates.add(DateTime.now());
//     final renewProduct = ProductEntity(
//       id: productEntity.id,
//       productName: productEntity.productName,
//       productPrice: productEntity.productPrice,
//       quantityleft: productEntity.quantityleft - 1,
//       sellingDates: productEntity.sellingDates,
//     );
//     productsBloc.add(UpdateProductEvent(product: renewProduct));
//     setState(() {
//       _allItems.forEach((element) {
//         if (element.id == renewProduct.id) {
//           element.productName = renewProduct.productName;
//           element.productPrice = renewProduct.productPrice;
//           element.quantityleft = renewProduct.quantityleft;
//           element.sellingDates =renewProduct.sellingDates;
//         }
//         count = 0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _nameController.dispose();
//     _productPriceController.dispose();
//     _productQuantityController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 22),
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: const Color(0xffFFA05D).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Type a name...',
//                   hintStyle: TextStyle(
//                     fontSize: 17,
//                     color: const Color(0xff202020).withOpacity(0.88),
//                   ),
//                   icon: Padding(
//                     padding: EdgeInsets.only(left: 8.0),
//                     child: Icon(Icons.search,
//                         color: Color(0xff202020).withOpacity(0.5)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 22),
//             child: Text(
//               edit ? "edit a profile :" : "Add a profile :",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w900,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 22.0),
//             padding: const EdgeInsets.all(10.0),
//             decoration: BoxDecoration(
//               color: Color(0xffF9F9F9),
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 3,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(child: _inputField(_nameController, 'Name', false)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _inputField(_productPriceController, 'price', true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _inputField(
//                         _productQuantityController, 'quantity', true)),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     _addProfile(null);
//                   },
//                   child: Text(
//                     'Save',
//                     style: TextStyle(color: Color(0xffFFA05D)),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 22.0),
//             child: Text(
//               "Recently added",
//               style: TextStyle(
//                 fontWeight: FontWeight.w900,
//                 fontSize: 17,
//               ),
//             ),
//           ),
//           Divider(
//             indent: 25,
//             endIndent: 30,
//             height: 25,
//             thickness: 2,
//             color: Color(0xffE6E6E6),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//             child: BlocBuilder<ProductsBloc, ProductsBlocState>(
//                 builder: (context, state) {
//               if (state is SuccessState) {
//                 _allItems = state.products;
//                 if (count == 0) {
//                   _filteredItems = state.products;
//                   count++;
//                 }

//                 _filteredItems
//                     .sort((a, b) => a.quantityleft.compareTo(b.quantityleft));
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Table(
//                     columnWidths: {
//                       0: FixedColumnWidth(300),
//                       1: FixedColumnWidth(230),
//                       2: FixedColumnWidth(230),
//                       3: FixedColumnWidth(230),
//                     },
//                     children: [
//                       TableRow(
//                         decoration: BoxDecoration(
//                           color: Color(0xffFFA05D).withOpacity(0.4),
//                         ),
//                         children: [
//                           _tableHeaderCell("product Name"),
//                           _tableHeaderCell("product Price"),
//                           _tableHeaderCell("product Quantity"),
//                           _tableHeaderCell(""),
//                         ],
//                       ),
//                       for (var product in _filteredItems)
//                         TableRow(
//                           decoration: BoxDecoration(
//                             color: product.quantityleft <= 0
//                                 ? Colors.red.withOpacity(0.3)
//                                 : Color(0xffFAFAFA),
//                           ),
//                           children: [
//                             _tableCell(product.productName),
//                             _tableCell(product.productPrice),
//                             _tableCell(product.quantityleft.toString()),
//                             // _tableCell(user.credit),
//                             _tableCellActions(product),
//                           ],
//                         ),
//                     ],
//                   ),
//                 );
//               } else if (state is IinitialState) {
//                 productsBloc.add(GetProductsEvent());
//                 return Loading();
//               } else if (state is ErrorState) {
//                 productsBloc.add(GetProductsEvent());

//                 return Loading();
//               } else {
//                 return Loading();
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _inputField(
//       TextEditingController controller, String hint, bool numberOrNot) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: numberOrNot ? TextInputType.number : null,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         hintText: hint,
//         hintStyle: TextStyle(
//           color: Colors.grey[600],
//           fontSize: 16,
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       ),
//       onFieldSubmitted: (value) {
//         // Call _addProfile() when Enter is pressed.
//         _addProfile(null);
//       },
//     );
//   }

//   Widget _tableHeaderCell(String text) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 17,
//         ),
//       ),
//     );
//   }

//   Widget _tableCell(String text) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         text,
//         style:
//             TextStyle(fontSize: 19, color: Color(0xff202020).withOpacity(0.8)),
//       ),
//     );
//   }

//   bool isDate1BeforeDate2(String yyyymmdd1, String yyyymmdd2) {
//     DateTime date1 = DateTime.parse(yyyymmdd1);
//     DateTime date2 = DateTime.parse(yyyymmdd2);

//     return date1.isBefore(date2);
//   }

//   Widget _tableCellActions(ProductEntity user) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: Icon(Icons.edit, color: Colors.blue),
//           onPressed: () {
//             _editProfile(user);
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.refresh, color: Colors.green),
//           onPressed: () {
//             _renewProfile(user);
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () {
//             _deleteProfile(user);
//           },
//         ),
//         // Checkbox(
//         //   value: user.isSessionMarked,
//         //   onChanged: (bool? value) {
//         //     _toggleSessionMark(user, value!);
//         //   },
//         // ),
//       ],
//     );
//   }
// }
