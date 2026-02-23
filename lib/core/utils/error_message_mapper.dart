class ErrorMessageMapper {
  static String map(String? message) {
    if (message == null || message.isEmpty) {
      return 'Something went wrong. Please try again.';
    }

    final lower = message.toLowerCase();

    if (lower.contains('unable to resolve host') ||
        lower.contains('no address associated') ||
        lower.contains('network is unreachable') ||
        lower.contains('no internet') ||
        lower.contains('a]server with the specified hostname could not be found')) {
      return 'No internet connection.\nPlease check your network and try again.';
    }

    if (lower.contains('timeout') || lower.contains('timed out')) {
      return 'Connection timed out.\nPlease try again.';
    }

    if (lower.contains('connection refused') ||
        lower.contains('connection reset')) {
      return 'Unable to connect to server.\nPlease try again later.';
    }

    return 'Something went wrong.\nPlease try again.';
  }
}
