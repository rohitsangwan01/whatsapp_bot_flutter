import 'package:puppeteer/puppeteer.dart';

void main(List<String> args) async {
  print("Starting chrome");
  RevisionInfo revisionInfo =
      await downloadChrome(cachePath: "../.local-chromium");
  String executablePath = revisionInfo.executablePath;
  print("Opening browser");
  Browser browser = await puppeteer.launch(
    headless: false,
    executablePath: executablePath,
  );
  print("browserWsEndpoint : ${browser.wsEndpoint}");
}
