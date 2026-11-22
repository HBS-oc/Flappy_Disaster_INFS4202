class Leaderboards {
  String username = "Guest";
  String difficulty;
  int highScore = 0;

  Leaderboards(this.username, this.difficulty, this.highScore);

  set user(String username) {
    if (username == this.username) {
      return;
    } else {
      this.username = username;
    }
  }

  String get name => username;

  set score(int score) {
    if (score > highScore) {
      highScore = score;
    }
  }
}

class LeaderboardStorage {
  static final List<Leaderboards> lb = [];

  void updateScore(String user, int score, String difficulty) {
    for (Leaderboards l in lb) {
      if (l.username == user && l.difficulty == difficulty) {
        if (l.highScore < score) {
          l.highScore = score;
        }
        return;
      }
    }
    lb.add(Leaderboards(user, difficulty, score));
  }

  void createUser(String user) {
    if (user == "Guest") {
      return;
    }
    lb.add(Leaderboards(user, "Easy", 0));
    lb.add(Leaderboards(user, "Medium", 0));
    lb.add(Leaderboards(user, "Hard", 0));
  }

  static List<Leaderboards> getUserScores(String user) {
    List<Leaderboards> allScores = [];

    for (Leaderboards l in lb) {
      if (l.username == user) {
        allScores.add(l);
      }
    }
    return allScores;
  }
}
