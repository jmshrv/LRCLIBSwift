# LRCLIBSwift

A [LRCLIB](https://lrclib.net) API client for Swift.

## Usage

All methods in `LrcLib` are static, and can be accessed like so:

```swift
let lyricsByField = try await LrcLib.get(
    trackName: "Welcome to the Black Parade",
    artistName: "My Chemical Romance",
    albumName: "Welcome to the Black Parade",
    duration: 311
)

lyricsByField.trackName // "Welcome to the Black Parade"
lyricsByField.plainLyrics // "When I was a young boy..."
```

All endpoints specified in [LRCLIB's docs](https://lrclib.net/docs) are implemented, except endpoints for publishing new lyrics.

The implementation just uses `URLSession.shared` - you'll have to modify the library if you need a custom `URLSession`.
