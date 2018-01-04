chrome.tabs.getSelected(null, function(tab) {
    var newURL =
        'http://localhost:3000/account/companies/chrome_extension/new?title=' + tab.title +
        '&source_url=' + tab.url;
    chrome.tabs.create({ url: newURL });
});