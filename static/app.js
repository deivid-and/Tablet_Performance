document.addEventListener("DOMContentLoaded", function() {
    var socket = io();

    socket.on('connect', function() {
        console.log('Connected to server');
    });

    socket.on('disconnect', function() {
        console.log('Disconnected from server');
    });

    socket.on('device_list', function(data) {
        const outputDiv = document.getElementById('output');
        outputDiv.innerHTML = ''; // Clear previous output
        const message = document.createElement('p');
        message.textContent = data.output;
        outputDiv.appendChild(message);
    });

    function postAction(url) {
        showLoader(true);
        console.log(`Sending POST request to: ${url}`);
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Cache-Control': 'no-cache, no-store, must-revalidate',
                'Pragma': 'no-cache',
                'Expires': '0'
            }
        })
        .then(response => response.json())
        .then(data => {
            showLoader(false);
            console.log('Response received:', data);
            const outputDiv = document.getElementById('output');
            const message = document.createElement('pre'); // Use <pre> for preserving formatting
            message.className = data.status === 'success' ? 'success' : 'error';
            message.textContent = data.output; // Show the full output
            outputDiv.appendChild(message);
        })
        .catch(error => {
            showLoader(false);
            console.error('Error:', error);
            const outputDiv = document.getElementById('output');
            const message = document.createElement('p');
            message.className = 'error';
            message.textContent = 'An error occurred while executing the script.';
            outputDiv.appendChild(message);
        });
    }

    function showLoader(show) {
        const loader = document.getElementById('loader');
        loader.style.display = show ? 'block' : 'none';
    }

    document.querySelectorAll('button[data-action]').forEach(button => {
        button.addEventListener('click', function() {
            postAction(button.getAttribute('data-action'));
        });
    });

    document.getElementById('clearMessages').addEventListener('click', function() {
        const outputDiv = document.getElementById('output');
        outputDiv.innerHTML = ''; // Clear all messages
    });

    // Fetch and update metrics
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
            card.className = 'card';
            card.innerHTML = `
                <h2>${key.toUpperCase()}</h2>
                <p>Usage: ${value.usage || value.used || value.sent || value.percentage}%</p>
                <p>Top Process: ${value.top_process.name} (PID: ${value.top_process.pid})</p>
            `;
            dashboard.appendChild(card);
        }
    }

    // Fetch metrics every 10 seconds
    setInterval(fetchMetrics, 10000);

    // Initial fetch of metrics
    fetchMetrics();

});
