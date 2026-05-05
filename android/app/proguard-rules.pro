# uCrop rules
-keep class com.yalantis.ucrop.** { *; }
-dontwarn com.yalantis.ucrop.**

# OkHttp3 rules (karena uCrop butuh ini)
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**