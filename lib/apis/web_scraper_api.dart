import 'package:musix/utils/constant.dart';
import 'package:web_scraper/web_scraper.dart';

class WebScraperApi {
  static Future<String> getThumbnailUrl(String url) async {
    final webScraper = WebScraper('https://listn.to');
    if (await webScraper.loadWebPage(url)) {
      List<Map<String, dynamic>> imgElement =
          webScraper.getElement('img.w-50', ['src']);
      return imgElement[0]['attributes']['src'];
    }
    return noImageUrl;
  }
}
