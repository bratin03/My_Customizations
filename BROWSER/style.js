

const editableText= document.getElementById('editable-text');

if(localStorage.getItem('savedText')){
  editableText.textContent=localStorage.getItem('savedText');
}


editableText.addEventListener('input', function(){

  localStorage.setItem('savedText',this.textContent);
})

// Define an array of colors you want to cycle through
const colors = [
  'rgb(33, 182, 168)', // Teal
  'rgb(24, 154, 180)', // Blue
  'rgb(75, 74, 106)'   // Gray
];

// Function to change the background color randomly
function changeBackgroundColor() {
  const randomIndex = Math.floor(Math.random() * colors.length);
  const color = colors[randomIndex];
  document.documentElement.style.setProperty('--body-color', color);
}

// Set interval to change background color every 5 seconds (5000 milliseconds)
setInterval(changeBackgroundColor, 5000);
