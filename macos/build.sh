#!/bin/bash
set -e
cd "$(dirname "$0")"

APP="Kisses.app"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

cp Info.plist "$APP/Contents/Info.plist"

echo "Compiling Kisses.swift…"
swiftc -Onone -g -o "$APP/Contents/MacOS/Kisses" \
    Kisses.swift \
    -framework Cocoa \
    -framework AVFoundation \
    -framework CoreGraphics

if [ -f "soft-hum.mp3" ]; then
    cp soft-hum.mp3 "$APP/Contents/Resources/"
    echo "✓ bundled soft-hum.mp3"
fi

codesign --force --deep --sign - "$APP" 2>/dev/null || true

echo ""
echo "💋 built $APP"
echo "  Drag into /Applications or run: open $APP"
