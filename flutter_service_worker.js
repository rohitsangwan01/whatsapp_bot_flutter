'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "19e2271867b6d0389bec85b3ba065d79",
"index.html": "dd12ba0623ddbae96683364f0250d12d",
"/": "dd12ba0623ddbae96683364f0250d12d",
"main.dart.js": "9d409571e19d847f87b67a5f7fe2e3ab",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"README.md": "ac7a91021815c4644b87b49967e2e30b",
"favicon.png": "9df6e245ca5a23012153e5b25daa3f49",
"icons/Icon-192.png": "781a78f45038624cedbba129e46ab1ac",
"icons/Icon-maskable-192.png": "781a78f45038624cedbba129e46ab1ac",
"icons/Icon-maskable-512.png": "68d98f74c9ee471b113cfde854eb949d",
"icons/Icon-512.png": "68d98f74c9ee471b113cfde854eb949d",
"manifest.json": "e411b6794b2cca658f11335a9bf1d076",
".git/ORIG_HEAD": "7185ff1ade0b14f678a5530622d11055",
".git/config": "66081b6bbfdee2cacf2447d217c3d198",
".git/objects/92/b478ea9f5a2b34b965e3dc1cbaa46035c1d908": "2cdfb8461306347e0ff6aa37c93d5f04",
".git/objects/6f/26601b6128f3be89060ff3e5e31f84482de8a8": "1eadeb456fe60cb4c6e2e1a6cc43cad8",
".git/objects/03/c531a7a4eadfbb97e5434401927ee31890cf33": "fe6b24f60048b7f218835d95c2c650ae",
".git/objects/32/c14d54032058e05632675b82f374afff634364": "98da3a9512d0a79a60ba71cf6e18040e",
".git/objects/35/91af41948adc8001f3586d76b91181311953fc": "c91d33b29071dcff3b2b3385383761cb",
".git/objects/69/7612b856b42c7df2f6b11a751697ce3fb59ba5": "eb2c167bd5d2090211aac5d103a33a2d",
".git/objects/51/34e6402246228fb7f58ce8fe76727a61d99a62": "6b5e5b48febe40daec7062aecdc3b39f",
".git/objects/0b/85bcdb86bf9e9f9fda81b13cec9c9349d47d77": "77cbf4b6cc88e2471afd14a98ef2e0ed",
".git/objects/5f/834c2d8c9fa0d16b299227197e5c6fce2abd66": "fafd52222aacd12d3f2e4b481d0a984e",
".git/objects/9c/101188e9f81e8005cc4672f1c5da56e96a5358": "a77b15edf6b2d3137c91f76ebdff4a43",
".git/objects/b2/2fdb2d1fa6a3bced274617d58f6ab432bb0d8b": "1b405e4dfab487f51d41422d52600614",
".git/objects/bb/7d51be3a1f4db1b5fbb7cf00555e48278429dc": "3995eb6b1b99490af056bf43212aa147",
".git/objects/bb/ac29f5ef7a40bf14c0901bc1457724156bc0de": "1393f20f0610cabefe2d4f45865b0f54",
".git/objects/ae/37803d1933c3979fd1b939ff61cc667b0b70dc": "f5c08c98e82ebd9034dbd78b64a292fa",
".git/objects/c7/0b100a3e931a84b061489fea2779cfe28d73d3": "d5a961ea0cfdacc644ec611b7760e28e",
".git/objects/c0/99424ae0d25a5d803e0593382ed64f6886f439": "0db232d36b8e2324f9b89ea0755c21ee",
".git/objects/ee/4a897d5b58742f91598dbcbfd427cb6fa5bda5": "6704bbc81e9f9a83165ec6361e29e226",
".git/objects/c9/1d532d81b39f20519dd55c1e61be7ff4cbec0d": "b786dbf6597c1845b7155b00205dfecd",
".git/objects/fb/53e8193a6d3ebd11aea827f1e29f8504aad3dd": "b1db0c88833b346da7f3ab48ae12307b",
".git/objects/pack/pack-5be63064aa67a8dca3b10d60bddbdf5aec1e43e7.idx": "6ed7e64ce0f4f3b2c12d3fb8cf00317d",
".git/objects/pack/pack-5be63064aa67a8dca3b10d60bddbdf5aec1e43e7.pack": "07d66297a710f563bae73b8e64c93d27",
".git/objects/1a/0abd88d34436fe8412c14867c7c6f7a161de5d": "6a6a993f998b39e803d8e5b950ee0cd6",
".git/objects/19/6817c3c68a9336564d35a440ec24e543a4fbc6": "49d4b11883f9531cb0c8253f7e4f0ba1",
".git/objects/72/3dfac6bb514ef426b9f046d3521c0644cc5ddc": "23c5d3063f6e6d949054d4d3938aa75b",
".git/objects/72/80bdddbc17dfe709057953d0753e5ffd0f0f2e": "ba56b40d645a0f16807ab3de83ab0ea1",
".git/objects/5c/a017893b2927c9a549a678278c883a97ef2a0d": "ae6097befff3fad1d76396cd065264d6",
".git/objects/62/a01d6826913d9efa140d2e9f4bc0f13918e607": "44ba2af6a4f05cb190463143170ae010",
".git/objects/96/39692cd02d1138b5514204c55e170c29736cf3": "14879eebbf4f6c2231e185a1a5c9a248",
".git/objects/3a/d9df9efac9476e3c317a942113940ab612a92e": "0653848a5ec9656f0e3c13358a7f6a34",
".git/objects/54/510f51ffe0aad87e06759005371c93a99b3fde": "4c65d8ae62a91dd12b0532e8cad153c4",
".git/objects/37/7580cbf691d03aea79c63a3a251b1b48ac01f1": "c196d282a50e3c372b4445c6b8868297",
".git/objects/08/0bcc923708220b2497811e3c78f0f904e82bf8": "56e4df5fbaedf640e7c4038e1b69e124",
".git/objects/d3/efa7fd80d9d345a1ad0aaa2e690c38f65f4d4e": "610858a6464fa97567f7cce3b11d9508",
".git/objects/cc/17cee58659d64e0d326a5f544dbf2cca38466b": "1b802112ab35e302b953f371a8a78613",
".git/objects/e0/eb8b23371d1800e02b7147b5b8d8d578d024b0": "ccfcf716bc8e3363c3db1e5c0449bae3",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/46/4111dcdfceb0fa07cff05a5d42e0cff1b72458": "24178633ba332e4039ff6d200061e035",
".git/objects/79/bf70adfb12ef25437b5399ed559a21292503b0": "b522b66a51f32f30321d5e1905fdb579",
".git/objects/79/0acc930729c8d987144663b6048fa7777909f8": "1132bffeb0842aaadedd789b1bbdca6d",
".git/objects/77/994057bc051b0eec4794baffb364f7f05bf4f8": "483155db50bcd8ad2d40a4cf33721969",
".git/objects/48/5026b8f5c9fdb877033a9c1840105051b76623": "f6ac4c3261b4b257ef988e6131b1b9da",
".git/objects/1e/bf993c04c08e17a0122730f8d7ce6e139c8bad": "eeb4f0d71f24758335fe1753273ad6c2",
".git/objects/24/045a64cf6e56eb081718ad425fdefb60cef50d": "8b60bd6c72418674ec08ec87df7e7518",
".git/objects/1d/384f3748038966a5c7316223edf120dd5894dd": "a8d542276aa823dfefb8d26439e1077a",
".git/objects/7f/8b16bfb264bf6169178b56f131e6c70240f59f": "e8c37727c78aed18204f2c3ce459c477",
".git/objects/8e/7f4b338840099949781ab85496d7a67fae46f1": "7f2803c236e9e7d95ef6ed16a3a2bd13",
".git/HEAD": "4bc70ef0e6a7fdd050a2fc8a17065f16",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "97470e28171d7d3ba43123ac6b068cd9",
".git/logs/refs/heads/main": "754c7c8297056ac42f0d1a0eab8a8b9b",
".git/logs/refs/heads/pages": "e9d9e6cf2173a8a5c62e9f5813e2285e",
".git/logs/refs/remotes/origin/main": "b83a91647b131cd7799366888daf9dfd",
".git/logs/refs/remotes/origin/pages": "3f3519206abfba2c829c9e13a162959a",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "3fe323e5afd6117a668f4f573be3d32b",
".git/refs/heads/pages": "7e781751e17179429221d564e188702c",
".git/refs/remotes/origin/main": "32f363de71b8397fa0681c0c1bf26e0c",
".git/refs/remotes/origin/pages": "7e781751e17179429221d564e188702c",
".git/index": "cf802ead07599c90009e9552c7fbf66b",
".git/COMMIT_EDITMSG": "2d04370062f7afdab74f98e73facd205",
".git/FETCH_HEAD": "791fd05a62ecc1dbd7d90d32df5cdf2e",
"assets/AssetManifest.json": "0ce45fd97338e4fbdc86b612106371e9",
"assets/NOTICES": "c6397c84a217336c050e470866835265",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/packages/flutter_inappwebview/assets/web/web_support.js": "1c365cc5ce2a69c366034266252d2cfa",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.smcbin": "e1e0d4ee792e24e77b76298e17df9ee3",
"assets/fonts/MaterialIcons-Regular.otf": "4fd503e071720fc9ff1507ed0e71cac3",
"assets/assets/icon_transparent.png": "d41e3b1c22f7b282e82b3b20654e920a",
"assets/assets/wpp.js": "dc18dbac52715fd019f5e5bf44ad654c",
"assets/assets/icon.png": "a065cddcedbe7ad9a0783cb32db964d6",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
