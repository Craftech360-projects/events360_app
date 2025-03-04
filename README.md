# events360


1. First, modify your android/app/build.gradle to enable debug symbols generation:

buildTypes {
        release {
            // ... other release configurations ...
            ndk {
                debugSymbolLevel 'SYMBOL_TABLE'
            }
        }
    }

2. When building your app bundle, use this command to generate debug symbols:

flutter build appbundle --obfuscate --split-debug-info=build/app/symbols

3. Or if you're building an APK:

flutter build apk --obfuscate --split-debug-info=build/app/symbols

------------------------------------------------------------------------------

The --split-debug-info flag specifies where the debug symbols will be stored. After running this command, you'll find the debug symbols in the build/app/symbols directory.

These debug symbols will help you:

- Decode obfuscated stack traces
- Better understand crash reports
- Debug issues in production more effectively
You can then upload these symbols to various services like Firebase Crashlytics or the Google Play Console to get readable crash reports.

For Google Play Console:

1. Go to your app in the Play Console
2. Navigate to your app release
3. Find "App Bundle Explorer"
4. Look for the option to upload debug symbols
5. Upload the generated files from your build/app/symbols directory
This will help you maintain and debug your app more effectively in production.