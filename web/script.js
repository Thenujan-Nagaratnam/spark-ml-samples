async function classifyLyrics() {
    const input = document.getElementById("lyricsInput").value;
  
    const response = await fetch("http://localhost:9090/lyrics/predict", {
      method: "POST",
      headers: { "Content-Type": "text/plain" },
      body: input
    });
  
    const result = await response.json(); // Your Spring Boot must return JSON with label & score
  
    const ctx = document.getElementById('resultChart').getContext('2d');
    new Chart(ctx, {
      type: 'bar', // or 'pie'
      data: {
        labels: Object.keys(result),
        datasets: [{
          label: 'Prediction Scores',
          data: Object.values(result),
          backgroundColor: ['rgba(75,192,192,0.4)', 'rgba(255,99,132,0.4)', 'rgba(153,102,255,0.4)']
        }]
      }
    });
  }
  