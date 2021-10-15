---
title: Overall projects dashboard
subtitle: 
summary: 
---

{{% alert note %}}
Last project status update: **<span id="projects-dashboard-datetime"></span>**

When displayed, icons in columns **Doc** and **Status** are clickable and lead respectively to the **API documentation** and the **Jenkins CI status page**.
{{% /alert %}}

<table id="projects-dashboard-table" class="table table-striped" data-sort-name="updated" data-sort-order="desc">
    <thead>
    <tr>
        <th scope="col">Repository</th>
        <th scope="col">Doc</th>
        <th scope="col">Status</th>
        <th scope="col">Latest release</th>
        <th scope="col">Latest tag</th>
        <th scope="col" data-field="updated">Last update</th>
        <th scope="col">Issues</th>
        <th scope="col">Branches</th>
        <th scope="col">Pull requests</th>
        <th scope="col">Forks</th>
        <th scope="col">Stars</th>
        <th scope="col">Created</th>
    </tr>
    </thead>
    <tbody id="projects-dashboard-content">
    </tbody>
</table>
<script type="text/javascript">
document.body.onload = function() {
    loadProjectsDashboard();
};
</script>