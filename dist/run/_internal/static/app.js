document.addEventListener('DOMContentLoaded', () => {
    fetchMetrics();

    document.getElementById('optimizeBtn').addEventListener('click', () => {
        runScript('optimize');
    });

    document.getElementById('resetBtn').addEventListener('click', () => {
        runScript('reset');
    });
});

function fetchMetrics() {
    fetch('/metrics')
        .then(response => response.json())
        .then(data => updateDashboard(data))
        .catch(error => console.error('Error fetching metrics:', error));
}

function updateDashboard(metrics) {
    const dashboard = document.getElementById('dashboard');
    dashboard.innerHTML = '';

    for (const [key, value] of Object.entries(metrics)) {
        const card = document.createElement('div');
        card.className = 'bg-white p-4 rounded shadow';
        card.innerHTML = `
            <h2 class="text-xl font-bold mb-2">${key.toUpperCase()}</h2>
            <p>Usage: ${value.usage || value.used || value.sent || value.percentage}%</p>
            <p>Top Process: ${value.top_process.name} (PID: ${value.top_process.pid})</p>
        `;
        dashboard.appendChild(card);
    }
}

function runScript(scriptName) {
    fetch(`/run-script/${scriptName}`, { method: 'POST' })
        .then(response => response.json())
        .then(data => alert(data.message))
        .catch(error => console.error('Error running script:', error));
}
