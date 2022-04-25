String convertStringToSnakeCase(String input) =>
    input.toLowerCase().trim().replaceAll(RegExp(r'[\s]+'), '_');
