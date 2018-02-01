const HOST = 'http://salesassistant.pp.ua/';
chrome.tabs.getSelected(null, function(tab) {
    var newURL =
        HOST + 'account/companies/chrome_extensions/new?title=' + tab.title +
        '&source_url=' + tab.url;
    chrome.tabs.create({ url: newURL });
});