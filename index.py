import matlab.engine
import os
import eel
import shutil

eel.init('web', allowed_extensions=['.js', '.html'])
eng = matlab.engine.start_matlab()
eng.cd(os.path.abspath('./matlab'), nargout=0)


@eel.expose
def execute(ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, startAngleOfSpiral):
    ue_size *= 1.0
    rangeOfPositionMin *= 1.0
    rangeOfPositionMax *= 1.0
    r_UAVBS *= 1.0
    startAngleOfSpiral *= 1.0
    UAVBSsSet = eng.index(ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, startAngleOfSpiral)
    shutil.move("./matlab/out/barchart.png" , "./web/images/barchart.png")
    eel.executeFinished()


eel.init('web')
eel.start('index.html', size=(1000,1000))