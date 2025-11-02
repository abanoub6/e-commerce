import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/constants.dart';
import 'package:e_commerce_app/core/error/app_exepetions.dart';
import 'package:e_commerce_app/features/cart/data/data-sources/cart_remote_data_source.dart';
import 'package:e_commerce_app/features/cart/data/models/cart_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRemoteDataSource)
class CartApiRemoteDataSource implements CartRemoteDataSource {
  final Dio dio;
  CartApiRemoteDataSource(this.dio);
  @override
  Future<void> addToCart(String productId) async {
    try {
      await dio.post(ApiConstants.cartEndPoint, data: {'productId': productId});
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteExeption(
        message ?? 'Something went wrong, please try again later.',
      );
    }
  }

  @override
  Future<CartResponse> deleteFromCart(String productId) async {
    try {
      final response = await dio.delete(
        "${ApiConstants.cartEndPoint}/$productId",
      );

      return CartResponse.fromJson(response.data);
    } catch (exception) {
      log(exception.toString());
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteExeption(
        message ?? 'Something went wrong, please try again later.',
      );
    }
  }

  @override
  Future<CartResponse> getCart() async {
    try {
      final response = await dio.get(ApiConstants.cartEndPoint);

      return CartResponse.fromJson(response.data);
    } catch (exception) {
      log(exception.toString());
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteExeption(
        message ?? 'Something went wrong, please try again later.',
      );
    }
  }

  @override
  Future<CartResponse> updateCart(String productId, int quantity) async {
    try {
      final response = await dio.put(
        "${ApiConstants.cartEndPoint}/$productId",
        data: {'count': quantity},
      );

      return CartResponse.fromJson(response.data);
    } catch (exception) {
      log(exception.toString());
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteExeption(
        message ?? 'Something went wrong, please try again later.',
      );
    }
  }
}
