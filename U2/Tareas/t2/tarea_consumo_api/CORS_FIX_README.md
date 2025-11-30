# CORS Error Fix - Game of Thrones API

## Problem Overview

When running the Flutter app on **Chrome (web)**, images from `thronesapi.com` fail to load with the error:
```
Access to image at 'https://thronesapi.com/assets/images/...' from origin 'http://localhost:...' 
has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
```

## What is CORS?

**CORS (Cross-Origin Resource Sharing)** is a browser security feature that restricts web pages from making requests to a different domain than the one serving the page.

- **Your app domain**: `http://localhost:50674`
- **Image domain**: `https://thronesapi.com`
- **Result**: Browser blocks the request for security reasons

## Important Notes

⚠️ **This issue ONLY affects Flutter Web (Chrome, Firefox, etc.)**

✅ **No CORS issues on:**
- Android devices/emulators
- iOS devices/simulators
- Windows desktop
- macOS desktop
- Linux desktop

## Solutions Implemented

### Solution 1: CORS Proxy (Currently Applied)

The app now automatically detects when running on web and routes image requests through a CORS proxy:

```dart
String _getImageUrl(String originalUrl) {
  if (kIsWeb && originalUrl.isNotEmpty) {
    return 'https://corsproxy.io/?${Uri.encodeComponent(originalUrl)}';
  }
  return originalUrl;
}
```

**How it works:**
1. Detects if app is running on web using `kIsWeb`
2. Wraps image URLs with `https://corsproxy.io/?...`
3. The proxy server fetches the image and adds proper CORS headers
4. Browser allows the request

**Pros:**
- ✅ Works immediately
- ✅ No configuration needed
- ✅ Only affects web platform

**Cons:**
- ⚠️ Depends on third-party proxy service
- ⚠️ Slightly slower image loading on web

### Solution 2: Run on Mobile/Desktop (Recommended for Production)

Simply run your app on a non-web platform:

```bash
# List available devices
flutter devices

# Run on Android
flutter run -d <android-device-id>

# Run on Windows
flutter run -d windows

# Run on Chrome (with CORS proxy - already implemented)
flutter run -d chrome
```

### Solution 3: Chrome with Disabled Security (Development Only)

**⚠️ WARNING: Only for development, NEVER for production!**

You can launch Chrome with security disabled:

```bash
# Windows
chrome.exe --user-data-dir="C:/Chrome dev session" --disable-web-security

# Then run your app
flutter run -d chrome
```

**NEVER use this for production or regular browsing!**

## Error Handling Implemented

The app now includes robust error handling for images:

1. **Loading State**: Shows a spinner while loading
2. **Error Fallback**: Shows a person icon if image fails
3. **Caching**: Uses `cached_network_image` for better performance
4. **Platform Detection**: Automatically uses CORS proxy on web

## Testing the Fix

1. **Hot Reload** your running app (press `r` in the terminal)
2. Images should now load successfully through the CORS proxy
3. You'll see either:
   - ✅ Character images loading correctly
   - 🔄 Loading spinner while fetching
   - 👤 Person icon for failed images

## Alternative CORS Proxies

If `corsproxy.io` is slow or unavailable, you can try these alternatives:

```dart
// Option 1: corsproxy.io (current)
return 'https://corsproxy.io/?${Uri.encodeComponent(originalUrl)}';

// Option 2: allorigins.win
return 'https://api.allorigins.win/raw?url=${Uri.encodeComponent(originalUrl)}';

// Option 3: cors-anywhere (requires setup)
return 'https://cors-anywhere.herokuapp.com/$originalUrl';
```

## Long-term Solutions

For production apps, consider:

1. **Use mobile/desktop platforms** - No CORS issues
2. **Backend proxy** - Create your own image proxy server
3. **Contact API owner** - Request they add CORS headers
4. **Cache images** - Download and serve from your own server

## Questions?

If you continue to have issues:
1. Check your internet connection
2. Try hot reloading (`r` in terminal)
3. Try restarting the app (`R` in terminal)
4. Check if the proxy service is online
5. Consider running on Android/Desktop instead
