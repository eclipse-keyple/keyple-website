---
title: Statistics
---

The graph below shows the evolution of the source code for each of the project's components.
The ordinate indicates the total number of lines of code in the repository, and each dot represents a release.

<button id="resetZoom" type="button" class="btn btn-primary">Reset Zoom</button>

<div id="chart"></div>

<div id="chartTooltip" class="alert alert-dark tooltip-statistics" role="alert"></div>

<br>

<table id="datatable-statistics" class="table table-striped display compact nowrap" style="width:100%">
    <thead class="text-center">
        <tr>
            <th scope="col" data-orderable="false"><input type="checkbox" id="checkbox-select-all"></th>
            <th scope="col">Component</th>
            <th scope="col" data-orderable="false">Color</th>
            <th scope="col">Latest release</th>
            <th scope="col">Date</th>
            <th scope="col">Total lines</th>
            <th scope="col">Majors</th>
            <th scope="col">Minors</th>
            <th scope="col">Patches</th>
        </tr>
    </thead>
    <tbody id="datatable-statistics-content" class="text-center">
    </tbody>
</table>

<script type="text/javascript">
document.body.onload = function() {
    loadStatistics();
};
</script>
    