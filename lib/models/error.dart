class CustomError extends Error {
  final String title;
  final String message;
  final List<String>? solutions;

  CustomError({
    required this.title,
    required this.message,
    this.solutions,
  });
}
