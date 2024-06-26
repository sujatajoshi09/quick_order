import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:quick_order/dashboard/screens/catalogue/pages/home/bloc/bloc/home_event.dart';
import 'package:quick_order/dashboard/screens/catalogue/pages/home/bloc/bloc/home_state.dart';
import 'package:quick_order/dashboard/screens/catalogue/pages/home/model/fakestore_product.dart';

class HomeProductBloc extends Bloc<HomeProductEvent, HomeProductState> {
  List<Product> receiveCartProduct = [];
  List<Product> receiveFavouriteProducts = [];
  HomeProductBloc() : super(InitialHomeProductState()) {
    on<InitialHomeProductEvent>((event, emit) {});

    on<FetchApIEvent>((event, emit) => fetchApIEvent(event, emit));
    // on<FetchApiCatalogueEvent>(
    //     (event, emit) => fetchApiCatalogueEvent(event, emit));
    on<AddToCartClickEvent>((event, emit) => addToCartClickEvent(event, emit));
  }

  fetchApIEvent(FetchApIEvent event, Emitter<HomeProductState> emit) async {
    try {
      var response = await http.get(
        Uri.parse("https://dummyjson.com/products"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = await jsonDecode(response.body);
        List<ProductList> list = [];

        list.add(ProductList.fromJson(jsonResponse));

        // print(list[0].products);

        emit(SuccessHomeProductState(product: list));
      }
    } catch (err) {
      emit(ErrorHomeProductState());
    }
  }

  addToCartClickEvent(
      AddToCartClickEvent event, Emitter<HomeProductState> emit) {
    receiveCartProduct.add(event.addtocart);
  }

  // addToFavouriteClickEvent(
  //     AddToFavouriteClickEvent event, Emitter<HomeProductState> emit) {
  //   receiveFavouriteProducts.add(event.addtofavourite);
  // }
}
