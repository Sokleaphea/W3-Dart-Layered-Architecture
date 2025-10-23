import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz(Player player) {
    print('');
    for (var question in quiz.questions) {
      print('Question: ${question.title} - ${question.points}');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput);
        quiz.addAnswer(player, answer);
      } else {
        print('No answer entered. Skipping question.');
      }
    }
  }
  void printResult(Player player, Map<String, int> allPlayerScore) {
    int score = quiz.getScoreInPercentage(player);
    int scoreInPoint = quiz.getScore(player);
    print('--- Quiz Finished ---');
    print('${player.name}, your score is ${score}% correct');
    print('${player.name}, your score is ${scoreInPoint} correct');

    allPlayerScore[player.name] = scoreInPoint;

    for (var entry in allPlayerScore.entries) {
      print('Player: ${entry.key}\t ${entry.value}');
    }

    print('');
  }
}
