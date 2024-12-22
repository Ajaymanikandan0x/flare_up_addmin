import 'package:dio/dio.dart';
import '../../../../core/error/app_error.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../modal/event_category_model.dart';



abstract class EventCategoryRemoteDataSource {
  Future<List<EventCategoryModel>> getCategories();
  Future<EventCategoryModel> createCategory(String name, String description);
  Future<void> deleteCategory(String id);
  Future<EventCategoryModel> updateCategory(
      String id, String name, String description);
  Future<EventTypeModel> createEventType(String name, String description, int categoryId);
}

class EventCategoryRemoteDataSourceImpl
    implements EventCategoryRemoteDataSource {
  final Dio dio;

  EventCategoryRemoteDataSourceImpl({required this.dio}) {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    final storageService = SecureStorageService();
    final token = await storageService.getAccessToken();
    
    dio.options.baseUrl = ApiEndpoints.eventBaseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  @override
  Future<List<EventCategoryModel>> getCategories() async {
    try {
      final response = await dio.get(ApiEndpoints.getEventCategory);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => EventCategoryModel.fromJson(json)).toList();
      } else {
        throw AppError(
            userMessage: 'Failed to fetch categories',
            type: ErrorType.server,
            technicalMessage: 'Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw AppError(
          userMessage: 'Network error occurred',
          type: ErrorType.network,
          technicalMessage: e.toString());
    } catch (e) {
      throw AppError(
          userMessage: 'An unexpected error occurred',
          type: ErrorType.unknown,
          technicalMessage: e.toString());
    }
  }

  @override
  Future<EventCategoryModel> createCategory(
      String name, String description) async {
    try {
      final response = await dio.post(
        ApiEndpoints.createCategory,
        data: {
          'name': name,
          'description': description,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final categoriesResponse = await dio.get(ApiEndpoints.getEventCategory);
        final List<dynamic> data = categoriesResponse.data;
        final categories = data.map((json) => EventCategoryModel.fromJson(json)).toList();
        
        return categories.last;
      }

      throw AppError(
        userMessage: _parseErrorMessage(response.data),
        type: ErrorType.validation,
        technicalMessage: 'Status code: ${response.statusCode}, Data: ${response.data}',
      );
    } on DioException catch (e) {
      print('DioError: ${e.message}');
      print('DioError response: ${e.response?.data}');
      rethrow;
    }
  }

  String _parseErrorMessage(dynamic data) {
    if (data is Map) {
      if (data.containsKey('name') && data['name'] is List) {
        return data['name'][0].toString();
      }
      return data['message'] ?? 'Failed to create category';
    }
    return 'Failed to create category';
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      final response = await dio.delete('events/categories/$id');

      if (response.statusCode != 200) {
        throw AppError(
            userMessage: 'Failed to delete category',
            type: ErrorType.server,
            technicalMessage: 'Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw AppError(
          userMessage: 'Failed to delete category',
          type: ErrorType.unknown,
          technicalMessage: e.toString());
    }
  }

  @override
  Future<EventCategoryModel> updateCategory(
      String id, String name, String description) async {
    try {
      final response = await dio.put(
        'events/categories/$id',
        data: {
          'name': name,
          'description': description,
        },
      );

      if (response.statusCode == 200) {
        return EventCategoryModel.fromJson(response.data);
      } else {
        throw AppError(
            userMessage: 'Failed to update category',
            type: ErrorType.server,
            technicalMessage: 'Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw AppError(
          userMessage: 'Network error occurred',
          type: ErrorType.network,
          technicalMessage: e.toString());
    } catch (e) {
      throw AppError(
          userMessage: 'Failed to update category',
          type: ErrorType.unknown,
          technicalMessage: e.toString());
    }
  }

  @override
  Future<EventTypeModel> createEventType(
    String name, 
    String description, 
    int categoryId,
  ) async {
    try {
      print('Making API request to create event type'); // Debug print
      final response = await dio.post(
        ApiEndpoints.createCategoryType,
        data: {
          'name': name,
          'description': description,
          'category': categoryId,
        },
      );
      
      print('API Response: ${response.data}'); // Debug print

      if (response.statusCode == 201 || response.statusCode == 200) {
        return EventTypeModel.fromJson(response.data);
      }

      print('Unexpected status code: ${response.statusCode}'); // Debug print
      throw AppError(
        userMessage: _parseErrorMessage(response.data),
        type: ErrorType.validation,
        technicalMessage: 'Status code: ${response.statusCode}, Data: ${response.data}',
      );
    } on DioException catch (e) {
      print('DioException: ${e.message}'); // Debug print
      print('DioException response: ${e.response?.data}'); // Debug print
      rethrow;
    }
  }
}
