import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../post/post.dart';

class FirebaseDynamicLinkGenerator {
  static Future<Uri> generateSharingPostLink(Post post) async {
    String dynamicLink = "https://example.com/post/${post.id}";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(dynamicLink),
        uriPrefix: "https://musixsocial.page.link",
        socialMetaTagParameters: SocialMetaTagParameters(
            title: post.fileName,
            description: post.content,
            imageUrl: Uri.parse(post.thumbnailUrl!)),
        androidParameters:
            const AndroidParameters(packageName: "com.example.musix"),
        iosParameters: const IOSParameters(bundleId: "com.example.musix"));
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortLink.shortUrl;
  }
}
