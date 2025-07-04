import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  late CacheStore _cacheStore;
  late CacheOptions _cacheOptions;

  // 初始化API服务
  void initialize({
    required String baseUrl,
    int timeoutSeconds = 30,
    int maxRetries = 3,
    bool enableLogging = true,
    bool enableCache = true,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: timeoutSeconds),
        receiveTimeout: Duration(seconds: timeoutSeconds),
        sendTimeout: Duration(seconds: timeoutSeconds),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 缓存配置
    if (enableCache) {
      _setupCache();
    }

    // 日志拦截器
    if (enableLogging) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    // 认证拦截器
    _dio.interceptors.add(AuthInterceptor());

    // 错误拦截器
    _dio.interceptors.add(ErrorInterceptor());

    // 重试拦截器
    _dio.interceptors.add(RetryInterceptor(maxRetries: maxRetries));

    // 缓存拦截器
    if (enableCache) {
      _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
    }
  }

  void _setupCache() {
    _cacheStore = MemCacheStore();
    _cacheOptions = CacheOptions(
      store: _cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );
  }

  // GET请求
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useCache = true,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: _buildOptions(options, useCache),
      );
      return ApiResponse.fromResponse<T>(response);
    } catch (e) {
      return ApiResponse.error<T>(_handleError(e));
    }
  }

  // POST请求
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResponse.fromResponse<T>(response);
    } catch (e) {
      return ApiResponse.error<T>(_handleError(e));
    }
  }

  // PUT请求
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResponse.fromResponse<T>(response);
    } catch (e) {
      return ApiResponse.error<T>(_handleError(e));
    }
  }

  // DELETE请求
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResponse.fromResponse<T>(response);
    } catch (e) {
      return ApiResponse.error<T>(_handleError(e));
    }
  }

  // 上传文件
  Future<ApiResponse<T>> upload<T>(
    String path,
    File file, {
    String? fileName,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName ?? file.path.split('/').last,
        ),
        ...?data,
      });

      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );
      return ApiResponse.fromResponse<T>(response);
    } catch (e) {
      return ApiResponse.error<T>(_handleError(e));
    }
  }

  // 下载文件
  Future<ApiResponse<String>> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(savePath);
    } catch (e) {
      return ApiResponse.error<String>(_handleError(e));
    }
  }

  Options? _buildOptions(Options? options, bool useCache) {
    if (!useCache) {
      return options?.copyWith(
        extra: {
          ...?options.extra,
          DioCacheInterceptor.REFRESH_KEY: true,
        },
      ) ?? Options(
        extra: {DioCacheInterceptor.REFRESH_KEY: true},
      );
    }
    return options;
  }

  ApiError _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiError(
            code: 'TIMEOUT',
            message: '请求超时，请检查网络连接',
            details: error.message,
          );
        case DioExceptionType.badResponse:
          return ApiError(
            code: 'HTTP_${error.response?.statusCode}',
            message: _getHttpErrorMessage(error.response?.statusCode),
            details: error.response?.data?.toString(),
          );
        case DioExceptionType.cancel:
          return ApiError(
            code: 'CANCELLED',
            message: '请求已取消',
            details: error.message,
          );
        case DioExceptionType.connectionError:
          return ApiError(
            code: 'NETWORK_ERROR',
            message: '网络连接失败，请检查网络设置',
            details: error.message,
          );
        default:
          return ApiError(
            code: 'UNKNOWN',
            message: '未知错误',
            details: error.message,
          );
      }
    }
    return ApiError(
      code: 'UNKNOWN',
      message: error.toString(),
    );
  }

  String _getHttpErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return '请求参数错误';
      case 401:
        return '未授权，请重新登录';
      case 403:
        return '权限不足';
      case 404:
        return '请求的资源不存在';
      case 500:
        return '服务器内部错误';
      case 502:
        return '网关错误';
      case 503:
        return '服务不可用';
      default:
        return '请求失败 ($statusCode)';
    }
  }

  // 清除缓存
  Future<void> clearCache() async {
    await _cacheStore.clean();
  }

  // 取消所有请求
  void cancelAllRequests() {
    _dio.clear();
  }
}

// API响应封装类
class ApiResponse<T> {
  final bool success;
  final T? data;
  final ApiError? error;
  final String? message;

  const ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.message,
  });

  factory ApiResponse.success(T data, {String? message}) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
    );
  }

  factory ApiResponse.error(ApiError error) {
    return ApiResponse<T>(
      success: false,
      error: error,
    );
  }

  factory ApiResponse.fromResponse<T>(Response<Map<String, dynamic>> response) {
    final data = response.data;
    if (data == null) {
      return ApiResponse.error<T>(
        ApiError(code: 'NO_DATA', message: '响应数据为空'),
      );
    }

    // 根据你的API响应格式调整
    final success = data['success'] as bool? ?? true;
    final message = data['message'] as String?;
    
    if (success) {
      return ApiResponse.success<T>(
        data['data'] as T,
        message: message,
      );
    } else {
      return ApiResponse.error<T>(
        ApiError(
          code: data['code'] as String? ?? 'API_ERROR',
          message: message ?? '请求失败',
          details: data.toString(),
        ),
      );
    }
  }
}

// API错误类
class ApiError {
  final String code;
  final String message;
  final String? details;

  const ApiError({
    required this.code,
    required this.message,
    this.details,
  });

  @override
  String toString() {
    return 'ApiError(code: $code, message: $message, details: $details)';
  }
}

// 认证拦截器
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 从存储中获取token
    final token = _getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token过期，清除本地token并导航到登录页
      _clearAuthToken();
      // 可以在这里发送事件通知UI跳转到登录页
    }
    handler.next(err);
  }

  String? _getAuthToken() {
    // 从SharedPreferences或安全存储中获取token
    // 这里需要实现具体的存储逻辑
    return null;
  }

  void _clearAuthToken() {
    // 清除存储的token
    // 这里需要实现具体的清除逻辑
  }
}

// 错误拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 统一错误处理
    // 可以在这里记录错误日志
    print('API Error: ${err.toString()}');
    handler.next(err);
  }
}

// 重试拦截器
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration delay;

  RetryInterceptor({
    this.maxRetries = 3,
    this.delay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;
    
    if (retryCount < maxRetries && _shouldRetry(err)) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      
      await Future.delayed(delay * (retryCount + 1));
      
      try {
        final response = await Dio().fetch(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError ||
           (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}