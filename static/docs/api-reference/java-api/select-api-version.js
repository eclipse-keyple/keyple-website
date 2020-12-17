function selectVersion() {
  var version = document.getElementById('version_selection').value
  var req = new XMLHttpRequest;
  req.open('GET', 'list-' + version + '.json', true);
  req.onload  = function() {
    var jsonResponse = JSON.parse(req.responseText);
    var html = '';
    for (const [key, value] of Object.entries(jsonResponse)) {
      html += '<li><a href="' + key + '/' + version + '/index.html" target="_blank">JavaDoc for ' + value + '</a></li>';
    }
    document.getElementById('module_list').innerHTML = html;
  };
  req.send(null);
}

selectVersion()