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
    var ue_size = parseInt(document.getElementById('ue_size').value);
    var rangeOfPositionMin = parseInt(document.getElementById('rangeOfPositionMin').value);
    var rangeOfPositionMax = parseInt(document.getElementById('rangeOfPositionMax').value);
    var r_UAVBS = parseInt(document.getElementById('r_UAVBS').value);
    var isCounterClockwise = Boolean(document.getElementById('isCounterClockwise').checked);
    var startAngleOfSpiral = parseInt(document.getElementById('startAngleOfSpiral').value);
    eel.execute({ ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, startAngleOfSpiral });
}

eel.expose(executeFinished);
function executeFinished() {
    result_image.src = './images/barchart.png';
}