let refreshIntervalId;
let refreshInterval = 10000; // default: 10 seconds

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.type === "start") {
        clearInterval(refreshIntervalId); // Clear previous interval if any
        refreshIntervalId = setInterval(() => {
            chrome.tabs.reload();
        }, message.interval);
        sendResponse({ status: "started" });
    } else if (message.type === "stop") {
        clearInterval(refreshIntervalId);
        sendResponse({ status: "stopped" });
    } else if (message.type === "getInterval") {
        sendResponse({ interval: refreshInterval });
    }
});
