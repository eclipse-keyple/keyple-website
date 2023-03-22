---
title: Card Resource Service User Guide
linktitle: Card resource service
summary: How to develop an end-user application using the Card Resource Service.
type: book
toc: true
draft: false
weight: 5
---

---
## Overview

An application that performs secure transactions on smart cards may need to dynamically allocate a card resource dedicated to the current transaction to manage the security of the transaction (e.g. SAM or HSM).

To meet this need, Keyple proposes the Service Resource component which provides a service that supports dynamic card resource allocation, using a profile-based filtering mechanism.

---
## Features

* card resource locking during use;
* automatic monitoring of observable plugins and readers;
* customizable profile-based filtering mechanism (specific plugins list, reader name using regular expression, reader group name for pool plugins, specific card selection);
* specific reader configuration capability;
* allocation priority management;
* two allocation modes (blocking, non-blocking);
* multiple allocation strategies (first available card resource, cyclic, random);
* configurable allocation timeout;
* failure management.

---
## Operating mode

1. [Access to the service](#access-to-the-service)
2. [Access to the configurator](#access-to-the-configurator)
3. Register [plugins](#register-plugins) and/or [pool plugins](#register-pool-plugins) to be used
4. [Define profiles](#define-profiles) for card resource filtering
5. [Set the allocation mode](#set-allocation-mode) (optional)
6. [Apply the configuration](#apply-the-configuration)
7. [Start the service](#start-the-service)
8. [Allocate a resource](#allocate-a-resource)
9. Use the resource
10. [Release the used resource](#release-a-resource)

---
## Access to the service

Invoke the `CardResourceServiceProvider.getService()` static method to access the service.

{{< code lang="java" >}}
CardResourceService cardResourceService = CardResourceServiceProvider.getService();
{{< /code >}}

---
## Configure the service

### Access to the configurator

Invoke the `getConfigurator()` method on the service to get a new instance of the service configurator.
It is built on the fluent pattern, and it guides you through the various steps to be specified during the configuration process.

{{< code lang="java" >}}
cardResourceService.getConfigurator()...
{{< /code >}}

### Register plugins

If you plan to use plugins of type `Plugin` or `ObservablePlugin` in the card resource service, you must specify the global ordered list of plugins to be used when searching for a card resource.

This is the default list that will be applied for profiles that have not explicitly specified another list.

Please note that the order in which plugins are added is important.

To add one or more plugins, you need to create a new instance of the `PluginsConfigurator` class and provide it to the configurator using the `withPlugins(...)` method.

It is possible to configure the following:
* specify the global allocation strategy to all added plugins;
* specify the global usage timeout of a resource;
* activate independently plugin by plugin the monitoring of the plugin and/or its readers in order to allow the service to automatically update the list of resources. In this case you will have to provide a handler to be informed in case of error or crash of the observation thread.

For each plugin added, you will need to provide an implementation of the `ReaderConfiguratorSpi` interface to automatically configure new readers or those already connected.

{{< code lang="java" >}}
.withPlugins(
    PluginsConfigurator.builder()
        .withAllocationStrategy(...)
        .withUsageTimeout(...)
        .addPluginWithMonitoring(...)
        .addPlugin(...)
        .addPluginWithMonitoring(...)
        .build())
{{< /code >}}

### Register pool plugins

If you plan to use plugins of type `PoolPlugin` in the card resource service, you must specify the global ordered list of pool plugins to be used when searching for a card resource.

This is the default list that will be applied for profiles that have not explicitly specified another list.

Please note that the order in which plugins are added is important.
If you use both plugins and pool plugins in your configuration, it is possible to specify if pool plugins should be taken into account first or not during the resource allocation process.

To add one or more pool plugins, you need to create a new instance of the `PoolPluginsConfigurator` class and provide it to the configurator using the `withPoolPlugins(...)` method.

{{< code lang="java" >}}
.withPoolPlugins(
    PoolPluginsConfigurator.builder()
        .usePoolFirst()
        .addPoolPlugin(...)
        .addPoolPlugin(...)
        .build())
{{< /code >}}

### Define profiles

A profile defines a set of filters which will be used when enumerating the available resources. The profile identifiers will be used when allocating a resource.

To add profiles, you must create a new instance of the `CardResourceProfileConfigurator` class for each profile and provide them to the configurator using the `withCardResourceProfiles(...)` method.

It is possible to configure the following:
* override the global plugin list to use;
* set reader name filter using a regex value;
* set reader group reference filter in case of pool plugins.

You also need to provide an implementation of the `CardResourceProfileExtension` interface in order to be able to customize the filtering if needed and to return to the service an implementation of the `SmartCard` interface when a compatible card is found.
The `SmartCard` found will be returned to the user by the allocation process.

{{< code lang="java" >}}
.withCardResourceProfiles(
    CardResourceProfileConfigurator.builder(RESOURCE_A, yourCardResourceProfileExtensionA)
        .withReaderNameRegex(READER_NAME_REGEX_A)
        .build(),
    CardResourceProfileConfigurator.builder(RESOURCE_B, yourCardResourceProfileExtensionB)
        .withReaderNameRegex(READER_NAME_REGEX_B)
        .build(),
    CardResourceProfileConfigurator.builder(RESOURCE_C, yourCardResourceProfileExtensionC)
        .withReaderGroupReference(READER_GROUP_REFERENCE_C)
        .build())
{{< /code >}}

### Set allocation mode

By default, the card resource service is configured with a **non-blocking** allocation mode.
This means that if no resources are available at the time of the request for an allocation, then the service returns the hand directly.

The `withBlockingAllocationMode(...)` method configure the service to perform allocations in **blocking** mode so that it only hands over when a resource becomes available.

You will then have to specify the duration between two search cycles and the maximum waiting time so that the service can always return after a certain time if it has still not found anything.

{{< code lang="java" >}}
.withBlockingAllocationMode(100, 10000) // e.g. search each 100 ms during 10 seconds maximum
{{< /code >}}

### Apply the configuration

Invoke the `configure()` method on the configurator to finalise and apply the configuration.

Once finalized, the new configuration replaces the previous one but does not change the state of the service.
If the service was already started at that moment, then it stops, applies the new configuration, and restarts.

{{< code lang="java" >}}
.configure();
{{< /code >}}

---
## Use the service

### Start the service

Invoke the `start()` method on the service to start the service using the current configuration.
The service will initialize the list of available resources for each profile and start the monitoring processes if requested.

{{< code lang="java" >}}
cardResourceService.start();
{{< /code >}}

### Allocate a resource

Invoke the `getCardResource(...)` method on the service to retrieve and lock a card resource.
You just have to specify the name of the profile to use.

If the allocation mode is blocking, then the method will wait a while for a resource to become available.

{{< code lang="java" >}}
CardResource cardResource = cardResourceService.getCardResource(RESOURCE_A);
{{< /code >}}

### Release a resource

Invoke the `releaseCardResource(...)` method on the service to unlock a card resource.
You just have to provide the card resource to release.

{{< code lang="java" >}}
cardResourceService.releaseCardResource(cardResource);
{{< /code >}}

### Delete a resource

Invoke the `removeCardResource(...)` method on the service to remove a card resource from the available card resource list.
This can be useful in some cases if the card or reader has failed.
You just have to provide the card resource to remove.

{{< code lang="java" >}}
cardResourceService.removeCardResource(cardResource);
{{< /code >}}

### Stop the service

Invoke the `stop()` method on the service to stop the service if needed. Any monitoring is then stopped and no more resources are accessible.

{{< code lang="java" >}}
cardResourceService.stop();
{{< /code >}}

---
## API

* [API documentation & class diagram](https://eclipse.github.io/keyple-service-resource-java-lib)

---
## Example

* [Java example](https://github.com/eclipse/keyple-java-example)

---
## Download

* [Java components]({{< ref "components-java/overview/configuration-wizard" >}})