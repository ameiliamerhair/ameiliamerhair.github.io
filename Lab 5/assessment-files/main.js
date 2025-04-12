// functionality for showing/hiding the comments section

const showHideBtn = document.querySelector('.show-hide');
const commentWrapper = document.querySelector('.comment-wrapper');

commentWrapper.style.display = 'none';

showHideBtn.onclick = function() {
  let showHideText = showHideBtn.textContent;
  if(showHideText === 'Show comments') {
    showHideBtn.textContent = 'Hide comments';
    commentWrapper.style.display = 'block';
  } else {
    showHideBtn.textContent = 'Show comments';
    commentWrapper.style.display = 'none';
  }
};

// functionality for adding a new comment via the comments form

const form = document.querySelector('.comment-form');
const nameField = document.querySelector('#name');
const commentField = document.querySelector('#comment');
const list = document.querySelector('.comment-container');

form.onsubmit = function(e) {
  e.preventDefault();
  submitComment();
};

function submitComment() {
  const listItem = document.createElement('li');
  const namePara = document.createElement('p');
  const commentPara = document.createElement('p');
  const nameValue = nameField.value;
  const commentValue = commentField.value;

  namePara.textContent = nameValue;
  commentPara.textContent = commentValue;

  list.appendChild(listItem);
  listItem.appendChild(namePara);
  listItem.appendChild(commentPara);

  nameField.value = '';
  commentField.value = '';
}

// functionality for audio controls
const audioPlayer = document.querySelector("audio");
const playPauseBtn = document.querySelector(".playpause");
const stopBtn = document.querySelector(".stop");
const transcriptBtn = document.querySelector(".transcript");
const timeLabel = document.querySelector(".time");
const transcript = document.querySelector("#transcript");

audioPlayer.removeAttribute("controls");

transcriptBtn.addEventListener("click", function () {
  if (transcript.classList.contains("transcript-hidden")) {
    transcript.classList.remove("transcript-hidden");
    transcript.classList.add("transcript-active");
  } else {
    transcript.classList.remove("transcript-active");
    transcript.classList.add("transcript-hidden");
  }
});

playPauseBtn.addEventListener("click", function () {
  if (audioPlayer.paused) {
    audioPlayer.play();
    playPauseBtn.textContent = "Pause";
  } else {
    audioPlayer.pause();
    playPauseBtn.textContent = "Play";
  }
});

stopBtn.addEventListener("click", function () {
  audioPlayer.pause();
  audioPlayer.currentTime = 0;
  playPauseBtn.textContent = "Play";
});

audioPlayer.addEventListener("timeupdate", function () {
  let minutes = Math.floor(audioPlayer.currentTime / 60);
  let seconds = Math.floor(audioPlayer.currentTime - minutes * 60);
  let minuteValue;
  let secondValue;
  let mediaTime;

  if (minutes < 10) {
    minuteValue = "0" + minutes;
  } else {
    minuteValue = minutes;
  }

  if (seconds < 10) {
    secondValue = "0" + seconds;
  } else {
    secondValue = seconds;
  }

  mediaTime = minuteValue + ":" + secondValue;
  timeLabel.textContent = mediaTime;
});

audioPlayer.addEventListener("ended", function() {
  audioPlayer.currentTime = 0;
  playPauseBtn.textContent = "Play";
});