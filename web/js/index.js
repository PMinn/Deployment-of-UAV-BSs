document.getElementById('execute').onclick = () => {
    document.getElementById('result_image').style.opacity = '0';
    document.getElementById('loading').style.opacity = '1';
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
    document.getElementById('result_image').src = '../matlab//out/barchart.jpg';
    document.getElementById('result_image').style.opacity = '1';
    document.getElementById('loading').style.opacity = '0';
    setTimeout(() => cancelAnimationFrame(animationFrame), 300);
}