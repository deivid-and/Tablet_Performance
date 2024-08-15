document.addEventListener("DOMContentLoaded", function() {
    var socket = io();

    socket.on('connect', function() {
        console.log('Connected to server');
    });

    socket.on('disconnect', function() {
        console.log('Disconnected from server');
    });

    socket.on('device_list', function(data) {
        const connectedDevicesDiv = document.getElementById('connectedDevices');
        connectedDevicesDiv.innerHTML = '';
        const message = document.createElement('p');
        message.textContent = data.output;
        connectedDevicesDiv.appendChild(message);
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

    function fetchConnectedDevices() {
        fetch('/list_devices', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json())
        .then(data => {
            const deviceStatusDiv = document.getElementById('device-status');
            const statusIcon = deviceStatusDiv.querySelector('.status-icon');
            const statusText = deviceStatusDiv.querySelector('.status-text');

            if (data.output.includes("device") && data.output.trim().split('\n').length > 1) {
                deviceStatusDiv.classList.add('connected');
                statusIcon.textContent = '✅'; 
                statusText.textContent = `Device Connected: ${data.output.split('\n')[1].trim()}`; // Display the device ID
            } else {
                deviceStatusDiv.classList.remove('connected');
                statusIcon.textContent = '❌'; 
                statusText.textContent = "No Device Connected";
            }
        })
        .catch(error => {
            console.error('Error fetching connected devices:', error);
        });
    }

    // Fetch connected devices every 2 seconds
    setInterval(fetchConnectedDevices, 2000);

    // Initial fetch of connected devices
    fetchConnectedDevices();
});
