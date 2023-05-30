import 'package:puppeteer/puppeteer.dart';

void main(List<String> args) async {
  print("Starting chrome");
  var revisionInfo = await downloadChrome(cachePath: "../../.local-chromium");
  String executablePath = revisionInfo.executablePath;
  print("Opening browser");
  Browser browser = await puppeteer.launch(
    headless: false,
    executablePath: executablePath,
    args: ['--remote-allow-origins=*'],
    //args: ['--remote-debugging-port=4000'], //pass the port if needed
  );
  print("browserWsEndpoint : ${browser.wsEndpoint}");

  // we can use ngrok to use this Websocket url on Mobile or other platforms to test
  // To test locally :
  // install ngrok and run command  : ngrok http 4000 : here port number can be of your choice
  // then get url from ngrok and replace that with this url of `browser.wsEndpoint`
  // example: replace : ws://127.0.0.1:9000/devtools/browser/e35cadc1-5e6a-4ef9-ba9d-fb835cbfeb0f
  // with : ws://NGROK_URL_WITHOUT_HTTP/devtools/browser/e35cadc1-5e6a-4ef9-ba9d-fb835cbfeb0f
  // ngrok url will look similar to this : https://7e69-59-89-121-235.ngrok.io ,
  //  so replace : 127.0.0.1:9000  -> 7e69-59-89-121-235.ngrok.io
}
