# Events360

Events360: Your Complete Conference Companion - Navigate schedules, connect with speakers, and maximize your event experience.

## Supabase Setup

### 1. Create a Supabase Project

1. Go to [Supabase](https://supabase.com/) and sign up or log in
2. Create a new project
3. Note your project URL and anon key

### 2. Set Up Environment Variables

Create a `.env` file in the root of your project with the following content:
```







When you build an app with native code (like Flutter apps), the release version is typically stripped of debugging information to make it smaller. However, this makes it difficult to diagnose crashes later.

1. First, modify your android/app/build.gradle to enable debug symbols generation:

buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        
        ndk {
            debugSymbolLevel 'SYMBOL_TABLE'
        }
    }
}


//FOR AAB
2. Or if you're building an APK:

flutter build appbundle --release --split-debug-info=build/app/symbols


//FOR IPA
3. After fixing your build.gradle file, you can generate an app bundle with debug symbols using:

flutter build appbundle --obfuscate --split-debug-info=build/app/symbols

------------------------------------------------------------------------------

The --split-debug-info flag specifies where the debug symbols will be stored. After running this command, you'll find the debug symbols in the build/app/symbols directory.

These debug symbols will help you:

- Decode obfuscated stack traces
- Better understand crash reports
- Debug issues in production more effectively
You can then upload these symbols to various services like Firebase Crashlytics or the Google Play Console to get readable crash reports.


## Uploading Debug Symbols to Play Console
After building, you should:

1. Go to your app in the Play Console
2. Navigate to your app release under "Closed testing"
3. Find "App Bundle Explorer" or the "Debug symbols" section
4. Upload the generated files from your build/app/symbols directory
This will help Google Play provide more readable crash reports if your app encounters issues in production, making it much easier to diagnose and fix problems.