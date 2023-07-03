class GetHtmlError extends Error {
  final String message;
  GetHtmlError(this.message);
  @override
  String toString() {
    return "GetHtmlError: $message";
  }
}
