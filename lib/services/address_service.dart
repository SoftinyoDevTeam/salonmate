import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/functions.dart';

class AddressService {
  final Dio _dio;

  AddressService()
      : _dio = Dio(BaseOptions(
          baseUrl: apiUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        ));

  Future<void> addAddress({
    required String address,
    required String city,
    required String state,
    required String zipCode,
    required String country,
  }) async {
    try {
      final formData = FormData.fromMap({
        'module': 'addAddress',
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
      });

      final response = await _dio.post(
        '?module=addAddress',
        options: Options(
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Matekey": await getPrefString("token"),
          },
        ),
        data: formData,
      );

      log(response.data.toString());
      if (response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Error adding address');
      }
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  Future<List<Address>> listAddresses() async {
    try {
      final formData = FormData.fromMap({
        'module': 'listAddresses',
      });

      final response = await _dio.post(
        '?module=listAddresses',
        options: Options(
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Matekey": await getPrefString("token"),
          },
        ),
        data: formData,
      );
      // Handle 404 case specifically for empty addresses
      if (response.statusCode == 404) {
        return [];
      }

      // Check for successful response and data existence
      if (response.statusCode == 200 && response.data != null) {
        // Handle case where data might be null or not a list
        final data = response.data['data'];
        if (data == null || data is! List) {
          return [];
        }

        return data.map<Address>((json) => Address.fromJson(json)).toList();
      }

      throw Exception(response.data['message'] ?? 'Error fetching addresses');
    } catch (e) {
      log('Error in listAddresses: $e');
      // Return empty list instead of throwing error for network issues
      return [];
    }
  }

  Future<void> updateAddress({
    required String addressID,
    required String address,
    required String city,
    required String state,
    required String zipCode,
    required String country,
  }) async {
    try {
      final formData = FormData.fromMap({
        'module': 'updateAddress',
        'addressID': addressID,
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
      });

      final response = await _dio.post(
        '?module=updateAddress',
        options: Options(
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Matekey": await getPrefString("token"),
          },
        ),
        data: formData,
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Error updating address');
      }
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  Future<void> deleteAddress(String addressID) async {
    try {
      final formData = FormData.fromMap({
        'module': 'deleteAddress',
        'addressID': addressID,
      });

      final response = await _dio.post(
        '?module=deleteAddress',
        options: Options(
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Matekey": await getPrefString("token"),
          },
        ),
        data: formData,
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Error deleting address');
      }
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }
}

class Address {
  final String id;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  Address({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['ID'].toString(),
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
    };
  }
}
