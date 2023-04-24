import matlab.engine
import os
import eel
import io
out = io.StringIO()
err = io.StringIO()

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
    try:
        eng.renderUEPosition(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['startAngleOfSpiral'], nargout=0)
    except matlab.engine.MatlabExecutionError as e:
        eel.executionError(e)
        print(e)
    else:
        eel.renderUEFinish() # type: ignore

@eel.expose
def renderResult(data):
    for key, value in data.items():
        try:
            data[key] = float(value)
        except ValueError:
            pass
    try:
        eng.renderResult(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['startAngleOfSpiral'], nargout=0)
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        eel.executionError(e.args[0])
    else:
        eel.renderResultFinish() # type: ignore

eel.init("web")
eel.start("index.html", size=(2000, 1000), port=50505)
eng.quit()