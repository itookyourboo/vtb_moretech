import 'frequency.dart';

int calculateScore(Frequency found, int allWordsCount) {
  int score = 0;
  for (int i = 2; i <= found.longest; i++) {
    score += found[i]! * i * i;
  }

  score ~/= (1 / (1 + (found.count / allWordsCount)));

  if (found.count == allWordsCount) {
    score += (score ~/ 5);
  }

  return score;
}