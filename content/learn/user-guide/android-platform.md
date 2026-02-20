---
title: Android Platform User Guide
linktitle: Android platform
summary: How to configure an Android end-user Keyple-based application.
type: book
toc: true
draft: false
weight: 7
---

<br>

## Overview

This guide is intended for Android application integrators using Keyple and other third-party libraries that rely on SLF4J for logging.

Its goal is to explain:

- how to configure logging properly in an Android application,
- how to disable low-level logs in production,
- and how to avoid unnecessary performance overhead.

<br>

## Logging configuration

### Using Timber (recommended)

Keyple and several third-party libraries use SLF4J as a logging facade.
On Android, the recommended setup is to bridge SLF4J to Timber, which itself delegates to the Android Log system.

Recommended dependencies:

```kotlin
// Logging stack:
// - SLF4J API is used by Keyple and other third-party libraries.
// - slf4j-timber bridges SLF4J calls to Timber.
// - Timber is the actual Android logging implementation.
implementation("org.slf4j:slf4j-api:1.7.36")
implementation("com.arcao:slf4j-timber:3.1@aar")
implementation("com.jakewharton.timber:timber:5.0.1")
```

<br>

This setup ensures:

- a single logging API across the whole project,
- consistent log routing on Android,
- minimal coupling between libraries and logging backends.

### Using Android Log

If you prefer to use Android's native logging system directly without Timber, you can bridge SLF4J to the Android Log API.

Recommended dependencies:

```kotlin
// Logging stack:
// - SLF4J API is used by Keyple and other third-party libraries.
// - slf4j-android bridges SLF4J calls directly to Android Log.
implementation("org.slf4j:slf4j-api:1.7.36")
implementation("org.slf4j:slf4j-android:1.7.36")
```

<br>

This setup provides:

- direct integration with Android's native logging system,
- simple configuration with minimal dependencies,
- automatic log tag generation based on logger names.

<br>

## ProGuard/R8 setup

### Disabling debug and trace logs in production

In release builds, low-level logs (DEBUG / TRACE) should be disabled to:

- reduce runtime overhead,
- remove unnecessary string allocations,
- improve startup and execution performance.

Add the following rule to your `proguard-rules.pro`:

```bash
# Disable SLF4J debug and trace checks in optimized builds.
# Calls to isDebugEnabled() and isTraceEnabled() will always return false,
# allowing R8 to remove guarded logging blocks.
# This applies to application code as well as third-party libraries (e.g. Keyple).
-assumenosideeffects interface org.slf4j.Logger {
    public boolean isTraceEnabled() return false;
    public boolean isDebugEnabled() return false;
}
```

<br>

{{% callout warning %}}
**Important limitation**

R8 cannot reliably remove unguarded calls such as:

```java
logger.debug("Hello");
```

Only logging statements protected by `isDebugEnabled()` / `isTraceEnabled()` can be safely eliminated.
{{% /callout %}}

<br>

## Performance optimization best practices

### Always guard debug and trace logs

Recommended pattern:

```java
// ❌ Avoid
logger.debug("Card detected [powerOnData={}]", cardPowerOnData);

// ✅ Valid
if (logger.isDebugEnabled()) {
    logger.debug("Card detected [powerOnData={}]", cardPowerOnData);
}
```

<br>

This allows R8 to:

- remove the entire block in optimized builds,
- skip argument evaluation,
- eliminate string concatenations and temporary objects.

### Avoid unguarded logging

```java
// ❌ Avoid
logger.info("Card detected [powerOnData=" + cardPowerOnData + "]");

// ✅ Valid
logger.info("Card detected [powerOnData={}]", cardPowerOnData);
```

<br>

Even if logging is disabled, argument evaluation may still occur.

<br>

## Debug builds with release-like performance

Sometimes it is useful to test performance with minification enabled even in debug builds.

Example `build.gradle.kts` configuration:

```kotlin
// Debug configuration with release-like optimizations enabled.
// This setup is intended for performance testing during development.
// To get full debug logs, this block can be commented out or relaxed.
getByName("debug") {
    isMinifyEnabled = true
    isShrinkResources = true
    proguardFiles(
        getDefaultProguardFile("proguard-android-optimize.txt"),
        "proguard-rules.pro"
    )
}
```

<br>

## Summary for integrators

- SLF4J is used by Keyple and third-party libraries.
- Timber is the recommended Android backend.
- Use ProGuard/R8 to disable debug and trace logging in production.
- Always prefer guarded logging for optimal performance.