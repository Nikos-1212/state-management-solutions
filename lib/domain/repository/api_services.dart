import 'package:state_management/domain/entity/user_model.dart';
import 'package:state_management/domain/repository/user_repository.dart';

abstract class ApiService {
  // Define methods for making API requests.
  Future<UserModel> getUsers(int offset,int limit);  
  // Add more methods for different HTTP verbs and API actions.

  // Define a method for initializing the API service.
  factory ApiService() {
    // Implement a factory constructor to create an instance of a concrete API service.
    return MyApiService(); // Replace with your concrete API service class.
  }
}
