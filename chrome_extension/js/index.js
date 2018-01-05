const host = 'http://localhost:3000/';
chrome.tabs.getSelected(null, function(tab) {
    var newURL =
        host + 'account/companies/chrome_extensions/new?title=' + tab.title +
        '&source_url=' + tab.url;
    chrome.tabs.create({ url: newURL });
});