// Bump SW_VERSION only when this file's own caching logic changes — it is
// not tied to itinerary content, which stays fresh via the network-first
// fetch strategy below regardless of this version.
const SW_VERSION = 'v1';
const CACHE_NAME = `trip-${SW_VERSION}`;

const APP_SHELL = ['./', 'index.html', 'manifest.json', 'icon.svg'];

self.addEventListener('install', (event) => {
  self.skipWaiting();
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(APP_SHELL).catch(() => {}))
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((names) => Promise.all(names.filter((n) => n !== CACHE_NAME).map((n) => caches.delete(n))))
      .then(() => self.clients.claim())
  );
});

// Network-first: always prefer the live version when online (this is a
// site that gets edited and republished), falling back to the last cached
// copy when offline.
self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;

  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return; // leave fonts/Leaflet/CDN tiles to the browser

  event.respondWith(
    fetch(req)
      .then((res) => {
        const copy = res.clone();
        caches.open(CACHE_NAME).then((cache) => cache.put(req, copy));
        return res;
      })
      .catch(() => caches.match(req))
  );
});
