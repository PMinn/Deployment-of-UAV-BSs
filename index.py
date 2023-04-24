import matlab.engine
import os
import eel

eel.init("web", allowed_extensions=[".js", ".html"])
eng = matlab.engine.start_matlab() # type: ignore
eng.cd(os.path.abspath('./matlab'), nargout=0)


@eel.expose
def execute(data):
    for key, value in data.items():
        try:
            data[key] = float(value)
        except ValueError:
            pass
    UAVBSsSet = eng.main(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['startAngleOfSpiral'])
    eel.executeFinished() # type: ignore

@eel.expose
def on_close():
    print("視窗已關閉")
    # 在這裡進行需要的操作

eel.init("web")
eel.start("index.html", size=(2000, 1000), port=50505)