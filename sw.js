// Merka POS — Service Worker
// Versión: actualizar este número fuerza la reinstalación del SW
const CACHE_VERSION = 'merka-v1';
const CACHE_NAME = `merka-pos-${CACHE_VERSION}`;

// Archivos a cachear para uso offline
const CACHE_ASSETS = [
  '/',
  '/index.html',
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png',
  'https://fonts.googleapis.com/css2?family=Sora:wght@400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;700&display=swap',
  'https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js',
  'https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js'
];

// ── INSTALL: cache assets ──
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(CACHE_ASSETS).catch(err => {
        console.warn('SW: Some assets failed to cache:', err);
      });
    })
  );
  self.skipWaiting();
});

// ── ACTIVATE: clean old caches ──
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames
          .filter(name => name.startsWith('merka-pos-') && name !== CACHE_NAME)
          .map(name => caches.delete(name))
      );
    })
  );
  self.clients.claim();
});

// ── FETCH: network-first for API, cache-first for assets ──
self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);

  // API calls (n8n webhooks) → always network, never cache
  if(url.href.includes('/webhook/')){
    event.respondWith(
      fetch(event.request).catch(() => {
        return new Response(
          JSON.stringify({ok:false, error:'Sin conexión', data:[]}),
          {headers:{'Content-Type':'application/json'}}
        );
      })
    );
    return;
  }

  // Google Fonts & CDN → cache first, fallback to network
  if(url.hostname.includes('fonts.') || url.hostname.includes('cdnjs.')){
    event.respondWith(
      caches.match(event.request).then(cached => {
        return cached || fetch(event.request).then(response => {
          const clone = response.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
          return response;
        });
      })
    );
    return;
  }

  // App shell (HTML/JS/CSS) → network first, fallback to cache
  event.respondWith(
    fetch(event.request)
      .then(response => {
        // Cache successful responses
        if(response && response.status === 200){
          const clone = response.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
        }
        return response;
      })
      .catch(() => {
        // Offline fallback
        return caches.match(event.request).then(cached => {
          if(cached) return cached;
          // For navigation requests, return index.html
          if(event.request.mode === 'navigate'){
            return caches.match('/index.html');
          }
          return new Response('Offline', {status: 503});
        });
      })
  );
});

// ── BACKGROUND SYNC: retry failed API calls when online ──
self.addEventListener('sync', event => {
  if(event.tag === 'merka-sync'){
    event.waitUntil(
      self.clients.matchAll().then(clients => {
        clients.forEach(client => client.postMessage({type: 'SYNC_NOW'}));
      })
    );
  }
});
