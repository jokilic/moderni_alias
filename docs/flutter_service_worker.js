'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "84ab04b3b50f4d13a048b3e574a201a9",
"version.json": "0f57ee2633d5de6413108df55f165cdb",
"splash/img/light-background.png": "eb2b92b2352061076c973e3d52988e95",
"splash/img/dark-background.png": "eb2b92b2352061076c973e3d52988e95",
"splash/style.css": "9170e47911462fdd9ff790f86d152e71",
"index.html": "cebc18632f3d704a5445a71f4bf468da",
"/": "cebc18632f3d704a5445a71f4bf468da",
"main.dart.js": "4f9ce54eb7be7829628292476370f35c",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "834ec7d05a15114f8281822fc0f2ed00",
"main.dart.mjs": "5af559b914959d18856b17c921c54f8c",
"icons/Icon-192.png": "8c5cf9ff066bc4492ee19924df8b6eb7",
"icons/Icon-maskable-192.png": "8c5cf9ff066bc4492ee19924df8b6eb7",
"icons/Icon-maskable-512.png": "272cb2268c2d0021d71d441235b4ee87",
"icons/Icon-512.png": "272cb2268c2d0021d71d441235b4ee87",
"manifest.json": "c6ec99638c97a528b040504ee1e4fa5c",
"main.dart.wasm": "19f0388c3da2f8e508e4607d80c5d3b0",
"assets/AssetManifest.json": "39d6ac72f6ce169bdb508613e75e30e5",
"assets/NOTICES": "32cf005a18a7bcb478cf949bc82bf814",
"assets/FontManifest.json": "4ecf016546c12cf5b1e1271e95b1c5e1",
"assets/AssetManifest.bin.json": "7ff0e5be3e1c5d191ce8f46d0f37bddc",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "b0757eb7b332b2715fac9349bb4884af",
"assets/fonts/Sen/Sen-SemiBold.ttf": "ce6e5d92e29fa7eff071b249f5e315a5",
"assets/fonts/Sen/Sen-Regular.ttf": "32c160ed42f66e2434bba3af9c5fb375",
"assets/fonts/Sen/Sen-Bold.ttf": "66f22ad6aacdc3564847bf2e1f5bcd3d",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/assets/icon.png": "49a375aedc0c85c14b054c7706286dac",
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
"assets/assets/splash.png": "eb2b92b2352061076c973e3d52988e95",
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
"assets/assets/icons/clock.webp": "13d0f293dad803278e88d32f6fae8e6e",
"assets/assets/translations/en.json": "e864157593deaf3b5c77c40ab57ca3fc",
"assets/assets/translations/hr.json": "ccaf9716561c742bb31cd621dce10144",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
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
