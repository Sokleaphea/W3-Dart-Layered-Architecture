import 'dart:io';
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() {
  const quizFilePath = 'lib/data/quiz.json';
  final repo = QuizRepository(quizFilePath);

  final Map<String, int> scoreboard = {};
  final List<Player> currentPlayers = [];

  print("--- Welcome to the Quiz ---\n");
  while (true) {
    stdout.write('Your name: ');
    String? name = stdin.readLineSync();

    if (name == null || name.trim().isEmpty) {
      print('--- Quiz Finished ---');
      break;
    }

    Quiz fileQuiz = repo.readQuiz();
    final List<Question> questions = fileQuiz.questions;

    Player player = Player(name: name);
    currentPlayers.add(player);

    Quiz quiz = Quiz(questions: questions, players: currentPlayers);

    QuizConsole console = QuizConsole(quiz: quiz);
    console.startQuiz(player);

    try {
      repo.writePlayer(currentPlayers, questions);
    } catch (e) {
      print('Failed to save player answers: $e');
    }

    final int scoreInPoints = quiz.getScore(player);
    scoreboard[player.name] = scoreInPoints;
    console.printResult(player, scoreboard);
  }
  // List<Question> questions = [
  //   Question(
  //       title: "Capital of France?",
  //       choices: ["Paris", "London", "Rome"],
  //       goodChoice: "Paris",
  //       points: 10),
  //   Question(
  //       title: "2 + 2 = ? (50 points)",
  //       choices: ["2", "4", "5"],
  //       goodChoice: "4",
  //       points: 50),
  // ];

  // Quiz quiz = Quiz(questions: questions, player: );
  // QuizConsole console = QuizConsole(quiz: quiz);

  // console.startQuiz();
}
