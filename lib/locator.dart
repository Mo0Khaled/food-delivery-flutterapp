import 'package:delivery_food/network/apis.dart';
import 'package:delivery_food/providers/product_provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setUpLocator(){
  locator.registerLazySingleton(() => Api('products'),);
  locator.registerLazySingleton(() => ProductProvider(),);
}