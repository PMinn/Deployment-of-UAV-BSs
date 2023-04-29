import matlab.engine
import os
import eel
import numpy as np

eel.init("web", allowed_extensions=[".js", ".html"])
eng = matlab.engine.start_matlab()
eng.cd(os.path.abspath('./matlab'), nargout=0)


@eel.expose
def renderResult(data):
    for key, value in data.items():
        try:
            data[key] = float(value)
        except ValueError:
            pass
    try:
        totalDataTransferRatesOfUAVBSs = eng.main(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['startAngleOfSpiral'], nargout=1)
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        eel.executionError(e.args[0])
    else:
        totalDataTransferRatesOfUAVBSs = np.asarray(totalDataTransferRatesOfUAVBSs).tolist() # totalDataTransferRatesOfUAVBSs <class matlab.double> to numpy array to list
        eel.finish(totalDataTransferRatesOfUAVBSs)

eel.init("web")
eel.start("index.html", size=(2000, 1000), port=50505, shutdown_delay=5)
print('quit')
eng.quit()
