'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f713719b9eb8232cef8adc0e139bf93c",
"version.json": "855c48f59be178a656534f4340f1c946",
"splash/img/light-background.png": "9b765af74ad2ad99c0f19864cf8265a7",
"splash/img/dark-background.png": "9b765af74ad2ad99c0f19864cf8265a7",
"splash/style.css": "e992cb11850508119ff7b9c7c80df28e",
"index.html": "c949af137b62521df2d32a74da049b3f",
"/": "c949af137b62521df2d32a74da049b3f",
"main.dart.js": "8104d1a1093ee87bb6f78d0ba1d18c3a",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "d8170ed7f45ad6cf9f2ec72b72011e4c",
"main.dart.mjs": "e024bf44a5869548378131abbc2f663a",
"icons/Icon-192.png": "cdedfa79d5e11762d68ffb99d9c07a91",
"icons/Icon-maskable-192.png": "cdedfa79d5e11762d68ffb99d9c07a91",
"icons/Icon-maskable-512.png": "3fd35df1c0c3ff5cb22652a457957ee0",
"icons/Icon-512.png": "3fd35df1c0c3ff5cb22652a457957ee0",
"manifest.json": "1b245f39b82b030f8aa0290c8287c404",
"main.dart.wasm": "6fc4c4fe24d89d4a2edeba8c6b5dc8f3",
"assets/AssetManifest.json": "5bfef430b1e9400f6564b29a50793af5",
"assets/NOTICES": "bd60389a9ada78916ca2ce623f6b5f46",
"assets/FontManifest.json": "4ecf016546c12cf5b1e1271e95b1c5e1",
"assets/AssetManifest.bin.json": "d686e3aa85978063eab3746245298a99",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "f133a2bac5efd953ff2a31af6204efd8",
"assets/fonts/Sen/Sen-SemiBold.ttf": "ce6e5d92e29fa7eff071b249f5e315a5",
"assets/fonts/Sen/Sen-Regular.ttf": "32c160ed42f66e2434bba3af9c5fb375",
"assets/fonts/Sen/Sen-Bold.ttf": "66f22ad6aacdc3564847bf2e1f5bcd3d",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/assets/icon.png": "558c62e311b350d2fbe1ca2c7f50f15c",
"assets/assets/images/blurred_red.webp": "b088b73dd90518fee363db1d0d625ed0",
"assets/assets/images/blurred_green.webp": "7c3afa59ebe31815763a80d667b31578",
"assets/assets/images/blurred_yellow.webp": "a05b507e6b1928178a03428e94a5584d",
"assets/assets/images/blurred_purple.webp": "afc1cd5a2546189bb99d6685baa97a19",
"assets/assets/images/stars_standard.webp": "f900a9b5bf4ca75e13701b44263ba714",
"assets/assets/images/blurred_blue.webp": "2680d46b802c0d63b0c9cd0cd959f33d",
"assets/assets/images/stars_dark.webp": "be312987cb9c24216e4f61b4c5d15a44",
"assets/assets/images/stars_light.webp": "ee5a3e7170b46c096e69d0be7f8af77a",
"assets/assets/images/blurred_grey.webp": "f57c42fbc446e92dab6742bb999821bc",
"assets/assets/confetti.riv": "d46385d7913a605708810a4cbc69dc17",
"assets/assets/splash.png": "9b765af74ad2ad99c0f19864cf8265a7",
"assets/assets/videos/josip.mp4": "5a29f56ef8991feaf4149fec86dc8617",
"assets/assets/audio/welcome_to_moderni_alias.mp3": "93a83cf66f7641adb8e072c1f401e950",
"assets/assets/audio/correct.wav": "fbe469173ed45a64cd76a5b71d887027",
"assets/assets/audio/wrong.wav": "1638a490f6824195039397a93da1ea8c",
"assets/assets/audio/time_game_end.wav": "c8779c99909b57e5587218c8bd7e12bb",
"assets/assets/audio/timer.wav": "ec2ca7c2f32d3d403f884cf7e48009d7",
"assets/assets/icons/united_kingdom.svg": "8adcc892f864edc6e18ce17d3d0ecb83",
"assets/assets/icons/conversation-up.svg": "97df1d276c91e480074c0cc6fc860f8f",
"assets/assets/icons/list.webp": "d204038b1b92e6c101f81b303c69be27",
"assets/assets/icons/arrow_settings.webp": "761413a69b13b8d7cf3f92b6df80874e",
"assets/assets/icons/info.webp": "3ab17d4e2acb20be717584105a0e6961",
"assets/assets/icons/dice.webp": "9fb066cbb6af3399160127d4e288581c",
"assets/assets/icons/points.webp": "97f08ea25d931fd88e0c2fb036c29b5d",
"assets/assets/icons/correct.svg": "52c99c6773c4ee1d6402afcbc71623ec",
"assets/assets/icons/wrong.svg": "d86c1099c9b42fc1d6bd4b6a761a717a",
"assets/assets/icons/hourglass.webp": "c312e6f63626d656cb827c2dbd36df50",
"assets/assets/icons/croatia.svg": "722865bb4b40652e5ae7b5fc07ccda53",
"assets/assets/icons/clap.svg": "09ff618741204b3ed6b2eae408c2be0d",
"assets/assets/icons/croatia_color.webp": "f8e7f70fc3e3a702e6aca449427270e8",
"assets/assets/icons/united_kingdom_color.webp": "83ec9b0a825f9c66958a693a312226d2",
"assets/assets/icons/arrow_stats.webp": "a79fe3c9b1f9319c4057da61cad7d378",
"assets/assets/icons/settings.webp": "a1d867ac9d28ee08d99589c2d5e63dc5",
"assets/assets/icons/conversation-down.svg": "1feeb9526a1a9560dd2f801c1ccff1b3",
"assets/assets/icons/howto.webp": "3d55ba004196575a6ffd3cdcaca538ec",
"assets/assets/icons/click.svg": "760716778931e82609c81d6af4a53657",
"assets/assets/icons/share.webp": "95cd7e8332b4909c5c59713d1f37499d",
"assets/assets/icons/clock.webp": "13d0f293dad803278e88d32f6fae8e6e",
"assets/assets/translations/en.json": "fb79898733dee93792af66d423ccb72d",
"assets/assets/translations/hr.json": "0fb63c3417e9e6a4b3521d866a371e46",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
