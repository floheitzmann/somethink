class QuestionDeck {
  final String languageCode;
  final String name;
  final String description;
  final List<String> questions;
  List<String>? answers;

  QuestionDeck(
    this.languageCode,
    this.name,
    this.description,
    this.questions,
    this.answers,
  );
}
