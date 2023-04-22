const result_image = document.getElementById('result_image');
const loading = document.getElementById('loading');

result_image.addEventListener('load', () => {
    loading.style.opacity = '0';
    result_image.style.opacity = '1';
    setTimeout(() => cancelAnimationFrame(animationFrame), 1000);
});

document.getElementById('execute').onclick = () => {
    result_image.style.opacity = '0';
    loading.style.opacity = '1';
    animate();
    var ue_size = document.getElementById('ue_size').value * 1.0;
    var rangeOfPositionMin = document.getElementById('rangeOfPositionMin').value * 1.0;
    var rangeOfPositionMax = document.getElementById('rangeOfPositionMax').value * 1.0;
    var r_UAVBS = document.getElementById('r_UAVBS').value * 1.0;
    var isCounterClockwise = document.getElementById('isCounterClockwise').checked;
    var startAngleOfSpiral = document.getElementById('startAngleOfSpiral').value * 1.0;
    eel.execute(ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, startAngleOfSpiral);
}

eel.expose(executeFinished);
function executeFinished() {
    result_image.src = './images/barchart.png';
}