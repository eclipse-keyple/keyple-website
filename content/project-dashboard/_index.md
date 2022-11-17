---
title: Overall project dashboard
subtitle: 
summary:
aliases: ["/projects-dashboard/"]
---

{{% callout note %}}
The status of the projects is checked every hour, but the dashboard is only refreshed if the status of at least one of 
the projects has changed.

Last dashboard refresh date: **<span id="project-dashboard-datetime"></span>**

When displayed, icons in columns **Doc** and **Status** are clickable and lead respectively to the **API documentation**
and the **Jenkins CI status page**.
{{% /callout %}}

<table id="project-dashboard-table" class="table table-striped" data-sort-name="updated" data-sort-order="desc">
    <thead>
    <tr>
        <th scope="col">Repository</th>
        <th scope="col" class="text-center">Doc</th>
        <th scope="col" class="text-center">Status</th>
        <th scope="col" class="text-center">Latest release</th>
        <th scope="col" class="text-center">Date</th>
        <th scope="col" class="text-center">Latest tag</th>
        <th scope="col" class="text-center">Issues</th>
        <th scope="col" class="text-center">Branches</th>
        <th scope="col" class="text-center">PRs</th>
        <th scope="col" class="text-center">Forks</th>
        <th scope="col" class="text-center">Stars</th>
        <th scope="col" class="text-center" data-field="updated">Last update</th>
        <th scope="col" class="text-center">Created</th>
    </tr>
    </thead>
    <tbody id="project-dashboard-content">
    </tbody>
</table>
<script type="text/javascript">
document.body.onload = function() {
    loadProjectDashboard();
};
</script>
