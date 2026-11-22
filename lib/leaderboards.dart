class Leaderboards {
  String username = "Guest";
  String difficulty;
  int highScore = 0;

  Leaderboards(String user, this.difficulty, score);

  set user(String username) {
    if (username == this.username) {
      return;
    } else {
      this.username = username;
    }
  }

  String get name => this.username;

  set score(int score) {
    if (score > highScore) {
      highScore = score;
    }
  }
}

class LeaderboardStorage {
  List<Leaderboards> _lb = [];

  void updateScore(String user, int score, String difficulty) {
    for (Leaderboards l in _lb) {
      if (l.username == user) {
        if (l.highScore < score) {
          l.highScore = score;
        }
      }
    }
    lb.add(Leaderboards(user, difficulty, score));
  }

  List<Leaderboards> get lb => _lb;
}
