const result_image = document.getElementById('result_image');
const loading = document.getElementById('loading');
const dataTransferRates = document.getElementById('dataTransferRates');
const dataTransferRates_UE = document.getElementById('dataTransferRates_UE');
const satisfiedRateDOM = document.getElementById('satisfiedRate');

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
    var minDataTransferRateOfUEAcceptable = parseFloat(document.getElementById('minDataTransferRateOfUEAcceptable').value) * 1000000;
    var maxDataTransferRateOfUAVBS = parseFloat(document.getElementById('maxDataTransferRateOfUAVBS').value) * 1000000;
    eel.renderResult({ ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS });
    dataTransferRates.innerHTML = '';
    dataTransferRates_UE.innerHTML = '';
    satisfiedRateDOM.innerHTML = '';
}

eel.expose(finish);
function finish(totalDataTransferRatesOfUAVBSs, satisfiedRate, dataTransferRatesOfUEs) {
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

    dataTransferRatesOfUEs = dataTransferRatesOfUEs.map(arrayOfDataTransferRate => arrayOfDataTransferRate[0]);
    table = '<table>';
    dataTransferRatesOfUEs.forEach((dataTransferRate, index) => {
        table += '<tr>';
        table += `<td>${index + 1}</td>`;
        table += `<td>${parseInt(dataTransferRate)}</td>`;
        table += '</tr>';
    })
    table += '</table>';
    dataTransferRates_UE.innerHTML = table;
    satisfiedRateDOM.innerText = (satisfiedRate * 100).toString();
}

eel.expose(executionError);
function executionError(err) {
    console.error(err)
    loading.style.opacity = '0';
}