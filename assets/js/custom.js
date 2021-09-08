function updateClipboard(newClip, button) {
    navigator.permissions.query({name: "clipboard-write"}).then(result => {
        if (result.state == "granted" || result.state == "prompt") {
            /* write to the clipboard now */
            navigator.clipboard.writeText(newClip).then(function() {
                /* clipboard successfully set */
                button.innerHTML = "Copied";
                setTimeout(function() {
                    button.innerHTML = "Copy";
                }, 2000);
            }, function() {
                /* clipboard write failed */
                alert("Error during the copy to clipboard!");
            });
        } else {
            alert("Unable to copy to clipboard because your browser does not have the permissions to use the \"clipboard-write\" API!");
        }
    });
}
function copyTabContentToClipboard(tabpaneId, button) {
    let tabId = $("#"+tabpaneId+" a.active")[0].getAttribute("aria-controls");
    let content = $("#"+tabId+" code")[0].innerText;
    updateClipboard(content, button);
}

// Dynamic dependencies for "client application" profile of "configuration wizard" java page
const appDependencies = new Set();
function computeAppContent(language) {
    let tagPrefix = 'code#all-'+language+'-dependencies span#';
    let contentHtml = $(tagPrefix+'calypsonet-terminal-reader-java-api').html();
    if (appDependencies.has("cardCalypso")) {
        contentHtml += "\n" + $(tagPrefix+'calypsonet-terminal-calypso-java-api').html();
    }
    contentHtml += "\n" + $(tagPrefix+'keyple-common-java-api').html()
        + "\n" + $(tagPrefix+'keyple-util-java-lib').html()
        + "\n" + $(tagPrefix+'keyple-service-java-lib').html();
    if (appDependencies.has("serviceResource")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-service-resource-java-lib').html();
    }
    if (appDependencies.has("distributedLocal") || appDependencies.has("distributedRemote")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-distributed-network-java-lib').html();
    }
    if (appDependencies.has("distributedLocal")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-distributed-local-java-lib').html();
    }
    if (appDependencies.has("distributedRemote")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-distributed-remote-java-lib').html();
    }
    if (appDependencies.has("cardGeneric")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-card-generic-java-lib').html();
    }
    if (appDependencies.has("cardCalypso")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-card-calypso-java-lib').html();
    }
    if (appDependencies.has("pluginAndroidNfc")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-android-nfc-java-lib').html();
    }
    if (appDependencies.has("pluginAndroidOmapi")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-android-omapi-java-lib').html();
    }
    if (appDependencies.has("pluginPcsc")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-pcsc-java-lib').html();
    }
    if (appDependencies.has("pluginStub")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-stub-java-lib').html();
    }
    return contentHtml;
}
function updateAppDependencies(tabRef, checkbox) {
    if (checkbox != null) {
        if (checkbox.checked == true) {
            appDependencies.add(checkbox.id);
        } else {
            appDependencies.delete(checkbox.id);
        }
    }
    let tabContentId = "#tabs-"+tabRef+"-content";
    $(tabContentId+" .language-gradle")[0].innerHTML = computeAppContent("groovy");
    $(tabContentId+" .language-kotlin")[0].innerHTML = computeAppContent("kotlin");
    $(tabContentId+" .language-xml")[0].innerHTML = computeAppContent("maven");
}

// Dynamic dependencies for "custom Keyple card extension" profile of "configuration wizard" java page
const cardDependencies = new Set();
function computeCardContent(language) {
    let tagPrefix = 'code#all-'+language+'-dependencies span#';
    let contentHtml = $(tagPrefix+'calypsonet-terminal-reader-java-api').html()
        + "\n" + $(tagPrefix+'calypsonet-terminal-card-java-api').html()
        + "\n" + $(tagPrefix+'keyple-common-java-api').html()
        + "\n" + $(tagPrefix+'keyple-util-java-lib').html();
    if (cardDependencies.has("cardServiceResource")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-service-resource-java-lib').html();
    }
    return contentHtml;
}
function updateCardDependencies(tabRef, checkbox) {
    if (checkbox != null) {
        if (checkbox.checked == true) {
            cardDependencies.add(checkbox.id);
        } else {
            cardDependencies.delete(checkbox.id);
        }
    }
    let tabContentId = "#tabs-"+tabRef+"-content";
    $(tabContentId+" .language-gradle")[0].innerHTML = computeCardContent("groovy");
    $(tabContentId+" .language-kotlin")[0].innerHTML = computeCardContent("kotlin");
    $(tabContentId+" .language-xml")[0].innerHTML = computeCardContent("maven");
}
