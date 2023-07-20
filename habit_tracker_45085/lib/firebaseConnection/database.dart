import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  Future<List<String>> getHabitsByCategory(String category) async {
    List<String> habits = List.empty();
    return habits;
  }

  Future<List<String>> getAllHabits() async {
    List<String> habits = List.empty();
    return habits;
  }

  Future<Map<String, dynamic>?> getHabitById(String habitId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('habits')
          .where('id', isEqualTo: habitId)
          .get();
      if (querySnapshot.size > 0) {
        // Retrieve the first document from the querySnapshot
        var doc = querySnapshot.docs[0];
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {'id': data['id'], 'name': data['name']};
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching category: $error');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();

      if (querySnapshot.size > 0) {
        // Retrieve the first document from the querySnapshot
        var doc = querySnapshot.docs[0];
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'id': data['id'],
          'notificationsActive': data['notificationsActive'],
          'selectedHabits':
              List<Map<String, dynamic>>.from(data['selectedHabits']),
        };
      } else {
        // No matching documents found
        return null;
      }
    } catch (error) {
      print('Error fetching user: $error');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      List<Map<String, dynamic>> categories = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'id': data['id'],
          'nome': data['nome'],
          'habitos': List<String>.from(data['habitos'])
        };
      }).toList();
      return categories;
      // Use the retrieved categories as needed
    } catch (error) {
      print('Error fetching categories: $error');
    }

    return null;
  }

  Future<Map<String, dynamic>?> getCategoryById(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where('id', isEqualTo: categoryId)
          .get();

      if (querySnapshot.size > 0) {
        // Retrieve the first document from the querySnapshot
        var doc = querySnapshot.docs[0];
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'id': data['id'],
          'nome': data['nome'],
          'habitos': List<String>.from(data['habitos']),
        };
      } else {
        // No matching documents found
        return null;
      }
    } catch (error) {
      print('Error fetching category: $error');
      return null;
    }
  }

  Future<bool> addHabitToUser(String userId, String habitId, String description,
      bool repetition, List<String> weekdays, String timeOfDay) async {
    try {
      Map<String, dynamic> newHabit = {
        "habitId": habitId,
        "description": description,
        "repetition": repetition,
        "weekdays": weekdays,
        "time": timeOfDay
      };
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();

      // Retrieve the current data of the user document
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first matching document
        DocumentSnapshot userSnapshot = querySnapshot.docs[0];

        // Get the current selectedHabits array
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        List<dynamic> selectedHabits = userData['selectedHabits'];

        // Check if the habit with the given habitId already exists in selectedHabits
        bool habitExists =
            selectedHabits.any((habit) => habit['habitId'] == habitId);

        if (habitExists) {
          return false; // Habit with the given habitId already exists
        }

        // Append the new habit to the selectedHabits array
        selectedHabits.add(newHabit);

        // Update the selectedHabits field in the user document
        await userSnapshot.reference.update({'selectedHabits': selectedHabits});

        return true;
      } else {
        return false; // User not found
      }
    } catch (error) {
      print('Error adding habit to user: $error');
      return false;
    }
  }

  Future<bool> registerUser(
      String userId, bool notificationsActive, bool withGoogle) async {
    try {
      // Check if the user already exists
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists && !withGoogle) {
        // User already exists and registration is not done with Google, return false
        return false;
      } else if (userSnapshot.exists && withGoogle) {
        // User already exists and registration is done with Google, return true
        return true;
      }

      // Define the user template
      Map<String, dynamic> user = {
        "id": userId,
        "notificationsActive": notificationsActive,
        "selectedHabits": [], // Empty array for no selected habits
      };

      // Create the user document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId) // Set the document ID
          .set(user);

      return true;
    } catch (error) {
      print('Error creating user: $error');
      return false;
    }
  }

  Future<bool> removeHabitFromUser(String userId, String habitId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();
      // Retrieve the current data of the user document
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first matching document
        DocumentSnapshot userSnapshot = querySnapshot.docs[0];

        // Get the current selectedHabits array
        Map<String, dynamic> selectedH =
            userSnapshot.data() as Map<String, dynamic>;
        List<dynamic> selectedHabits = selectedH['selectedHabits'];

        // Find the index of the habit to be removed
        int habitIndex =
            selectedHabits.indexWhere((habit) => habit['habitId'] == habitId);

        if (habitIndex != -1) {
          // Remove the habit from the selectedHabits array
          selectedHabits.removeAt(habitIndex);

          // Update the selectedHabits field in the user document
          await userSnapshot.reference
              .update({'selectedHabits': selectedHabits});
        }
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error fetching category: $error');
      return false;
    }
  }

  Future<bool> updateToken(String userId, String token) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .get();

      if (querySnapshot.size > 0) {
        // Retrieve the first document from the querySnapshot
        var doc = querySnapshot.docs[0];
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check if the 'token' field exists in the data
        if (data.containsKey('token')) {
          // If the 'token' field exists, update its value
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'token': token,
          });
        } else {
          // If the 'token' field doesn't exist, add it to the data
          await FirebaseFirestore.instance.collection('users').doc(userId).set(
              {
                'token': token,
              },
              SetOptions(
                  merge:
                      true)); // SetOptions(merge: true) ensures that it only adds the 'token' field without overwriting other data.
        }

        return true;
      } else {
        // No matching documents found
        return false;
      }
    } catch (error) {
      print('Error fetching/updating user: $error');
      return false;
    }
  }

  Future<String> getDeveloperImage() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef = storage.ref().child('foto_program.png');
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print('Error getting image URL: $e');
      return "";
    }
  }
}
