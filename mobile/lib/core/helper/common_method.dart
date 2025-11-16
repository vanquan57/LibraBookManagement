/// get page number from URL string
/// 
/// @param {String?} url - The URL string
/// 
/// @return {int?} - The page number or null if not found
int? getPageFromUrl(String? url) {
  if (url == null) return null;
  final uri = Uri.parse(url);
  return int.tryParse(uri.queryParameters['page'] ?? '');
}
