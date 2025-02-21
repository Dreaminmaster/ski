// 初始化元素
const taskNameInput = document.getElementById('task-name');
const taskDescriptionInput = document.getElementById('task-description');
const startTaskButton = document.getElementById('start-task');
const studyTimeSelect = document.getElementById('study-time');
const breakTimeSelect = document.getElementById('break-time');
const startPomodoroButton = document.getElementById('start-pomodoro');
const pausePomodoroButton = document.getElementById('pause-pomodoro');
const resetPomodoroButton = document.getElementById('reset-pomodoro');
const skiingSceneSelect = document.getElementById('skiing-scene');
const skiingTypeSelect = document.getElementById('skiing-type');
const animationSizeInput = document.getElementById('animation-size');
const animationOpacityInput = document.getElementById('animation-opacity');
const closeAnimationButton = document.getElementById('close-animation');
const timerDisplay = document.getElementById('timer-display');
const skiingAnimation = document.getElementById('skiing-animation');
const taskHistory = document.getElementById('task-history');
const fullscreenButton = document.getElementById('fullscreen-button');
const alarmSound = document.getElementById('alarm-sound');

// 填充学习时长和休息时长选项
for (let i = 10; i <= 120; i += 5) {
    const option = document.createElement('option');
    option.value = i;
    option.textContent = i;
    studyTimeSelect.appendChild(option);
}

for (let i = 2; i <= 30; i += 2) {
    const option = document.createElement('option');
    option.value = i;
    option.textContent = i;
    breakTimeSelect.appendChild(option);
}

// 番茄钟相关变量
let timer;
let isPaused = false;
let isStudyTime = true;
let totalTime;

// 初始化滑雪动画
function initSkiingAnimation() {
    const scene = skiingSceneSelect.value;
    const type = skiingTypeSelect.value;
    const size = animationSizeInput.value;
    const opacity = animationOpacityInput.value;

    // 使用 Canvas 或 WebGL 实现动画，这里简单示例
    skiingAnimation.style.width = `${size}px`;
    skiingAnimation.style.opacity = opacity;
    skiingAnimation.innerHTML = `<p>${scene} - ${type}</p>`;
}

// 开始番茄钟
function startPomodoro() {
    const studyTime = parseInt(studyTimeSelect.value) * 60;
    const breakTime = parseInt(breakTimeSelect.value) * 60;
    totalTime = isStudyTime? studyTime : breakTime;
    isPaused = false;

    timer = setInterval(() => {
        if (!isPaused) {
            totalTime--;
            const minutes = Math.floor(totalTime / 60);
            const seconds = totalTime % 60;
            timerDisplay.textContent = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;

            if (totalTime === 0) {
                clearInterval(timer);
                alarmSound.play();
                if (isStudyTime) {
                    // 学习时间结束，进入休息时间
                    isStudyTime = false;
                    // 滑雪者庆祝动作
                    skiingAnimation.innerHTML = '<p>庆祝！</p>';
                } else {
                    // 休息时间结束，进入学习时间
                    isStudyTime = true;
                }
                startPomodoro();
            }
        }
    }, 1000);
}

// 暂停番茄钟
function pausePomodoro() {
    isPaused =!isPaused;
    // 滑雪者暂停动作
    if (isPaused) {
        skiingAnimation.innerHTML = '<p>暂停</p>';
    } else {
        initSkiingAnimation();
    }
}

// 重置番茄钟
function resetPomodoro() {
    clearInterval(timer);
    isPaused = false;
    isStudyTime = true;
    timerDisplay.textContent = '00:00:00';
    initSkiingAnimation();
}

// 关闭动画
function closeAnimation() {
    skiingAnimation.style.display = 'none';
}

// 全屏模式
function enterFullscreen() {
    const elem = document.documentElement;
    if (elem.requestFullscreen) {
        elem.requestFullscreen();
    } else if (elem.mozRequestFullScreen) { /* Firefox */
        elem.mozRequestFullScreen();
    } else if (elem.webkitRequestFullscreen) { /* Chrome, Safari & Opera */
        elem.webkitRequestFullscreen();
    } else if (elem.msRequestFullscreen) { /* IE/Edge */
        elem.msRequestFullscreen();
    }
}

// 事件监听
startPomodoroButton.addEventListener('click', startPomodoro);
pausePomodoroButton.addEventListener('click', pausePomodoro);
resetPomodoroButton.addEventListener('click', resetPomodoro);
skiingSceneSelect.addEventListener('change', initSkiingAnimation);
skiingTypeSelect.addEventListener('change', initSkiingAnimation);
animationSizeInput.addEventListener('input', initSkiingAnimation);
animationOpacityInput.addEventListener('input', initSkiingAnimation);
closeAnimationButton.addEventListener('click', closeAnimation);
fullscreenButton.addEventListener('click', enterFullscreen);

// 初始化滑雪动画
initSkiingAnimation();