// make the footer full width
let pageFooterContainer = $(".page-footer>.container");
pageFooterContainer.addClass("container-fluid");
pageFooterContainer.removeClass("container");
pageFooterContainer.css("padding-left", "0");
pageFooterContainer.css("padding-right", "0");

/**
 * Dependency check management
 */
const ComponentName = {
    READER_API: "readerApi",
    CARD_API: "cardApi",
    CALYPSO_API: "calypsoApi",
    CALYPSO_SYMMETRIC_API: "calypsoSymmetricApi",
    CALYPSO_LEGACY_SAM_API: "calypsoLegacySamApi",
    CALYPSO_ASYMMETRIC_API: "calypsoAsymmetricApi",
    COMMON_API: "commonApi",
    DISTRIBUTED_LOCAL_API: "distributedLocalApi",
    DISTRIBUTED_REMOTE_API: "distributedRemoteApi",
    PLUGIN_API: "pluginApi",
    UTIL_LIB: "utilLib",
    SERVICE_LIB: "serviceLib",
    SERVICE_RESOURCE_LIB: "serviceResourceLib",
    DISTRIBUTED_LOCAL_LIB: "distributedLocalLib",
    DISTRIBUTED_NETWORK_LIB: "distributedNetworkLib",
    DISTRIBUTED_REMOTE_LIB: "distributedRemoteLib",
    CALYPSO_CARD_LIB: "calypsoCardLib",
    CALYPSO_LEGACY_SAM_LIB: "calypsoLegacySamLib",
    CALYPSO_PKI_LIB: "calypsoPkiLib",
    GENERIC_LIB: "genericLib",
    PLUGIN_ANDROID_NFC_LIB: "pluginAndroidNfcLib",
    PLUGIN_ANDROID_OMAPI_LIB: "pluginAndroidOmapiLib",
    PLUGIN_CARD_RESOURCE_LIB: "pluginCardResourceLib",
    PLUGIN_PCSC_LIB: "pluginPcscLib",
    PLUGIN_STUB_LIB: "pluginStubLib"
};
const componentNames = [
    ComponentName.READER_API,
    ComponentName.CARD_API,
    ComponentName.CALYPSO_API,
    ComponentName.CALYPSO_SYMMETRIC_API,
    ComponentName.CALYPSO_LEGACY_SAM_API,
    ComponentName.CALYPSO_ASYMMETRIC_API,
    ComponentName.COMMON_API,
    ComponentName.DISTRIBUTED_LOCAL_API,
    ComponentName.DISTRIBUTED_REMOTE_API,
    ComponentName.PLUGIN_API,
    ComponentName.UTIL_LIB,
    ComponentName.SERVICE_LIB,
    ComponentName.SERVICE_RESOURCE_LIB,
    ComponentName.DISTRIBUTED_LOCAL_LIB,
    ComponentName.DISTRIBUTED_NETWORK_LIB,
    ComponentName.DISTRIBUTED_REMOTE_LIB,
    ComponentName.CALYPSO_CARD_LIB,
    ComponentName.CALYPSO_LEGACY_SAM_LIB,
    ComponentName.CALYPSO_PKI_LIB,
    ComponentName.GENERIC_LIB,
    ComponentName.PLUGIN_ANDROID_NFC_LIB,
    ComponentName.PLUGIN_ANDROID_OMAPI_LIB,
    ComponentName.PLUGIN_CARD_RESOURCE_LIB,
    ComponentName.PLUGIN_PCSC_LIB,
    ComponentName.PLUGIN_STUB_LIB
];
function Release (componentName, componentVersion) {
    this.componentName = componentName;
    this.componentVersions = [componentVersion];
}
function ReleaseTrain (...releases) {
    this.releases = releases;
}
/******************************************************************************
 * Release trains of the dependency check tool
 *
 * Caution: always add on first position!
 *****************************************************************************/
let releaseTrains = [];
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.CALYPSO_PKI_LIB, "0.2.0")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.CALYPSO_LEGACY_SAM_API, "0.6.+"),
    new Release(ComponentName.CALYPSO_LEGACY_SAM_LIB, "0.7.0")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.CARD_API, "2.0.1+"),
    new Release(ComponentName.CALYPSO_API, "2.1.+"),
    new Release(ComponentName.CALYPSO_LEGACY_SAM_API, "0.5.+"),
    new Release(ComponentName.CALYPSO_ASYMMETRIC_API, "0.2.+"),
    new Release(ComponentName.PLUGIN_API, "2.3.+"),
    new Release(ComponentName.UTIL_LIB, "2.4.0"),
    new Release(ComponentName.SERVICE_LIB, "3.2.1"),
    new Release(ComponentName.SERVICE_RESOURCE_LIB, "3.0.1"),
    new Release(ComponentName.DISTRIBUTED_LOCAL_LIB, "2.3.1"),
    new Release(ComponentName.DISTRIBUTED_NETWORK_LIB, "2.3.1"),
    new Release(ComponentName.DISTRIBUTED_REMOTE_LIB, "2.3.1"),
    new Release(ComponentName.CALYPSO_CARD_LIB, "3.1.1"),
    new Release(ComponentName.CALYPSO_LEGACY_SAM_LIB, "0.6.0"),
    new Release(ComponentName.CALYPSO_PKI_LIB, "0.1.0"),
    new Release(ComponentName.GENERIC_LIB, "3.0.1"),
    new Release(ComponentName.PLUGIN_ANDROID_NFC_LIB, "2.2.0"),
    new Release(ComponentName.PLUGIN_ANDROID_OMAPI_LIB, "2.1.0"),
    new Release(ComponentName.PLUGIN_CARD_RESOURCE_LIB, "2.0.1"),
    new Release(ComponentName.PLUGIN_PCSC_LIB, "2.2.1"),
    new Release(ComponentName.PLUGIN_STUB_LIB, "2.2.1")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.PLUGIN_API, "2.3.+"),
    new Release(ComponentName.SERVICE_LIB, "3.2.0"),
    new Release(ComponentName.PLUGIN_PCSC_LIB, "2.2.0")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.CALYPSO_LEGACY_SAM_API, "0.4.+"),
    new Release(ComponentName.CALYPSO_LEGACY_SAM_LIB, "0.5.0")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.SERVICE_LIB, "3.1.0")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.SERVICE_LIB, "3.0.1")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.CALYPSO_CARD_LIB, "3.0.1")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.UTIL_LIB, "2.3.1")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.PLUGIN_ANDROID_NFC_LIB, "2.1.0")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.PLUGIN_ANDROID_OMAPI_LIB, "2.0.1")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.PLUGIN_PCSC_LIB, "2.1.2")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.PLUGIN_STUB_LIB, "2.2.0")
));
releaseTrains.push(new ReleaseTrain(
    new Release(ComponentName.READER_API, "2.0.+"),
    new Release(ComponentName.CARD_API, "2.0.0"),
    new Release(ComponentName.CALYPSO_API, "2.0.+"),
    new Release(ComponentName.CALYPSO_SYMMETRIC_API, "0.1.+"),
    new Release(ComponentName.CALYPSO_LEGACY_SAM_API, "0.3.+"),
    new Release(ComponentName.CALYPSO_ASYMMETRIC_API, "0.1.+"),
    new Release(ComponentName.COMMON_API, "2.0.+"),
    new Release(ComponentName.DISTRIBUTED_LOCAL_API, "2.1.+"),
    new Release(ComponentName.DISTRIBUTED_REMOTE_API, "3.0.+"),
    new Release(ComponentName.PLUGIN_API, "2.2.+"),
    new Release(ComponentName.UTIL_LIB, "2.3.0"),
    new Release(ComponentName.SERVICE_LIB, "3.0.0"),
    new Release(ComponentName.SERVICE_RESOURCE_LIB, "3.0.0"),
    new Release(ComponentName.DISTRIBUTED_LOCAL_LIB, "2.3.0"),
    new Release(ComponentName.DISTRIBUTED_NETWORK_LIB, "2.3.0"),
    new Release(ComponentName.DISTRIBUTED_REMOTE_LIB, "2.3.0"),
    new Release(ComponentName.CALYPSO_CARD_LIB, "3.0.0"),
    new Release(ComponentName.CALYPSO_LEGACY_SAM_LIB, "0.4.0"),
    new Release(ComponentName.GENERIC_LIB, "3.0.0"),
    new Release(ComponentName.PLUGIN_ANDROID_NFC_LIB, "2.0.0"),
    new Release(ComponentName.PLUGIN_ANDROID_OMAPI_LIB, "2.0.0"),
    new Release(ComponentName.PLUGIN_CARD_RESOURCE_LIB, "2.0.0"),
    new Release(ComponentName.PLUGIN_PCSC_LIB, "2.0.0"),
    new Release(ComponentName.PLUGIN_STUB_LIB, "2.0.0")
));
/**
 * The aim is to get rid of non-impacting release trains,
 * i.e. release trains that only concern a single release and have no impact on other components,
 * as these release trains should not generate a new entry in the dependency check table.
 * These non-impacting releases versions should be displayed as a range of values (e.g. 1.0.0...1.2.3).
 * We will therefore aggregate these non-impacting releases versions
 * into impacting release trains referencing several releases, then delete the non-impacting release trains.
 */
mergeNonImpactingReleaseTrains = function() {
    let componentNameToVersionsMap = new Map();
    let indexesOfNonImpactingReleaseTrains = [];
    // Merge all non-impacting releases versions
    for (let i = 0; i < releaseTrains.length; i++) {
        let releaseTrain = releaseTrains[i];
        // Check if the current release train is non-impacting
        if (releaseTrain.releases.length === 1) {
            // Non-impacting release train => we register the version of the release train's only release in the map of
            // non-impacting releases in the first position, in case this component is already present,
            // and we also register the release train's index so that we can delete the release later.
            let componentName = releaseTrain.releases[0].componentName;
            let componentVersion = releaseTrain.releases[0].componentVersions[0];
            if (componentNameToVersionsMap.has(componentName)) {
                // Add version to first position
                let componentLatestVersions = componentNameToVersionsMap.get(componentName);
                componentLatestVersions.unshift(componentVersion);
            } else {
                // Save version as a single array-element
                componentNameToVersionsMap.set(componentName, [componentVersion]);
            }
            // Save the release train index
            indexesOfNonImpactingReleaseTrains.push(i);
        } else {
            // Impacting release trains => for each release in the release train, we check whether it is present in the 
            // map of non-impacting releases. If so, we aggregate the versions associated with the component in the 
            // release, then remove the component from the map.
            for (let j = 0; j < releaseTrain.releases.length; j++) {
                let componentName = releaseTrain.releases[j].componentName;
                let componentVersions = releaseTrain.releases[j].componentVersions;
                if (componentNameToVersionsMap.has(componentName)) {
                    // Add latest version(s) to the current release
                    let componentLatestVersions = componentNameToVersionsMap.get(componentName);
                    componentVersions.push(...componentLatestVersions);
                    // Remove the component from the map
                    componentNameToVersionsMap.delete(componentName);
                }
            }
        }
    }
    // Remove all non-impacting releases
    for (let i = indexesOfNonImpactingReleaseTrains.length - 1; i >= 0; i--) {
        releaseTrains.splice(indexesOfNonImpactingReleaseTrains[i], 1);
    }
}
/**
 * Generates raw html content for rows in the dependency check table.
 * To do this, we go through the remaining (i.e. impacting) release trains from the oldest to the most recent.
 * For each of them, we generate the html content and update the version of each component impacted by the release train
 * in order to carry it over to more recent release trains.
 */
insertRowsIntoDependencyCheckHtmlTable = function() {
    let componentNameToVersionsMap = new Map();
    let htmlRows = [];
    for (let i = releaseTrains.length - 1; i >= 0; i--) {
        // Update the versions into the map for all components present into the current release
        let releases = releaseTrains[i].releases;
        for (let j = 0; j < releases.length; j++) {
            componentNameToVersionsMap.set(releases[j].componentName, releases[j].componentVersions);
        }
        // Build the row with the values from the map
        let htmlRow = "<tr>";
        for (let j = 0; j < componentNames.length; j++) {
            htmlRow += "<td>";
            let componentName = componentNames[j];
            if (componentNameToVersionsMap.has(componentName)) {
                let componentVersions = componentNameToVersionsMap.get(componentName);
                htmlRow += componentVersions[0];
                if (componentVersions.length > 1) {
                    // Add a range with the latest version
                    htmlRow += "...";
                    htmlRow += componentVersions[componentVersions.length - 1];
                }
            } else {
                htmlRow += "-";
            }
            htmlRow += "</td>";
        }
        htmlRow += "</tr>";
        // Add row to first position
        htmlRows.unshift(htmlRow);
    }
    // Insert rows into the table
    $('#datatable-dependency-check tbody').html(htmlRows.join());
}
initDatatableDependencyCheck = function() {
    // Prepare table rows
    mergeNonImpactingReleaseTrains();
    insertRowsIntoDependencyCheckHtmlTable();
    // Draw table
    $('#datatable-dependency-check').DataTable( {
        fixedHeader: {
            header: true,
            footer: true
        },
        scrollCollapse: true,
        scrollX: true,
        scrollY: 200,
        ordering: false,
        paging: false,
        initComplete: function () {
            // Remove the search input text & the footer information showing the number of results
            $("#datatable-dependency-check_wrapper div.row:nth-child(3)").remove();
            $("#datatable-dependency-check_wrapper div.row:nth-child(1)").remove();
            // Add the select button to the header of each column
            this.api().columns().every( function () {
                let column = this;
                let select = $('<br><select><option value=""></option></select>')
                    .appendTo($(column.header()))
                    .on('change', function () {
                        let val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );
                        column
                            .search(val ? '^' + val + '$' : '', true, false)
                            .draw();
                    });
                column.data().unique().sort().reverse().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
            // Refresh the content in order to adapt correctly the columns' width.
            this.api().draw();
        }
    } );
}
initDatatableDependencyCheckOld = function() {
    $('#datatable-dependency-check-old').DataTable( {
        fixedHeader: {
            header: true,
            footer: true
        },
        scrollCollapse: true,
        scrollX: true,
        scrollY: 200,
        ordering: false,
        paging: false,
        initComplete: function () {
            // Remove the search input text & the footer information showing the number of results
            $("#datatable-dependency-check-old_wrapper div.row:nth-child(3)").remove();
            $("#datatable-dependency-check-old_wrapper div.row:nth-child(1)").remove();
            // Add the select button to the header of each column
            this.api().columns().every( function () {
                let column = this;
                let select = $('<br><select><option value=""></option></select>')
                    .appendTo( $(column.header()) )
                    .on( 'change', function () {
                        let val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );
                        column
                            .search( val ? '^'+val+'$' : '', true, false )
                            .draw();
                    } );
                column.data().unique().sort().reverse().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
            // Refresh the content in order to adapt correctly the columns' width.
            this.api().draw();
        }
    } );
}

// Copy to clipboard
updateClipboard = function(newClip, button) {
    navigator.permissions.query({name: "clipboard-write"}).then(result => {
        if (result.state === "granted" || result.state === "prompt") {
            /* write to the clipboard now */
            navigator.clipboard.writeText(newClip).then(function() {
                /* clipboard successfully set */
                button.innerHTML = "Copied";
                setTimeout(function() {
                    button.innerHTML = "Copy";
                }, 2000);
            }, function() {
                /* clipboard write failed */
                alert("Error during the copy to clipboard process!");
            });
        } else {
            alert("Unable to copy to clipboard because your browser does not have the permissions to use the \"clipboard-write\" API!");
        }
    });
}
copyTabContentToClipboard = function(tabpaneId, button) {
    let tabId = $("#"+tabpaneId+" a.active")[0].getAttribute("aria-controls");
    let content = $("#"+tabId+" code")[0].innerText;
    updateClipboard(content, button);
}
copyCodeContentToClipboard = function(codeId, button) {
    let content = $("#code-"+codeId)[0].innerText;
    updateClipboard(content, button);
}

// Dynamic dependencies for "application" profile of "configuration wizard" java page
const appDependencies = new Set();
computeAppContent = function(language) {
    let tagPrefix = 'code#all-'+language+'-dependencies span#';
    let contentHtml = $(tagPrefix+'keypop-reader-java-api').html();
    if (appDependencies.has("cardCalypso")) {
        contentHtml += "\n" + $(tagPrefix+'keypop-calypso-card-java-api').html();
    }
    if (appDependencies.has("cardCalypsoLegacySam")) {
        contentHtml += "\n" + $(tagPrefix+'keypop-calypso-crypto-legacysam-java-api').html();
    }
    contentHtml += "\n" + $(tagPrefix+'keyple-common-java-api').html()
        + "\n" + $(tagPrefix+'keyple-util-java-lib').html()
        + "\n" + $(tagPrefix+'keyple-service-java-lib').html();
    if (appDependencies.has("serviceResource") || appDependencies.has("pluginCardResource")) {
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
    if (appDependencies.has("cardCalypsoLegacySam")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-card-calypso-crypto-legacysam-java-lib').html();
    }
    if (appDependencies.has("cardCalypsoPki")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-card-calypso-crypto-pki-java-lib').html();
    }
    if (appDependencies.has("pluginAndroidNfc")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-android-nfc-java-lib').html();
    }
    if (appDependencies.has("pluginAndroidOmapi")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-android-omapi-java-lib').html();
    }
    if (appDependencies.has("pluginCardResource")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-cardresource-java-lib').html();
    }
    if (appDependencies.has("pluginPcsc")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-pcsc-java-lib').html();
    }
    if (appDependencies.has("pluginStub")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-plugin-stub-java-lib').html();
    }
    return contentHtml;
}
const msgWizardGeneratedBegin = "Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/')";
const msgWizardGeneratedEnd = "End Keyple configuration";
const msgWizardGeneratedBeginDefault = "// " + msgWizardGeneratedBegin + "<br>";
const msgWizardGeneratedEndDefault = "<br>// " + msgWizardGeneratedEnd;
const msgWizardGeneratedBeginXml = "&lt!-- " + msgWizardGeneratedBegin + " --&gt<br>";
const msgWizardGeneratedEndXml = "<br>&lt!-- " + msgWizardGeneratedEnd + " --&gt";
updateAppDependencies = function(tabRef, checkbox) {
    if (checkbox != null) {
        if (checkbox.checked === true) {
            appDependencies.add(checkbox.id);
        } else {
            appDependencies.delete(checkbox.id);
        }
    }
    let tabContentId = "#tabs-"+tabRef+"-content";
    $(tabContentId+" .language-gradle")[0].innerHTML = msgWizardGeneratedBeginDefault + computeAppContent("groovy") + msgWizardGeneratedEndDefault;
    $(tabContentId+" .language-kotlin")[0].innerHTML = msgWizardGeneratedBeginDefault + computeAppContent("kotlin") + msgWizardGeneratedEndDefault;
    $(tabContentId+" .language-xml")[0].innerHTML = msgWizardGeneratedBeginXml + computeAppContent("maven") + msgWizardGeneratedEndXml;
}

// Dynamic dependencies for "custom Keyple card extension" profile of "configuration wizard" java page
const cardDependencies = new Set();
computeCardContent = function(language) {
    let tagPrefix = 'code#all-'+language+'-dependencies span#';
    let contentHtml = $(tagPrefix+'keypop-reader-java-api').html()
        + "\n" + $(tagPrefix+'keypop-card-java-api').html()
        + "\n" + $(tagPrefix+'keyple-common-java-api').html()
        + "\n" + $(tagPrefix+'keyple-util-java-lib').html();
    if (cardDependencies.has("cardServiceResource")) {
        contentHtml += "\n" + $(tagPrefix+'keyple-service-resource-java-lib').html();
    }
    return contentHtml;
}
updateCardDependencies = function(tabRef, checkbox) {
    if (checkbox != null) {
        if (checkbox.checked === true) {
            cardDependencies.add(checkbox.id);
        } else {
            cardDependencies.delete(checkbox.id);
        }
    }
    let tabContentId = "#tabs-"+tabRef+"-content";
    $(tabContentId+" .language-gradle")[0].innerHTML = msgWizardGeneratedBeginDefault + computeCardContent("groovy") + msgWizardGeneratedEndDefault;
    $(tabContentId+" .language-kotlin")[0].innerHTML = msgWizardGeneratedBeginDefault + computeCardContent("kotlin") + msgWizardGeneratedEndDefault;
    $(tabContentId+" .language-xml")[0].innerHTML = msgWizardGeneratedBeginXml + computeCardContent("maven") + msgWizardGeneratedEndXml;
}

// Load the project dashboard table content
loadProjectDashboard = async function() {

    let rootUrl = window.location.href + "../";

    if (rootUrl.includes("localhost")) {
        rootUrl = "https://keyple.org/";
    }

    async function getJson(fileName) {
        let response = await fetch(rootUrl + 'dashboard/' + fileName + '.json?date='+Date.now());
        return await response.json();
    }

    async function getJsonRepositoryData(repository_name, resource) {
        let response = await fetch(rootUrl + 'dashboard/' + repository_name + resource + '.json?date='+Date.now());
        return await response.json();
    }

    async function getReposData(rowIndex, owner, project) {

        // create row
        let newRow = body.insertRow();
        newRow.id = rowIndex;

        const json = await getJsonRepositoryData(project[0], "_");

        // new row
        const row = document.getElementById(rowIndex);

        // column repos name
        let cell = row.insertCell(-1);
        let a = document.createElement('a');
        let linkText = document.createTextNode(json.name);
        a.appendChild(linkText);
        a.title = json.name;
        a.href = json.html_url;
        a.target = "_blank";
        cell.appendChild(a);

        // column doc
        cell = row.insertCell(-1);
        if (project[1] === true) {
            cell.setAttribute("class", "text-center");
            let space = document.createTextNode("  ");
            cell.appendChild(space);
            a = document.createElement('a');
            cell.appendChild(space);
            a.innerHTML = "<i class=\"fas fa-book\"></i>";
            a.title = "API documentation for " + json.name;
            a.href = "https://eclipse-keyple.github.io/" + json.name;
            a.target = "_blank";
            cell.appendChild(a);
        }

        // column repos status
        cell = row.insertCell(-1);
        cell.setAttribute("id", "repos-status-" + rowIndex);
        cell.setAttribute("class", "text-center");

        // column latest release
        cell = row.insertCell(-1);
        cell.setAttribute("id", "latest-release-" + rowIndex);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(""));

        // column release date
        cell = row.insertCell(-1);
        cell.setAttribute("id", "release-date-" + rowIndex);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(""));

        // column latest tag
        cell = row.insertCell(-1);
        cell.setAttribute("id", "latest-tag-" + rowIndex);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(""));

        // column issues
        cell = row.insertCell(-1);
        cell.setAttribute("id", "issue-" + rowIndex);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(json.open_issues_count.toString()));
        if (json.open_issues_count > 0) {
            cell.style.backgroundColor = "orange";
        }

        // column branches
        cell = row.insertCell(-1);
        cell.setAttribute("id", "branch-" + rowIndex);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(""));

        // column pull requests
        cell = row.insertCell(-1);
        cell.setAttribute("id", "pull-" + rowIndex);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(""));

        // column forks
        cell = row.insertCell(-1);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(json.forks.toString()));

        // column stars
        cell = row.insertCell(-1);
        cell.setAttribute("class", "text-center");
        cell.appendChild(document.createTextNode(json.stargazers_count.toString()));

        // column updated
        cell = row.insertCell(-1);
        cell.setAttribute("class", "text-center");
        cell.innerHTML = formatDate(json.pushed_at);

        // column created
        cell = row.insertCell(-1);
        cell.setAttribute("class", "text-center");
        cell.innerHTML = formatDate(json.created_at);

        // get complementary data
        await getBranches(rowIndex, owner, project[0]);
        await getPullData(rowIndex, owner, project[0]);
        await getLatestRelease(rowIndex, owner, project[0]);
        await getReleaseDate(rowIndex, owner, project[0]);
        await getLatestTag(rowIndex, owner, project[0]);
        if (project[2] === true) {
            await getStatus(rowIndex, owner, project[0]);
        }

        // debug
        console.log(json.data);
    }

    async function getBranches(rowIndex, owner, repos) {
        const json = await getJsonRepositoryData(repos, "_branches");
        let cell = document.getElementById("branch-" + rowIndex);
        cell.innerHTML = '' + json.length;
        if (json.length > 2) {
            cell.style.backgroundColor = "#FFE0F0";
        }
    }

    async function getPullData(rowIndex, owner, repos) {
        const json = await getJsonRepositoryData(repos, "_pulls");
        let cell = document.getElementById("pull-" + rowIndex);
        if (json.length > 0) {
            cell.style.backgroundColor = "orange";
        }
        cell.innerHTML = json.length;
    }

    async function getLatestRelease(rowIndex, owner, repos) {
        let cell = document.getElementById("latest-release-" + rowIndex);
        try {
            const json = await getJsonRepositoryData(repos, "_releases_latest");
            if (json.tag_name !== undefined) {
                cell.innerHTML = json.tag_name;
            }
        } catch (err) {
        }
    }

    async function getReleaseDate(rowIndex, owner, repos) {
        let cell = document.getElementById("release-date-" + rowIndex);
        try {
            const json = await getJsonRepositoryData(repos, "_releases_latest");
            if (json.tag_name !== undefined) {
                cell.innerHTML = formatDate(json.published_at);
            }
        } catch (err) {
        }
    }

    async function getLatestTag(rowIndex, owner, repos) {
        let cell = document.getElementById("latest-tag-" + rowIndex);
        try {
            const json = await getJsonRepositoryData(repos, "_tags");
            cell.innerHTML = json[0].name;
        } catch (err) {
        }
    }

    async function getStatus(rowIndex, owner, repos) {

        let cell = document.getElementById("repos-status-" + rowIndex);
        let json;
        let branch;

        try {
            json = await getJsonRepositoryData(repos, "_commits_status");
            branch = "main";
        } catch (err) {
        }

        const a = document.createElement('a');
        const linkText = document.createTextNode("\u2b24");
        a.appendChild(linkText);
        a.title = "CI status page";
        a.href = "https://ci.eclipse.org/keyple/job/Keyple/job/" + repos + "/job/" + branch + "/";
        a.target = "_blank";

        switch (json.state) {
            case "error":
            case "failure":
                a.style.color = "red";
                a.title += ": failure";
                break;
            case "pending":
                a.style.color = "orange";
                a.title += ": pending";
                break;
            case "success":
                a.style.color = "green";
                a.title += ": success";
                break;
        }
        cell.appendChild(a);
    }

    function formatDate(dateString) {
        let d = new Date(dateString),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear(),
            hour = '' + d.getHours(),
            min = '' + d.getMinutes(),
            sec = '' + d.getSeconds();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;
        const date = [year, month, day].join('-');

        if (hour.length < 2)
            hour = '0' + hour;
        if (min.length < 2)
            min = '0' + min;
        if (sec.length < 2)
            sec = '0' + sec;

        const time = [hour, min, sec].join(':');

        return '<span data-toggle="tooltip" title="' + date + ' ' + time + '">' + date + '</span>';
    }

    let owner = "eclipse-keyple";

    const lastUpdate = await getJson('datetime');
    const date = new Date(lastUpdate.datetime);

    const offset = date.getTimezoneOffset();
    const isoLocalDate = new Date(date.getTime() - (offset*60*1000));

    const dateOptions = {hour: '2-digit', minute:'2-digit', hour12: false, timeZoneName: 'short'};
    $("#project-dashboard-datetime")[0].innerHTML = isoLocalDate.toISOString().split('T')[0] + ", " + date.toLocaleTimeString('en-EN', dateOptions);

    let projects = await getJson('repository_list');

    // create promises
    const body = document.getElementById("project-dashboard-content");
    let promises = [];
    for (let i = 0; i < projects.length; i++) {
        let promise = getReposData((i + 1).toString(), owner, projects[i])
        promises.push(promise);
    }

    await (async () => {
        await Promise.all(promises)
            .finally(function () {
                $('#project-dashboard-table').DataTable({
                    "lengthMenu": [25, 50, 75, 100],
                    "pageLength": 50,
                    "order": [[11, 'desc']],
                    "oLanguage": {"sSearch": "Filter:"}
                });
                $('.dataTables_length').addClass('bs-select');
                // update the container's width with the real table size
                $('.universal-wrapper').width($('#project-dashboard-table')[0].scrollWidth);
            });
    })();
}
