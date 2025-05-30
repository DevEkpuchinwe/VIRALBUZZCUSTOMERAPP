import 'package:cabbieuser/core/utils/method.dart';
import 'package:cabbieuser/core/utils/url_container.dart';
import 'package:cabbieuser/data/services/api_service.dart';

class PrivacyRepo {
  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic> loadAboutData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}';

    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }
}
