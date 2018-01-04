var source_url;
chrome.tabs.getSelected(null, function(tab) {
    source_url = tab.url;
    var newURL = 'http://localhost:3000/account/companies/chrome_extension/new?source_url=' + source_url;
    chrome.tabs.create({ url: newURL });
});