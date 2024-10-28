document.getElementById("start").addEventListener("click", () => {
    const interval = parseInt(document.getElementById("interval").value, 10) * 1000;
    if (!isNaN(interval) && interval > 0) {
        chrome.runtime.sendMessage({ type: "start", interval: interval }, (response) => {
            console.log(response.status);
        });
    } else {
        alert("Please enter a valid number greater than 0.");
    }
});

document.getElementById("stop").addEventListener("click", () => {
    chrome.runtime.sendMessage({ type: "stop" }, (response) => {
        console.log(response.status);
    });
});

chrome.runtime.sendMessage({ type: "getInterval" }, (response) => {
    document.getElementById("interval").value = response.interval / 1000;
});
