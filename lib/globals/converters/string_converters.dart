class StringConverters {
  static String? toSentenceCase(String? input) {
    if (input == null) {
      return input;
    }

    final sentenceCase =
        input[0].toUpperCase() + input.substring(1).toLowerCase();
    return sentenceCase;
  }

  static String? toTitleCase(String? input) {
    if (input == null) {
      return null;
    } else {
      // Define filler words
      List<String> fillerWords = ['and', 'to', 'the', 'so', 'if', 'was', 'in'];

      // Split the input string into words
      List<String?>? words = input.split(' ');

      // Capitalize words based on rules
      for (int i = 0; i < words.length; i++) {
        String? word = words[i];

        // Capitalize first letter if it's not a filler word or the first word
        if (!fillerWords.contains(word) || i == 0) {
          words[i] =
              '${word?[0].toUpperCase()}${word?.substring(1).toLowerCase()}';
        }
      }

      // Join the words back into a single string
      String? result = words.join(' ');

      return result;
    }
  }

  static List<String> splitStringIntoChunksCharsOrNums(String input) {
    final RegExp regex = RegExp(r'\d+|[A-Za-z]+');
    final List<String> chunks =
        regex.allMatches(input).map((match) => match.group(0)!).toList();
    return chunks;
  }

// Split a string into chunks at each capital letter
  static List<String> splitStringIntoChunksAtCapitalLetters(String input) {
    final RegExp regex = RegExp(r'[A-Z][a-z]*');
    final List<String> chunks =
        regex.allMatches(input).map((match) => match.group(0)!).toList();
    return chunks;
  }

  //Remove html tags from a string
  static String removeHtmlTags(String input) {
    final RegExp regex = RegExp(r'<[^>]*>');
    final String result = input.replaceAll(regex, '');
    return result;
  }
}
