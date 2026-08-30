String resolveBlogAssetUrl(String assetUrl) {
  return Uri.parse(assetUrl).hasScheme
      ? assetUrl
      : Uri.base.resolve(assetUrl).toString();
}
