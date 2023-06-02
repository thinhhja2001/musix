import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FirebaseDynamicLinkGenerator {
  static Future<Uri> generateSharingPostLink(String postId) async {
    String dynamicLink = "https://example.com/post/$postId";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(dynamicLink),
        uriPrefix: "https://musixsocial.page.link",
        androidParameters:
            const AndroidParameters(packageName: "com.example.musix"),
        iosParameters: const IOSParameters(bundleId: "com.example.musix"));
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortLink.shortUrl;
  }
}
