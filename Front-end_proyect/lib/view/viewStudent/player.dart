// player.dart
class Player {
  String name;
  int score;

  Player({required this.name, this.score = 0});

  void addPoints(int points) {
    score += points;
  }
}