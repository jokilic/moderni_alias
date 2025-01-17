// Returns whether the `js-string` built-in is supported.
function detectJsStringBuiltins() {
  let bytes = [
    0,   97,  115, 109, 1,   0,   0,  0,   1,   4,   1,   96,  0,
    0,   2,   23,  1,   14,  119, 97, 115, 109, 58,  106, 115, 45,
    115, 116, 114, 105, 110, 103, 4,  99,  97,  115, 116, 0,   0
  ];
  return WebAssembly.validate(
    new Uint8Array(bytes), {builtins: ['js-string']});
}

// Compiles a dart2wasm-generated main module from `source` which can then
// instantiatable via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = detectJsStringBuiltins()
      ? {builtins: ['js-string']} : {};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm modules from `bytes` which is then
// instantiatable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = detectJsStringBuiltins()
      ? {builtins: ['js-string']} : {};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export async function instantiate(modulePromise, importObjectPromise) {
  var moduleOrCompiledApp = await modulePromise;
  if (!(moduleOrCompiledApp instanceof CompiledApp)) {
    moduleOrCompiledApp = new CompiledApp(moduleOrCompiledApp);
  }
  const instantiatedApp = await moduleOrCompiledApp.instantiate(await importObjectPromise);
  return instantiatedApp.instantiatedModule;
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredWasm` is a JS function that takes a module name matching a
  //   wasm file produced by the dart2wasm compiler and returns the bytes to
  //   load the module. These bytes can be in either a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`.
  async instantiate(additionalImports, {loadDeferredWasm} = {}) {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + js;
    }

    // Converts a Dart List to a JS array. Any Dart objects will be converted, but
    // this will be cheap for JSValues.
    function arrayFromDartList(constructor, list) {
      const exports = dartInstance.exports;
      const read = exports.$listRead;
      const length = exports.$listLength(list);
      const array = new constructor(length);
      for (let i = 0; i < length; i++) {
        array[i] = read(list, i);
      }
      return array;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {

      _1: (x0,x1,x2) => x0.set(x1,x2),
      _2: (x0,x1,x2) => x0.set(x1,x2),
      _6: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._6(f,arguments.length,x0) }),
      _7: x0 => new window.FinalizationRegistry(x0),
      _8: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _9: (x0,x1) => x0.unregister(x1),
      _10: (x0,x1,x2) => x0.slice(x1,x2),
      _11: (x0,x1) => x0.decode(x1),
      _12: (x0,x1) => x0.segment(x1),
      _13: () => new TextDecoder(),
      _14: x0 => x0.buffer,
      _15: x0 => x0.wasmMemory,
      _16: () => globalThis.window._flutter_skwasmInstance,
      _17: x0 => x0.rasterStartMilliseconds,
      _18: x0 => x0.rasterEndMilliseconds,
      _19: x0 => x0.imageBitmaps,
      _192: x0 => x0.select(),
      _193: (x0,x1) => x0.append(x1),
      _194: x0 => x0.remove(),
      _197: x0 => x0.unlock(),
      _202: x0 => x0.getReader(),
      _211: x0 => new MutationObserver(x0),
      _222: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _223: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _226: x0 => new ResizeObserver(x0),
      _229: (x0,x1) => new Intl.Segmenter(x0,x1),
      _230: x0 => x0.next(),
      _231: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      _308: x0 => x0.close(),
      _309: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      _310: x0 => new window.ImageDecoder(x0),
      _311: x0 => x0.close(),
      _312: x0 => ({frameIndex: x0}),
      _313: (x0,x1) => x0.decode(x1),
      _316: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._316(f,arguments.length,x0) }),
      _317: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._317(f,arguments.length,x0) }),
      _318: (x0,x1) => ({addView: x0,removeView: x1}),
      _319: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._319(f,arguments.length,x0) }),
      _320: f => finalizeWrapper(f, function() { return dartInstance.exports._320(f,arguments.length) }),
      _321: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      _322: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._322(f,arguments.length,x0) }),
      _323: x0 => ({runApp: x0}),
      _324: x0 => new Uint8Array(x0),
      _326: x0 => x0.preventDefault(),
      _327: x0 => x0.stopPropagation(),
      _328: (x0,x1) => x0.addListener(x1),
      _329: (x0,x1) => x0.removeListener(x1),
      _330: (x0,x1) => x0.prepend(x1),
      _331: x0 => x0.remove(),
      _332: x0 => x0.disconnect(),
      _333: (x0,x1) => x0.addListener(x1),
      _334: (x0,x1) => x0.removeListener(x1),
      _336: (x0,x1) => x0.append(x1),
      _337: x0 => x0.remove(),
      _338: x0 => x0.stopPropagation(),
      _342: x0 => x0.preventDefault(),
      _343: (x0,x1) => x0.append(x1),
      _344: x0 => x0.remove(),
      _345: x0 => x0.preventDefault(),
      _350: (x0,x1) => x0.removeChild(x1),
      _351: (x0,x1) => x0.appendChild(x1),
      _352: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _353: (x0,x1) => x0.appendChild(x1),
      _354: (x0,x1) => x0.transferFromImageBitmap(x1),
      _355: (x0,x1) => x0.appendChild(x1),
      _356: (x0,x1) => x0.append(x1),
      _357: (x0,x1) => x0.append(x1),
      _358: (x0,x1) => x0.append(x1),
      _359: x0 => x0.remove(),
      _360: x0 => x0.remove(),
      _361: x0 => x0.remove(),
      _362: (x0,x1) => x0.appendChild(x1),
      _363: (x0,x1) => x0.appendChild(x1),
      _364: x0 => x0.remove(),
      _365: (x0,x1) => x0.append(x1),
      _366: (x0,x1) => x0.append(x1),
      _367: x0 => x0.remove(),
      _368: (x0,x1) => x0.append(x1),
      _369: (x0,x1) => x0.append(x1),
      _370: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _371: (x0,x1) => x0.append(x1),
      _372: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _373: x0 => x0.remove(),
      _374: x0 => x0.remove(),
      _375: (x0,x1) => x0.append(x1),
      _376: x0 => x0.remove(),
      _377: (x0,x1) => x0.append(x1),
      _378: x0 => x0.remove(),
      _379: x0 => x0.remove(),
      _380: x0 => x0.getBoundingClientRect(),
      _381: x0 => x0.remove(),
      _394: (x0,x1) => x0.append(x1),
      _395: x0 => x0.remove(),
      _396: (x0,x1) => x0.append(x1),
      _397: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _398: x0 => x0.preventDefault(),
      _399: x0 => x0.preventDefault(),
      _400: x0 => x0.preventDefault(),
      _401: x0 => x0.preventDefault(),
      _402: x0 => x0.remove(),
      _403: (x0,x1) => x0.observe(x1),
      _404: x0 => x0.disconnect(),
      _405: (x0,x1) => x0.appendChild(x1),
      _406: (x0,x1) => x0.appendChild(x1),
      _407: (x0,x1) => x0.appendChild(x1),
      _408: (x0,x1) => x0.append(x1),
      _409: x0 => x0.remove(),
      _410: (x0,x1) => x0.append(x1),
      _411: (x0,x1) => x0.append(x1),
      _412: (x0,x1) => x0.appendChild(x1),
      _413: (x0,x1) => x0.append(x1),
      _414: x0 => x0.remove(),
      _415: (x0,x1) => x0.append(x1),
      _419: (x0,x1) => x0.appendChild(x1),
      _420: x0 => x0.remove(),
      _976: () => globalThis.window.flutterConfiguration,
      _977: x0 => x0.assetBase,
      _982: x0 => x0.debugShowSemanticsNodes,
      _983: x0 => x0.hostElement,
      _984: x0 => x0.multiViewEnabled,
      _985: x0 => x0.nonce,
      _987: x0 => x0.fontFallbackBaseUrl,
      _988: x0 => x0.useColorEmoji,
      _992: x0 => x0.console,
      _993: x0 => x0.devicePixelRatio,
      _994: x0 => x0.document,
      _995: x0 => x0.history,
      _996: x0 => x0.innerHeight,
      _997: x0 => x0.innerWidth,
      _998: x0 => x0.location,
      _999: x0 => x0.navigator,
      _1000: x0 => x0.visualViewport,
      _1001: x0 => x0.performance,
      _1004: (x0,x1) => x0.dispatchEvent(x1),
      _1005: (x0,x1) => x0.matchMedia(x1),
      _1007: (x0,x1) => x0.getComputedStyle(x1),
      _1008: x0 => x0.screen,
      _1009: (x0,x1) => x0.requestAnimationFrame(x1),
      _1010: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1010(f,arguments.length,x0) }),
      _1014: (x0,x1) => x0.warn(x1),
      _1016: (x0,x1) => x0.debug(x1),
      _1017: () => globalThis.window,
      _1018: () => globalThis.Intl,
      _1019: () => globalThis.Symbol,
      _1022: x0 => x0.clipboard,
      _1023: x0 => x0.maxTouchPoints,
      _1024: x0 => x0.vendor,
      _1025: x0 => x0.language,
      _1026: x0 => x0.platform,
      _1027: x0 => x0.userAgent,
      _1028: x0 => x0.languages,
      _1029: x0 => x0.documentElement,
      _1030: (x0,x1) => x0.querySelector(x1),
      _1034: (x0,x1) => x0.createElement(x1),
      _1035: (x0,x1) => x0.execCommand(x1),
      _1039: (x0,x1) => x0.createTextNode(x1),
      _1040: (x0,x1) => x0.createEvent(x1),
      _1044: x0 => x0.head,
      _1045: x0 => x0.body,
      _1046: (x0,x1) => x0.title = x1,
      _1049: x0 => x0.activeElement,
      _1052: x0 => x0.visibilityState,
      _1053: x0 => x0.hasFocus(),
      _1054: () => globalThis.document,
      _1055: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1057: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1060: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1060(f,arguments.length,x0) }),
      _1061: x0 => x0.target,
      _1063: x0 => x0.timeStamp,
      _1064: x0 => x0.type,
      _1066: x0 => x0.preventDefault(),
      _1068: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      _1075: x0 => x0.firstChild,
      _1080: x0 => x0.parentElement,
      _1082: x0 => x0.parentNode,
      _1085: (x0,x1) => x0.removeChild(x1),
      _1086: (x0,x1) => x0.removeChild(x1),
      _1087: x0 => x0.isConnected,
      _1088: (x0,x1) => x0.textContent = x1,
      _1090: (x0,x1) => x0.contains(x1),
      _1095: x0 => x0.firstElementChild,
      _1097: x0 => x0.nextElementSibling,
      _1098: x0 => x0.clientHeight,
      _1099: x0 => x0.clientWidth,
      _1100: x0 => x0.offsetHeight,
      _1101: x0 => x0.offsetWidth,
      _1102: x0 => x0.id,
      _1103: (x0,x1) => x0.id = x1,
      _1106: (x0,x1) => x0.spellcheck = x1,
      _1107: x0 => x0.tagName,
      _1108: x0 => x0.style,
      _1109: (x0,x1) => x0.append(x1),
      _1110: (x0,x1) => x0.getAttribute(x1),
      _1111: x0 => x0.getBoundingClientRect(),
      _1116: (x0,x1) => x0.closest(x1),
      _1119: (x0,x1) => x0.querySelectorAll(x1),
      _1121: x0 => x0.remove(),
      _1122: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1123: (x0,x1) => x0.removeAttribute(x1),
      _1124: (x0,x1) => x0.tabIndex = x1,
      _1126: (x0,x1) => x0.focus(x1),
      _1127: x0 => x0.scrollTop,
      _1128: (x0,x1) => x0.scrollTop = x1,
      _1129: x0 => x0.scrollLeft,
      _1130: (x0,x1) => x0.scrollLeft = x1,
      _1131: x0 => x0.classList,
      _1132: (x0,x1) => x0.className = x1,
      _1139: (x0,x1) => x0.getElementsByClassName(x1),
      _1141: x0 => x0.click(),
      _1143: (x0,x1) => x0.hasAttribute(x1),
      _1146: (x0,x1) => x0.attachShadow(x1),
      _1151: (x0,x1) => x0.getPropertyValue(x1),
      _1153: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      _1155: (x0,x1) => x0.removeProperty(x1),
      _1157: x0 => x0.offsetLeft,
      _1158: x0 => x0.offsetTop,
      _1159: x0 => x0.offsetParent,
      _1161: (x0,x1) => x0.name = x1,
      _1162: x0 => x0.content,
      _1163: (x0,x1) => x0.content = x1,
      _1177: (x0,x1) => x0.nonce = x1,
      _1183: x0 => x0.now(),
      _1185: (x0,x1) => x0.width = x1,
      _1187: (x0,x1) => x0.height = x1,
      _1191: (x0,x1) => x0.getContext(x1),
      _1267: (x0,x1) => x0.fetch(x1),
      _1268: x0 => x0.status,
      _1270: x0 => x0.body,
      _1271: x0 => x0.arrayBuffer(),
      _1277: x0 => x0.read(),
      _1278: x0 => x0.value,
      _1279: x0 => x0.done,
      _1281: x0 => x0.name,
      _1282: x0 => x0.x,
      _1283: x0 => x0.y,
      _1286: x0 => x0.top,
      _1287: x0 => x0.right,
      _1288: x0 => x0.bottom,
      _1289: x0 => x0.left,
      _1299: x0 => x0.height,
      _1300: x0 => x0.width,
      _1301: (x0,x1) => x0.value = x1,
      _1303: (x0,x1) => x0.placeholder = x1,
      _1304: (x0,x1) => x0.name = x1,
      _1305: x0 => x0.selectionDirection,
      _1306: x0 => x0.selectionStart,
      _1307: x0 => x0.selectionEnd,
      _1310: x0 => x0.value,
      _1312: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1315: x0 => x0.readText(),
      _1316: (x0,x1) => x0.writeText(x1),
      _1317: x0 => x0.altKey,
      _1318: x0 => x0.code,
      _1319: x0 => x0.ctrlKey,
      _1320: x0 => x0.key,
      _1321: x0 => x0.keyCode,
      _1322: x0 => x0.location,
      _1323: x0 => x0.metaKey,
      _1324: x0 => x0.repeat,
      _1325: x0 => x0.shiftKey,
      _1326: x0 => x0.isComposing,
      _1327: (x0,x1) => x0.getModifierState(x1),
      _1329: x0 => x0.state,
      _1330: (x0,x1) => x0.go(x1),
      _1333: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      _1334: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _1335: x0 => x0.pathname,
      _1336: x0 => x0.search,
      _1337: x0 => x0.hash,
      _1341: x0 => x0.state,
      _1347: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1347(f,arguments.length,x0,x1) }),
      _1350: (x0,x1,x2) => x0.observe(x1,x2),
      _1353: x0 => x0.attributeName,
      _1354: x0 => x0.type,
      _1355: x0 => x0.matches,
      _1358: x0 => x0.matches,
      _1360: x0 => x0.relatedTarget,
      _1361: x0 => x0.clientX,
      _1362: x0 => x0.clientY,
      _1363: x0 => x0.offsetX,
      _1364: x0 => x0.offsetY,
      _1367: x0 => x0.button,
      _1368: x0 => x0.buttons,
      _1369: x0 => x0.ctrlKey,
      _1370: (x0,x1) => x0.getModifierState(x1),
      _1373: x0 => x0.pointerId,
      _1374: x0 => x0.pointerType,
      _1375: x0 => x0.pressure,
      _1376: x0 => x0.tiltX,
      _1377: x0 => x0.tiltY,
      _1378: x0 => x0.getCoalescedEvents(),
      _1380: x0 => x0.deltaX,
      _1381: x0 => x0.deltaY,
      _1382: x0 => x0.wheelDeltaX,
      _1383: x0 => x0.wheelDeltaY,
      _1384: x0 => x0.deltaMode,
      _1390: x0 => x0.changedTouches,
      _1392: x0 => x0.clientX,
      _1393: x0 => x0.clientY,
      _1395: x0 => x0.data,
      _1398: (x0,x1) => x0.disabled = x1,
      _1399: (x0,x1) => x0.type = x1,
      _1400: (x0,x1) => x0.max = x1,
      _1401: (x0,x1) => x0.min = x1,
      _1402: (x0,x1) => x0.value = x1,
      _1403: x0 => x0.value,
      _1404: x0 => x0.disabled,
      _1405: (x0,x1) => x0.disabled = x1,
      _1406: (x0,x1) => x0.placeholder = x1,
      _1407: (x0,x1) => x0.name = x1,
      _1408: (x0,x1) => x0.autocomplete = x1,
      _1409: x0 => x0.selectionDirection,
      _1410: x0 => x0.selectionStart,
      _1411: x0 => x0.selectionEnd,
      _1415: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1420: (x0,x1) => x0.add(x1),
      _1423: (x0,x1) => x0.noValidate = x1,
      _1424: (x0,x1) => x0.method = x1,
      _1425: (x0,x1) => x0.action = x1,
      _1450: x0 => x0.orientation,
      _1451: x0 => x0.width,
      _1452: x0 => x0.height,
      _1453: (x0,x1) => x0.lock(x1),
      _1471: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1471(f,arguments.length,x0,x1) }),
      _1482: x0 => x0.length,
      _1483: (x0,x1) => x0.item(x1),
      _1484: x0 => x0.length,
      _1485: (x0,x1) => x0.item(x1),
      _1486: x0 => x0.iterator,
      _1487: x0 => x0.Segmenter,
      _1488: x0 => x0.v8BreakIterator,
      _1492: x0 => x0.done,
      _1493: x0 => x0.value,
      _1494: x0 => x0.index,
      _1498: (x0,x1) => x0.adoptText(x1),
      _1499: x0 => x0.first(),
      _1500: x0 => x0.next(),
      _1501: x0 => x0.current(),
      _1512: x0 => x0.hostElement,
      _1513: x0 => x0.viewConstraints,
      _1515: x0 => x0.maxHeight,
      _1516: x0 => x0.maxWidth,
      _1517: x0 => x0.minHeight,
      _1518: x0 => x0.minWidth,
      _1519: x0 => x0.loader,
      _1520: () => globalThis._flutter,
      _1521: (x0,x1) => x0.didCreateEngineInitializer(x1),
      _1522: (x0,x1,x2) => x0.call(x1,x2),
      _1523: () => globalThis.Promise,
      _1524: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1524(f,arguments.length,x0,x1) }),
      _1527: x0 => x0.length,
      _1530: x0 => x0.tracks,
      _1534: x0 => x0.image,
      _1539: x0 => x0.codedWidth,
      _1540: x0 => x0.codedHeight,
      _1543: x0 => x0.duration,
      _1547: x0 => x0.ready,
      _1548: x0 => x0.selectedTrack,
      _1549: x0 => x0.repetitionCount,
      _1550: x0 => x0.frameCount,
      _1595: (x0,x1,x2) => x0.call(x1,x2),
      _1596: (x0,x1,x2,x3,x4,x5) => x0.call(x1,x2,x3,x4,x5),
      _1597: (x0,x1,x2,x3) => x0.call(x1,x2,x3),
      _1598: (x0,x1,x2,x3,x4) => x0.call(x1,x2,x3,x4),
      _1599: x0 => x0.call(),
      _1600: (x0,x1) => x0.append(x1),
      _1601: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1601(f,arguments.length,x0) }),
      _1602: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1602(f,arguments.length,x0) }),
      _1604: (x0,x1,x2) => x0.call(x1,x2),
      _1605: (x0,x1,x2,x3) => x0.call(x1,x2,x3),
      _1606: (x0,x1,x2,x3,x4) => x0.call(x1,x2,x3,x4),
      _1607: (x0,x1,x2,x3,x4,x5) => x0.call(x1,x2,x3,x4,x5),
      _1610: x0 => x0.call(),
      _1622: x0 => x0.play(),
      _1623: x0 => x0.pause(),
      _1626: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _1631: (x0,x1) => x0.removeAttribute(x1),
      _1632: x0 => x0.load(),
      _1633: (x0,x1) => x0.start(x1),
      _1634: (x0,x1) => x0.end(x1),
      _1636: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1637: (x0,x1,x2,x3) => x0.removeEventListener(x1,x2,x3),
      _1638: (x0,x1) => x0.createElement(x1),
      _1652: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1653: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1653(f,arguments.length,x0) }),
      _1654: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1654(f,arguments.length,x0) }),
      _1655: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1655(f,arguments.length,x0) }),
      _1656: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1656(f,arguments.length,x0) }),
      _1657: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1657(f,arguments.length,x0) }),
      _1658: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1658(f,arguments.length,x0) }),
      _1659: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1659(f,arguments.length,x0) }),
      _1660: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1660(f,arguments.length,x0) }),
      _1661: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1661(f,arguments.length,x0) }),
      _1662: x0 => x0.load(),
      _1663: (x0,x1) => x0.removeAttribute(x1),
      _1664: x0 => x0.load(),
      _1665: (x0,x1) => x0.end(x1),
      _1667: x0 => x0.play(),
      _1668: x0 => x0.pause(),
      _1675: x0 => globalThis.Wakelock.toggle(x0),
      _1677: (x0,x1) => x0.getItem(x1),
      _1683: () => globalThis.removeSplashFromWeb(),
      _1684: (x0,x1,x2,x3,x4,x5,x6) => x0.call(x1,x2,x3,x4,x5,x6),
      _1695: x0 => new Array(x0),
      _1697: x0 => x0.length,
      _1699: (x0,x1) => x0[x1],
      _1700: (x0,x1,x2) => x0[x1] = x2,
      _1703: (x0,x1,x2) => new DataView(x0,x1,x2),
      _1705: x0 => new Int8Array(x0),
      _1706: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      _1707: x0 => new Uint8Array(x0),
      _1713: x0 => new Uint16Array(x0),
      _1715: x0 => new Int32Array(x0),
      _1717: x0 => new Uint32Array(x0),
      _1719: x0 => new Float32Array(x0),
      _1721: x0 => new Float64Array(x0),
      _1722: (o, t) => typeof o === t,
      _1723: (o, c) => o instanceof c,
      _1726: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1726(f,arguments.length,x0) }),
      _1727: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1727(f,arguments.length,x0) }),
      _1752: (decoder, codeUnits) => decoder.decode(codeUnits),
      _1753: () => new TextDecoder("utf-8", {fatal: true}),
      _1754: () => new TextDecoder("utf-8", {fatal: false}),
      _1755: x0 => new WeakRef(x0),
      _1756: x0 => x0.deref(),
      _1757: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1757(f,arguments.length,x0) }),
      _1758: x0 => new FinalizationRegistry(x0),
      _1759: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _1760: (x0,x1,x2) => x0.register(x1,x2),
      _1761: (x0,x1) => x0.unregister(x1),
      _1762: Date.now,
      _1764: s => new Date(s * 1000).getTimezoneOffset() * 60,
      _1765: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      _1766: () => {
        let stackString = new Error().stack.toString();
        let frames = stackString.split('\n');
        let drop = 2;
        if (frames[0] === 'Error') {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      _1767: () => typeof dartUseDateNowForTicks !== "undefined",
      _1768: () => 1000 * performance.now(),
      _1769: () => Date.now(),
      _1770: () => {
        // On browsers return `globalThis.location.href`
        if (globalThis.location != null) {
          return globalThis.location.href;
        }
        return null;
      },
      _1771: () => {
        return typeof process != "undefined" &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
      _1772: () => new WeakMap(),
      _1773: (map, o) => map.get(o),
      _1774: (map, o, v) => map.set(o, v),
      _1775: () => globalThis.WeakRef,
      _1779: () => globalThis.FinalizationRegistry,
      _1785: s => JSON.stringify(s),
      _1786: s => printToConsole(s),
      _1787: a => a.join(''),
      _1788: (o, a, b) => o.replace(a, b),
      _1789: (o, p, r) => o.split(p).join(r),
      _1790: (s, t) => s.split(t),
      _1791: s => s.toLowerCase(),
      _1792: s => s.toUpperCase(),
      _1793: s => s.trim(),
      _1794: s => s.trimLeft(),
      _1795: s => s.trimRight(),
      _1797: (s, p, i) => s.indexOf(p, i),
      _1798: (s, p, i) => s.lastIndexOf(p, i),
      _1799: (s) => s.replace(/\$/g, "$$$$"),
      _1800: Object.is,
      _1801: s => s.toUpperCase(),
      _1802: s => s.toLowerCase(),
      _1803: (a, i) => a.push(i),
      _1807: a => a.pop(),
      _1808: (a, i) => a.splice(i, 1),
      _1810: (a, s) => a.join(s),
      _1811: (a, s, e) => a.slice(s, e),
      _1813: (a, b) => a == b ? 0 : (a > b ? 1 : -1),
      _1814: a => a.length,
      _1815: (a, l) => a.length = l,
      _1816: (a, i) => a[i],
      _1817: (a, i, v) => a[i] = v,
      _1819: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      _1820: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      _1821: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      _1822: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      _1823: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      _1824: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      _1825: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      _1826: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      _1828: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      _1829: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      _1830: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      _1831: (t, s) => t.set(s),
      _1832: l => new DataView(new ArrayBuffer(l)),
      _1833: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      _1835: o => o.buffer,
      _1836: o => o.byteOffset,
      _1837: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      _1838: (b, o) => new DataView(b, o),
      _1839: (b, o, l) => new DataView(b, o, l),
      _1840: Function.prototype.call.bind(DataView.prototype.getUint8),
      _1841: Function.prototype.call.bind(DataView.prototype.setUint8),
      _1842: Function.prototype.call.bind(DataView.prototype.getInt8),
      _1843: Function.prototype.call.bind(DataView.prototype.setInt8),
      _1844: Function.prototype.call.bind(DataView.prototype.getUint16),
      _1845: Function.prototype.call.bind(DataView.prototype.setUint16),
      _1846: Function.prototype.call.bind(DataView.prototype.getInt16),
      _1847: Function.prototype.call.bind(DataView.prototype.setInt16),
      _1848: Function.prototype.call.bind(DataView.prototype.getUint32),
      _1849: Function.prototype.call.bind(DataView.prototype.setUint32),
      _1850: Function.prototype.call.bind(DataView.prototype.getInt32),
      _1851: Function.prototype.call.bind(DataView.prototype.setInt32),
      _1854: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      _1855: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      _1856: Function.prototype.call.bind(DataView.prototype.getFloat32),
      _1857: Function.prototype.call.bind(DataView.prototype.setFloat32),
      _1858: Function.prototype.call.bind(DataView.prototype.getFloat64),
      _1859: Function.prototype.call.bind(DataView.prototype.setFloat64),
      _1872: (o, t) => o instanceof t,
      _1874: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1874(f,arguments.length,x0) }),
      _1875: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1875(f,arguments.length,x0) }),
      _1876: o => Object.keys(o),
      _1877: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      _1878: (handle) => clearTimeout(handle),
      _1879: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      _1880: (handle) => clearInterval(handle),
      _1881: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      _1882: () => Date.now(),
      _1883: (x0,x1,x2) => x0.transaction(x1,x2),
      _1884: (x0,x1) => x0.objectStore(x1),
      _1885: (x0,x1) => x0.getAllKeys(x1),
      _1886: (x0,x1) => x0.getAll(x1),
      _1888: (x0,x1) => x0.delete(x1),
      _1889: (x0,x1,x2) => x0.put(x1,x2),
      _1891: x0 => x0.close(),
      _1893: (x0,x1,x2) => x0.open(x1,x2),
      _1898: (x0,x1) => x0.contains(x1),
      _1899: (x0,x1) => x0.createObjectStore(x1),
      _1900: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1900(f,arguments.length,x0) }),
      _1901: (x0,x1) => x0.contains(x1),
      _1902: (x0,x1) => x0.contains(x1),
      _1903: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1903(f,arguments.length,x0) }),
      _1934: () => new XMLHttpRequest(),
      _1935: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1936: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1937: (x0,x1) => x0.send(x1),
      _1938: x0 => x0.abort(),
      _1939: x0 => x0.getAllResponseHeaders(),
      _1940: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1940(f,arguments.length,x0) }),
      _1941: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1941(f,arguments.length,x0) }),
      _1942: x0 => x0.openCursor(),
      _1943: x0 => x0.continue(),
      _1944: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1944(f,arguments.length,x0) }),
      _1945: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1945(f,arguments.length,x0) }),
      _1952: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1952(f,arguments.length,x0) }),
      _1953: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1953(f,arguments.length,x0) }),
      _1962: (x0,x1) => x0.appendChild(x1),
      _1963: (x0,x1) => x0.item(x1),
      _1964: (x0,x1) => x0.key(x1),
      _1980: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      _1981: (x0,x1) => x0.exec(x1),
      _1982: (x0,x1) => x0.test(x1),
      _1983: (x0,x1) => x0.exec(x1),
      _1984: (x0,x1) => x0.exec(x1),
      _1985: x0 => x0.pop(),
      _1987: o => o === undefined,
      _2006: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      _2008: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      _2009: o => o instanceof RegExp,
      _2010: (l, r) => l === r,
      _2011: o => o,
      _2012: o => o,
      _2013: o => o,
      _2014: b => !!b,
      _2015: o => o.length,
      _2018: (o, i) => o[i],
      _2019: f => f.dartFunction,
      _2020: l => arrayFromDartList(Int8Array, l),
      _2021: l => arrayFromDartList(Uint8Array, l),
      _2022: l => arrayFromDartList(Uint8ClampedArray, l),
      _2023: l => arrayFromDartList(Int16Array, l),
      _2024: l => arrayFromDartList(Uint16Array, l),
      _2025: l => arrayFromDartList(Int32Array, l),
      _2026: l => arrayFromDartList(Uint32Array, l),
      _2027: l => arrayFromDartList(Float32Array, l),
      _2028: l => arrayFromDartList(Float64Array, l),
      _2029: x0 => new ArrayBuffer(x0),
      _2030: (data, length) => {
        const getValue = dartInstance.exports.$byteDataGetUint8;
        const view = new DataView(new ArrayBuffer(length));
        for (let i = 0; i < length; i++) {
          view.setUint8(i, getValue(data, i));
        }
        return view;
      },
      _2031: l => arrayFromDartList(Array, l),
      _2032: (s, length) => {
        if (length == 0) return '';
      
        const read = dartInstance.exports.$stringRead1;
        let result = '';
        let index = 0;
        const chunkLength = Math.min(length - index, 500);
        let array = new Array(chunkLength);
        while (index < length) {
          const newChunkLength = Math.min(length - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(s, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
      _2033: (s, length) => {
        if (length == 0) return '';
      
        const read = dartInstance.exports.$stringRead2;
        let result = '';
        let index = 0;
        const chunkLength = Math.min(length - index, 500);
        let array = new Array(chunkLength);
        while (index < length) {
          const newChunkLength = Math.min(length - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(s, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
      _2034: (s) => {
        let length = s.length;
        let range = 0;
        for (let i = 0; i < length; i++) {
          range |= s.codePointAt(i);
        }
        const exports = dartInstance.exports;
        if (range < 256) {
          if (length <= 10) {
            if (length == 1) {
              return exports.$stringAllocate1_1(s.codePointAt(0));
            }
            if (length == 2) {
              return exports.$stringAllocate1_2(s.codePointAt(0), s.codePointAt(1));
            }
            if (length == 3) {
              return exports.$stringAllocate1_3(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2));
            }
            if (length == 4) {
              return exports.$stringAllocate1_4(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3));
            }
            if (length == 5) {
              return exports.$stringAllocate1_5(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4));
            }
            if (length == 6) {
              return exports.$stringAllocate1_6(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5));
            }
            if (length == 7) {
              return exports.$stringAllocate1_7(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6));
            }
            if (length == 8) {
              return exports.$stringAllocate1_8(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6), s.codePointAt(7));
            }
            if (length == 9) {
              return exports.$stringAllocate1_9(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6), s.codePointAt(7), s.codePointAt(8));
            }
            if (length == 10) {
              return exports.$stringAllocate1_10(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6), s.codePointAt(7), s.codePointAt(8), s.codePointAt(9));
            }
          }
          const dartString = exports.$stringAllocate1(length);
          const write = exports.$stringWrite1;
          for (let i = 0; i < length; i++) {
            write(dartString, i, s.codePointAt(i));
          }
          return dartString;
        } else {
          const dartString = exports.$stringAllocate2(length);
          const write = exports.$stringWrite2;
          for (let i = 0; i < length; i++) {
            write(dartString, i, s.charCodeAt(i));
          }
          return dartString;
        }
      },
      _2035: () => ({}),
      _2036: () => [],
      _2037: l => new Array(l),
      _2038: () => globalThis,
      _2039: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      _2040: (o, p) => p in o,
      _2041: (o, p) => o[p],
      _2042: (o, p, v) => o[p] = v,
      _2043: (o, m, a) => o[m].apply(o, a),
      _2045: o => String(o),
      _2046: (p, s, f) => p.then(s, f),
      _2047: o => {
        if (o === undefined) return 1;
        var type = typeof o;
        if (type === 'boolean') return 2;
        if (type === 'number') return 3;
        if (type === 'string') return 4;
        if (o instanceof Array) return 5;
        if (ArrayBuffer.isView(o)) {
          if (o instanceof Int8Array) return 6;
          if (o instanceof Uint8Array) return 7;
          if (o instanceof Uint8ClampedArray) return 8;
          if (o instanceof Int16Array) return 9;
          if (o instanceof Uint16Array) return 10;
          if (o instanceof Int32Array) return 11;
          if (o instanceof Uint32Array) return 12;
          if (o instanceof Float32Array) return 13;
          if (o instanceof Float64Array) return 14;
          if (o instanceof DataView) return 15;
        }
        if (o instanceof ArrayBuffer) return 16;
        return 17;
      },
      _2048: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2049: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2050: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI16ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2051: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI16ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2052: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2053: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2054: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2055: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2056: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _2057: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _2058: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      _2061: x0 => x0.index,
      _2065: (x0,x1) => x0.exec(x1),
      _2067: x0 => x0.flags,
      _2068: x0 => x0.multiline,
      _2069: x0 => x0.ignoreCase,
      _2070: x0 => x0.unicode,
      _2071: x0 => x0.dotAll,
      _2072: (x0,x1) => x0.lastIndex = x1,
      _2073: (o, p) => p in o,
      _2074: (o, p) => o[p],
      _2077: v => v.toString(),
      _2078: (d, digits) => d.toFixed(digits),
      _2082: x0 => x0.random(),
      _2083: x0 => x0.random(),
      _2084: (x0,x1) => x0.getRandomValues(x1),
      _2085: () => globalThis.crypto,
      _2087: () => globalThis.Math,
      _2182: (x0,x1) => x0.withCredentials = x1,
      _2184: x0 => x0.responseURL,
      _2185: x0 => x0.status,
      _2186: x0 => x0.statusText,
      _2188: (x0,x1) => x0.responseType = x1,
      _2189: x0 => x0.response,
      _2269: x0 => x0.style,
      _2842: x0 => x0.videoWidth,
      _2843: x0 => x0.videoHeight,
      _2847: (x0,x1) => x0.playsInline = x1,
      _2876: x0 => x0.error,
      _2877: x0 => x0.src,
      _2878: (x0,x1) => x0.src = x1,
      _2886: (x0,x1) => x0.preload = x1,
      _2887: x0 => x0.buffered,
      _2890: x0 => x0.currentTime,
      _2891: (x0,x1) => x0.currentTime = x1,
      _2892: x0 => x0.duration,
      _2897: (x0,x1) => x0.playbackRate = x1,
      _2904: (x0,x1) => x0.autoplay = x1,
      _2906: (x0,x1) => x0.loop = x1,
      _2908: (x0,x1) => x0.controls = x1,
      _2910: (x0,x1) => x0.volume = x1,
      _2912: (x0,x1) => x0.muted = x1,
      _2927: x0 => x0.code,
      _2928: x0 => x0.message,
      _3004: x0 => x0.length,
      _3513: x0 => x0.src,
      _3514: (x0,x1) => x0.src = x1,
      _3516: (x0,x1) => x0.type = x1,
      _3520: (x0,x1) => x0.async = x1,
      _3522: (x0,x1) => x0.defer = x1,
      _3534: (x0,x1) => x0.charset = x1,
      _4001: () => globalThis.window,
      _4043: x0 => x0.self,
      _4044: x0 => x0.document,
      _4066: x0 => x0.navigator,
      _4323: x0 => x0.indexedDB,
      _4330: x0 => x0.localStorage,
      _4457: x0 => x0.userAgent,
      _4677: x0 => x0.length,
      _6662: x0 => x0.target,
      _6717: x0 => x0.length,
      _6766: x0 => x0.baseURI,
      _6783: () => globalThis.document,
      _6876: x0 => x0.body,
      _6878: x0 => x0.head,
      _7227: (x0,x1) => x0.id = x1,
      _7254: x0 => x0.children,
      _10812: x0 => x0.result,
      _10813: x0 => x0.error,
      _10818: (x0,x1) => x0.onsuccess = x1,
      _10820: (x0,x1) => x0.onerror = x1,
      _10824: (x0,x1) => x0.onupgradeneeded = x1,
      _10845: x0 => x0.version,
      _10846: x0 => x0.objectStoreNames,
      _10918: x0 => x0.key,
      _10921: x0 => x0.value,
      _11492: (x0,x1) => x0.border = x1,
      _11934: (x0,x1) => x0.height = x1,
      _12624: (x0,x1) => x0.width = x1,
      _13001: x0 => x0.name,
      _13002: x0 => x0.message,

    };

    const baseImports = {
      dart2wasm: dart2wasm,


      Math: Math,
      Date: Date,
      Object: Object,
      Array: Array,
      Reflect: Reflect,
    };

    const jsStringPolyfill = {
      "charCodeAt": (s, i) => s.charCodeAt(i),
      "compare": (s1, s2) => {
        if (s1 < s2) return -1;
        if (s1 > s2) return 1;
        return 0;
      },
      "concat": (s1, s2) => s1 + s2,
      "equals": (s1, s2) => s1 === s2,
      "fromCharCode": (i) => String.fromCharCode(i),
      "length": (s) => s.length,
      "substring": (s, a, b) => s.substring(a, b),
    };

    const deferredLibraryHelper = {
      "loadModule": async (moduleName) => {
        if (!loadDeferredWasm) {
          throw "No implementation of loadDeferredWasm provided.";
        }
        const source = await Promise.resolve(loadDeferredWasm(moduleName));
        const module = await ((source instanceof Response)
            ? WebAssembly.compileStreaming(source, this.builtins)
            : WebAssembly.compile(source, this.builtins));
        return await WebAssembly.instantiate(module, {
          ...baseImports,
          ...additionalImports,
          "wasm:js-string": jsStringPolyfill,
          "module0": dartInstance.exports,
        });
      },
    };

    dartInstance = await WebAssembly.instantiate(this.module, {
      ...baseImports,
      ...additionalImports,
      "deferredLibraryHelper": deferredLibraryHelper,
      "wasm:js-string": jsStringPolyfill,
    });

    return new InstantiatedApp(this, dartInstance);
  }
}

class InstantiatedApp {
  constructor(compiledApp, instantiatedModule) {
    this.compiledApp = compiledApp;
    this.instantiatedModule = instantiatedModule;
  }

  // Call the main function with the given arguments.
  invokeMain(...args) {
    this.instantiatedModule.exports.$invokeMain(args);
  }
}

