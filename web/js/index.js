const result_image = document.getElementById('result_image');
const UEPosition_image = document.getElementById('UEPosition_image');
const loading = document.getElementById('loading');

var state = 0;
var data = {};

UEPosition_image.addEventListener('load', () => {
    if (state == 0) {
        result_image.style.opacity = '0';
        UEPosition_image.style.opacity = '1';
        loading.style.opacity = '1';
        state = 1;
    }
});

result_image.addEventListener('load', () => {
    result_image.style.opacity = '1';
    UEPosition_image.style.opacity = '0';
    loading.style.opacity = '0';
    state = 2;
});

document.getElementById('execute').onclick = () => {
    state = 0;
    result_image.style.opacity = '0';
    UEPosition_image.style.opacity = '0';
    loading.style.opacity = '1';
    var ue_size = parseInt(document.getElementById('ue_size').value);
    var rangeOfPositionMin = parseInt(document.getElementById('rangeOfPositionMin').value);
    var rangeOfPositionMax = parseInt(document.getElementById('rangeOfPositionMax').value);
    var r_UAVBS = parseInt(document.getElementById('r_UAVBS').value);
    var isCounterClockwise = Boolean(document.getElementById('isCounterClockwise').checked);
    var startAngleOfSpiral = parseInt(document.getElementById('startAngleOfSpiral').value);
    data = { ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, startAngleOfSpiral };
    eel.renderUEPosition(data);
}

eel.expose(renderUEFinish);
function renderUEFinish() {
    UEPosition_image.src = '/images/UE.jpg';
    eel.renderResult(data);
}

eel.expose(renderResultFinish);
function renderResultFinish() {
    result_image.src = '/images/result.jpg';
}

eel.expose(executionError);
function executionError(err) {
    console.error(err)
    loading.style.opacity = '0';
    state = 0;
}