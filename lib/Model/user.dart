class UserData {
  final String uid;
  final String email;
  final List<String> favoriteCities;

  UserData({required this.uid, required this.email, required this.favoriteCities});

  // Convert UserData to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'favoriteCities': favoriteCities,
    };
  }

  // Convert Firestore Map to UserData
  factory UserData.fromFirestore(Map<String, dynamic> firestore) {
    return UserData(
      uid: firestore['uid'],
      email: firestore['email'],
      favoriteCities: List<String>.from(firestore['favoriteCities']),
    );
  }
}