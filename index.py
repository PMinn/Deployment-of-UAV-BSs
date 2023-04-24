import matlab.engine
import os
import eel
import time

eel.init("web", allowed_extensions=[".js", ".html"])
eng = matlab.engine.start_matlab() # type: ignore
eng.cd(os.path.abspath('./matlab'), nargout=0)


@eel.expose
def renderUEPosition(data):
    for key, value in data.items():
        try:
            data[key] = float(value)
        except ValueError:
            pass
    a = eng.renderUEPosition(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['startAngleOfSpiral'])
    eel.renderUEFinish() # type: ignore

@eel.expose
def renderResult(data):
    for key, value in data.items():
        try:
            data[key] = float(value)
        except ValueError:
            pass
    a = eng.renderResult(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['startAngleOfSpiral'])
    eel.renderResultFinish() # type: ignore

eel.init("web")
eel.start("index.html", size=(2000, 1000), port=50505)