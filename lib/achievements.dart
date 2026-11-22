class Achievement {
  String title;
  String id;
  int score;
  String difficulty;

  Achievement(this.title, this.id, this.score, this.difficulty);
}

class AchievementProgress {
  static List<Achievement> storage = [
    Achievement("First Flight", "first_1", 1, "Easy"),
    Achievement("First 10", "first_10", 10, "Easy"),
    Achievement("Harder Flight", "harder_1", 1, "Medium"),
    Achievement("Harder 10", "harder_10", 10, "Medium"),
    Achievement("Pro Flight", "pro_10", 10, "Hard"),
  ];
}

class Achievements {
  String user;
  List<Achievement> achi = AchievementProgress.storage;
  Achievements(this.user);

  List<double> checkAchievments() {
    List<Leaderboards> userScores = LeaderboardStorage.getUserScores(user);
    List<double> score = [];

    for (Achievement a in achi) {
      for (Leaderboards u in userScores) {
        if (u.difficulty == a.difficulty) {
          if (u.highScore > a.score) {
            score.add(1);
          } else {
            score.add(u.highScore / a.score);
          }
        }
      }
    }
    return score;
  }
}
