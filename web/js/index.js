const result_image = document.getElementById('result_image');
const loading = document.getElementById('loading');
const dataTransferRates = document.getElementById('dataTransferRates');

result_image.addEventListener('load', () => {
    result_image.style.opacity = '1';
    loading.style.opacity = '0';
});

document.getElementById('execute').onclick = () => {
    result_image.style.opacity = '0';
    loading.style.opacity = '1';
    var ue_size = parseInt(document.getElementById('ue_size').value);
    var rangeOfPositionMin = parseInt(document.getElementById('rangeOfPositionMin').value);
    var rangeOfPositionMax = parseInt(document.getElementById('rangeOfPositionMax').value);
    var r_UAVBS = parseInt(document.getElementById('r_UAVBS').value);
    var isCounterClockwise = Boolean(document.getElementById('isCounterClockwise').checked);
    var startAngleOfSpiral = parseInt(document.getElementById('startAngleOfSpiral').value);
    eel.renderResult({ ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, startAngleOfSpiral });
    dataTransferRates.innerHTML = '';
}

eel.expose(finish);
function finish(totalDataTransferRatesOfUAVBSs) {
    console.log(totalDataTransferRatesOfUAVBSs)
    result_image.src = '/images/barchart.jpg';

    totalDataTransferRatesOfUAVBSs = totalDataTransferRatesOfUAVBSs.map(arrayOfDataTransferRate => arrayOfDataTransferRate[0]);
    var table = '<table>';
    totalDataTransferRatesOfUAVBSs.forEach((dataTransferRate, index) => {
        table += '<tr>';
        table += `<td>${index + 1}</td>`;
        table += `<td>${parseInt(dataTransferRate)}</td>`;
        table += '</tr>';
    })
    table += '</table>';
    dataTransferRates.innerHTML = table;
}

eel.expose(executionError);
function executionError(err) {
    console.error(err)
    loading.style.opacity = '0';
}