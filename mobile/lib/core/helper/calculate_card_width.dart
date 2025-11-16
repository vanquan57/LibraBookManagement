/// Calculate responsive card width based on screen size
///
/// @param {double} screenWidth - The width of the screen
/// @param {double} minCardWidth - Minimum width for each card
/// @param {double} maxCardWidth - Maximum width for each card
/// @param {double} horizontalPadding - Total horizontal padding
///
/// @return {double}
double calculateCardWidth(
  double screenWidth, {
  required double minCardWidth,
  required double maxCardWidth,
  double horizontalPadding = 40,
}) {
  final availableWidth = screenWidth - horizontalPadding;
  // Calculate how many cards can fit
  final maxColumns = (availableWidth / minCardWidth).floor();
  final columns = maxColumns < 1 ? 1 : maxColumns;

  // Calculate actual card width
  final cardWidth = availableWidth / columns;

  // Return constrained width
  return cardWidth.clamp(minCardWidth, maxCardWidth);
}
