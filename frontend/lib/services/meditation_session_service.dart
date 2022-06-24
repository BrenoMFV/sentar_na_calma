import 'dart:math';

import 'package:frontend/models/meditation_session.dart';

class MeditationTimerService {

  final _meditationsList = [
    MeditationSession(
      timer: const Duration(minutes: 15),
      start: DateTime(2022, 5, 10, 10, 0, 5),
      end: DateTime(2022, 5, 10, 10, 20, 5),
      totalDuration: const Duration(minutes: 20),
    ),
    MeditationSession(
      timer: const Duration(minutes: 15),
      start: DateTime(2022, 5, 11, 10, 0, 5),
      end: DateTime(2022, 5, 11, 10, 20, 5),
      totalDuration: const Duration(minutes: 20),
    ),
    MeditationSession(
      timer: const Duration(minutes: 15),
      start: DateTime(2022, 5, 12, 10, 0, 5),
      end: DateTime(2022, 5, 12, 10, 20, 5),
      totalDuration: const Duration(minutes: 20),
    ),
    MeditationSession(
      timer: const Duration(minutes: 15),
      start: DateTime(2022, 5, 13, 10, 0, 5),
      end: DateTime(2022, 5, 13, 10, 20, 5),
      totalDuration: const Duration(minutes: 20),
    ),
    MeditationSession(
      timer: const Duration(minutes: 15),
      start: DateTime(2022, 5, 14, 10, 0, 5),
      end: DateTime(2022, 5, 14, 10, 20, 5),
      totalDuration: const Duration(minutes: 20),
    ),
    MeditationSession(
      timer: const Duration(minutes: 15),
      start: DateTime(2022, 5, 15, 10, 0, 5),
      end: DateTime(2022, 5, 15, 10, 20, 5),
      totalDuration: const Duration(minutes: 20, seconds: 30),
    ),
  ];

  Future<List<MeditationSession>> getMeditationHistory(
      {required currentPage}) async {
    int itemsPerPage = 10;
    final fetchedList = <MeditationSession>[];
    final itemsLeft =
        min(itemsPerPage, _meditationsList.length - currentPage * itemsPerPage);
    await Future.delayed(const Duration(seconds: 2));
    for (int i = 0; i < itemsLeft; i++) {
      fetchedList.add(_meditationsList[i]);
    }
    return fetchedList;
  }

  void setTimer() {
    // TODO
  }

  void start() {
    // TODO
  }

  void end() {
    // TODO
  }

  void pause() {
    // TODO
  }

  void restart() {
    // TODO
  }

  void saveSession() {
    // TODO
  }
}
