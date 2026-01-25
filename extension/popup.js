/* ===============================
   🔹 CONFIGURATION DATA
   =============================== */

const qualityOptions = {
  video: [
    { value: 'best', text: 'Best Quality (Max)' },
    { value: 'bestMkv', text: 'Best Quality (MKV)' },
    { value: '2160', text: '4K (2160p)' },
    { value: '1440', text: '2K (1440p)' },
    { value: '1080', text: 'Full HD (1080p)' },
    { value: '720', text: 'HD (720p)' },
    { value: '480', text: 'SD (480p)' },
    { value: '360', text: 'Low (360p)' },
  ],
  audio: [
    { value: 'best', text: 'Best Audio (FLAC)' },
    { value: '320', text: 'Very High (320 kbps)' },
    { value: '256', text: 'High (256 kbps)' },
    { value: '192', text: 'Medium (192 kbps)' },
    { value: '128', text: 'Low (128 kbps)' },
    { value: '128', text: 'Very Low (64 kbps)' },
  ],
  butPhone: [
    { value: 'best', text: 'Best (H.264)' },
    { value: '320', text: 'High (320p-mp4)' },
    { value: '240', text: 'Medium (240p-mp4)' },
    { value: '144', text: 'Low (144p-3gp)' },
  ],
};

/* ===============================
   🔹 HELPER FUNCTIONS
   =============================== */


function updateQualityDropdown() {
  const mode = document.getElementById('mode').value;
  const qualitySelect = document.getElementById('quality');

  
  qualitySelect.innerHTML = '';

  
  const options = qualityOptions[mode];
  options.forEach(opt => {
    const optionElement = document.createElement('option');
    optionElement.value = opt.value;
    optionElement.innerText = opt.text;
    qualitySelect.appendChild(optionElement);
  });
}

/* ===============================
   🔹 EVENT LISTENERS
   =============================== */


document.addEventListener('DOMContentLoaded', async () => {
  
  updateQualityDropdown();

  
  document
    .getElementById('mode')
    .addEventListener('change', updateQualityDropdown);

  
  try {
    const [tab] = await chrome.tabs.query({
      active: true,
      currentWindow: true,
    });

    if (!tab || !tab.url) return;

    let videoId = null;

    if (tab.url.includes('youtube.com/watch')) {
      
      const urlObj = new URL(tab.url);
      videoId = urlObj.searchParams.get('v');
    }
    
    else if (tab.url.includes('youtube.com/watch')) {
      const urlObj = new URL(tab.url);
      videoId = urlObj.searchParams.get('v');
    }
    
    else if (tab.url.includes('youtu.be/')) {
      videoId = tab.url.split('youtu.be/')[1].split('?')[0];
    }
    
    else if (tab.url.includes('youtube.com/shorts/')) {
      videoId = tab.url.split('shorts/')[1].split('?')[0];
    }

    
    if (videoId) {
      
      const shareUrl = `https://youtu.be/${videoId}`; // Standard Share URL is often safer
      document.getElementById('url').value = shareUrl;
    } else if (
      tab.url.includes('youtube.com') ||
      tab.url.includes('youtu.be')
    ) {
      
      document.getElementById('url').value = tab.url;
    }
  } catch (err) {
    console.error('Auto URL detect failed:', err);
  }
});

/* ===============================
   🔹 DOWNLOAD BUTTON LOGIC
   =============================== */
document.getElementById('download').onclick = async () => {
  const urlInput = document.getElementById('url');
  const modeInput = document.getElementById('mode');
  const qualityInput = document.getElementById('quality');
  const status = document.getElementById('status');
  const btn = document.getElementById('download');

  const url = urlInput.value;
  const mode = modeInput.value;
  const quality = qualityInput.value;

  
  if (!url) {
    status.innerText = "Enter Youtube Link ❗";
    status.style.color = 'red';
    return;
  }

  
  status.innerText = 'Connecting to Agent...';
  status.style.color = 'black';

  btn.innerText = 'Downloading... ⏳';
  btn.classList.add('processing'); 
  btn.disabled = true; 

  try {
    
    await fetch('http://localhost:9000/download', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ url, mode, quality }),
    });

    
    status.innerText = 'Download Started ✔️';
    status.style.color = 'green';

    btn.innerText = 'Started ✔';
    btn.classList.remove('processing');
    btn.classList.add('success'); 
  } catch (err) {
    
    status.innerText = 'Agent Error! (Check PowerShell) ❌';
    status.style.color = 'red';

    
    btn.innerText = 'Try Again';
    btn.classList.remove('processing');
    btn.disabled = false;
    console.error(err);
  }
};
