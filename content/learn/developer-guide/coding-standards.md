---
title: Coding Standards Developer Guide
linktitle: Coding standards
summary: Logging guidelines for Keyple contributors
type: book
toc: true
weight: 3
---

<br>

## Overview

This guide defines **mandatory logging rules** for contributors working on the Keyple codebase.

The objective is to ensure:

- predictable behavior for integrators,
- compatibility with Android ProGuard / R8 optimizations,
- consistent logging across all libraries.

<br>

## SLF4J usage

### Dependency configuration

All Keyple JVM libraries using logging **MUST** declare SLF4J using the following configuration:

```kotlin
compileOnly("org.slf4j:slf4j-api:1.7.36")
```

<br>

Both the dependency scope (`compileOnly`) and the exact version (`1.7.36`) are mandatory and must not be changed locally.

Why `compileOnly` is required:

- **Keyple must remain logging-backend agnostic**<br>
  Keyple is a library and must not impose any SLF4J binding or logging implementation
  (Timber, Logback, Log4j, Android Log, etc.) on integrator applications.
- **Avoids leaking dependencies into the application classpath**<br>
  Declaring SLF4J as `implementation` would make it a transitive dependency,
  potentially overriding or conflicting with the version selected by the application.
- **Preserves full control for integrators**<br>
  Integrators decide:
  - which SLF4J binding to use,
  - how logging is routed (Android Log, Timber, file, remote, etc.),
  - which log levels are enabled per build type.
- **Ensures correct ProGuard / R8 behavior on Android**<br>
  ProGuard and R8 rules that disable or optimize logging are applied at the application level.
  Using `compileOnly` ensures those rules apply uniformly to Keyple and to all third-party libraries.
- **Prevents runtime coupling to logging behavior**<br>
  Keyple code relies strictly on SLF4J API contracts and never on runtime side effects,
  guaranteeing predictable behavior across all environments.

Why SLF4J `1.7.36` is mandatory:

- **Last stable release of the SLF4J 1.7.x line**<br>
  Version `1.7.36` is the final and most stable release before the major 2.x API changes.
- **Binary compatibility with existing bindings**<br>
  Most Android-compatible SLF4J bridges (including `slf4j-timber`) target the 1.7.x API.
- **Allows integrators to freely choose their SLF4J version (including 2.x)**<br>
  Keyple is compiled against SLF4J `1.7.36`, whose API remains compatible with SLF4J 2.x.<br>
  As a result:
  - integrator applications may safely use SLF4J 1.7.x or 2.x at runtime,
  - the chosen SLF4J version and binding are fully controlled by the application,
  - Keyple remains agnostic to logging backend and runtime logging behavior.
- **Predictable behavior with Android tooling**<br>
  Version `1.7.36` is well-tested with:
  - Android Gradle Plugin,
  - D8 (DEX compiler) / R8,
  - ProGuard optimizations.

{{% callout warning %}}
Do not change the SLF4J dependency scope or upgrade the version without a project-wide decision.
Any deviation may cause classpath conflicts, logging failures, or broken ProGuard / R8 optimizations
in integrator applications.
{{% /callout %}}

### Logger declaration

Loggers **must be declared once per class** as a `static` field (Java) or inside a `companion object` (Kotlin).

This ensures:

- a single logger instance per class,
- consistent logger naming,
- minimal runtime overhead,
- better analysis and optimization by R8.

**Java**

```java
private static final Logger logger = LoggerFactory.getLogger(MyClass.class);
```
<br>

**Kotlin**

```kotlin
companion object {
    private val logger = LoggerFactory.getLogger(MyClass::class.java)
}
```

<br>

{{% callout warning %}}
Do not declare loggers as instance fields.
This avoids unnecessary allocations and keeps logging behavior predictable.
{{% /callout %}}

<br>

## Android constraints and rationale

### ProGuard / R8 limitations

On Android:

- SLF4J loggers are accessed via interfaces,
- concrete implementations are resolved dynamically at runtime,
- R8 cannot safely assume that unguarded interface calls have no side effects.

As a result, when logs are **not conditionally guarded**:

- `logger.debug(...)` calls may remain in the optimized bytecode,
- log arguments may still be evaluated,
- unnecessary allocations and computations may occur,
- performance may be impacted, even in release builds.

### What R8 can optimize reliably

When the conditional pattern is used:

```java
if (logger.isDebugEnabled()) {
    logger.debug(...);
}
```

<br>

And with the appropriate ProGuard / R8 rules:

- `isDebugEnabled()` is treated as always `false`,
- the conditional branch is proven unreachable,
- the entire block is removed,
- argument evaluation is completely eliminated.

{{% callout note %}}
This pattern exists to help the compiler and optimizer, not the logger.
Without it, log removal on Android cannot be guaranteed.
{{% /callout %}}

<br>

## Logging coding standards

### Conditional logging pattern (mandatory)

All `DEBUG` and `TRACE` log statements **MUST** be conditionally guarded.
This pattern is mandatory in **all Keyple code**, without exception.

**Java (required)**

```java
if (logger.isDebugEnabled()) {
    logger.debug("Card detected [powerOnData={}]", cardPowerOnData);
}
```

<br>

**Kotlin (required)**

```kotlin
if (logger.isDebugEnabled) {
    logger.debug("Card detected [powerOnData={}]", cardPowerOnData)
}
```

<br>

### Forbidden logging patterns

Unguarded logging calls are strictly forbidden, even when:

- the log level is expected to be disabled,
- arguments appear inexpensive,
- the message uses constants or string literals.

**Java (forbidden)**

```java
// ❌ Forbidden: unguarded debug logging
logger.info("Card detected [powerOnData=" + cardPowerOnData + "]");

// ✅ Valid
logger.info("Card detected [powerOnData={}]", cardPowerOnData);
```

<br>

**Kotlin (forbidden)**

```kotlin
// ❌ Forbidden: unguarded debug logging
logger.info("Card detected [powerOnData=${cardPowerOnData}]")

// ✅ Valid
logger.info("Card detected [powerOnData={}]", cardPowerOnData)
```

<br>

### Logging levels in Keyple

| Level | Usage                                             |
|-------|---------------------------------------------------|
| ERROR | Functional or technical failures                  |
| WARN  | Unexpected but recoverable situations             |
| INFO  | High-level lifecycle events                       |
| DEBUG | Detailed execution flow (guarded)                 |
| TRACE | Low-level protocol / byte-level details (guarded) |

<br>

## Summary for contributors

- Use SLF4J `1.7.36` with `compileOnly` mode only
- Always guard DEBUG and TRACE logs
- Never rely on ProGuard to remove unguarded logs
- Write logs with integrators and performance in mind