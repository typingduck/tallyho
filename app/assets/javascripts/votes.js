
window.addEventListener("load", function() {
  var name_input = document.getElementById('v4p-proposal-search');
  if (name_input) {
    window.hinterXHR = new XMLHttpRequest();

    new autoComplete({
      onSelect: onSelect,
      minChars: 1,
      renderItem: renderItem,
      selector: name_input,
      source: findMatches
    });

  }
});

function renderItem(item, search) {
 search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
 var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
 return '<div class="autocomplete-suggestion" data-id="' + item.id + '" data-val="' + item.name + '">' + item.name.replace(re, "<b>$1</b>") + '</div>';
}

function onSelect(_, _, item) {
  var field = document.getElementById('v4p-proposal-search-selected');
  var cid = item.getAttribute('data-id')
  field.value = cid
  var form = document.getElementById('v4p-proposal-form');
  form.submit()
}

function findMatches(term, handler) {
  // abort any pending requests
  window.hinterXHR.abort();

  window.hinterXHR.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var response = JSON.parse( this.responseText ); 
      handler(response)
    }
  };

  window.hinterXHR.open("GET", "/search?name=" + term, true);
  window.hinterXHR.send()
}
