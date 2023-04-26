import matlab.engine
import os
import eel

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
        eng.main(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['startAngleOfSpiral'], nargout=0)
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        eel.executionError(e.args[0])
    else:
        eel.finish()

eel.init("web")
eel.start("index.html", size=(2000, 1000), port=50505)
eng.quit()