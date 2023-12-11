class ApiURL {

  final String hosturl;

  ApiURL._(this.hosturl);

  factory ApiURL.devENV()
  {
    return ApiURL._('https://api.slingacademy.com/v1/sample-data');
  }

  factory ApiURL.prodENV()
  {
    return ApiURL._('https://api.slingacademy.com/v1/sample-data');
  }

  // uat
  static const String baseURL = 'https://api.slingacademy.com/v1/sample-data';
  static const String getUserPoint ='$baseURL/users';

  //prod
  }






//Factory constructor
//   class ApiRepository {
//   final String baseUrl;
//   final String apiKey;

//   // Private constructor
//   ApiRepository._(this.baseUrl, this.apiKey);

//   // Factory constructor to create instances with custom configurations
//   factory ApiRepository.development() {
//     return ApiRepository._('https://api.dev.example.com', 'your_dev_api_key');
//   }

//   factory ApiRepository.staging() {
//     return ApiRepository._('https://api.staging.example.com', 'your_staging_api_key');
//   }

//   factory ApiRepository.production() {
//     return ApiRepository._('https://api.example.com', 'your_production_api_key');
//   }

//   // Add methods for making API requests using baseUrl and apiKey
//   Future<Response> fetchData(String endpoint) async {
//     final response = await http.get(Uri.parse('$baseUrl/$endpoint'), headers: {
//       'Authorization': 'Bearer $apiKey',
//     });
//     return Response.fromJson(response);
//   }
// }

// void fetch() {
//   // Create repository instances for different environments
//   final devRepository = ApiRepository.development();
//   final stagingRepository = ApiRepository.staging();
//   final productionRepository = ApiRepository.production();

//   // Use the repositories to make API calls
//   devRepository.fetchData('data_endpoint');
//   stagingRepository.fetchData('data_endpoint');
//   productionRepository.fetchData('data_endpoint');
// }
