import 'package:aoe2quiz/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserQuiz {
  static final FirebaseAuth fAuth = FirebaseAuth.instance;
  static String name = 'User';
  static int money = 100;

  static savePlayer() async {
    if (fAuth.currentUser != null) {
      return await AppQuizState.users.doc(fAuth.currentUser!.uid).set({
        'gold': money,
        'name': name,
      });
    }
}

  static loadPlayer() async {
    if (UserQuiz.fAuth.currentUser != null) {
      var user = await AppQuizState.users.doc(UserQuiz.fAuth.currentUser!.uid).get();
      UserQuiz.money = user['gold'];
      UserQuiz.name = user['name'];
    }
  }
}