import 'package:aoe2quiz/app_state.dart';

void sendEvent(String logEvent) {
  Future.delayed(Duration.zero, () async {
    await AppQuizState.analytics
        .logEvent(
        name: logEvent,
        parameters: {

        }
    );
  });
}