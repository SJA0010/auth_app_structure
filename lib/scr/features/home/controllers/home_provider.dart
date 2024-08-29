import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth_app_structure/scr/models/staticdata.dart';
import 'package:auth_app_structure/scr/models/user_model.dart';
import 'package:flutter/material.dart';

class AllUsersProvider extends ChangeNotifier {
  // List to store all users except the currently logged-in user
  List<UserModel> _allUsers = [];

  // Getter for allUsers list
  List<UserModel> get allUsers => _allUsers;

  // A flag to indicate if data is being fetched
  bool _isLoading = false;

  // Getter for isLoading flag
  bool get isLoading => _isLoading;

  // Function to fetch the list of users from Firestore
  Future<void> getUserList() async {
    _setLoading(true);
    _allUsers.clear();

    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("AllUsers")
          .where("userid", isNotEqualTo: Staticdata.model!.userid)
          .get();

      for (var data in query.docs) {
        UserModel model =
            UserModel.fromMap(data.data() as Map<String, dynamic>);
        _allUsers.add(model);
      }

      notifyListeners(); // Notify listeners after fetching the data
    } catch (e) {
      // Handle errors if any
      print('Error fetching users: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Function to delete a user from Firestore
  Future<void> deleteUser(String userId) async {
    _setLoading(true);
    try {
      await FirebaseFirestore.instance
          .collection("AllUsers")
          .doc(userId)
          .delete();
      _allUsers.removeWhere((user) => user.userid == userId);
      notifyListeners(); // Notify listeners after deleting the user
    } catch (e) {
      // Handle errors if any
      print('Error deleting user: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Function to update a user in Firestore
  Future<void> updateUser(
      String userId, Map<String, dynamic> updatedData) async {
    _setLoading(true);
    try {
      await FirebaseFirestore.instance
          .collection("AllUsers")
          .doc(userId)
          .update(updatedData);

      int index = _allUsers.indexWhere((user) => user.userid == userId);
      if (index != -1) {
        // Merge the existing user data with the updated data
        UserModel updatedUser = _allUsers[index];
        updatedUser = UserModel(
          userid: userId,
          userName: updatedData['userName'] ?? updatedUser.userName,
          email: updatedData['email'] ?? updatedUser.email,
          phone: updatedData['phone'] ?? updatedUser.phone,
          password: updatedUser.password, // Assuming password remains unchanged
        );
        _allUsers[index] = updatedUser;
        notifyListeners(); // Notify listeners after updating the user
      }
    } catch (e) {
      // Handle errors if any
      print('Error updating user: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Function to set the loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
