import matlab.engine
import os
import json
# import eel
# import numpy as np
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__, static_url_path="/static")
eng = matlab.engine.start_matlab()
eng.cd(os.path.abspath("./matlab"), nargout=0)
port = 8088
CORS(app)


@app.route("/", methods=["POST"])
def hello():
    data = request.json
    # print(data)
    # return jsonify(data)
    try:
        data = eng.emulator(
            matlab.double(data["ue_size"]),
            matlab.double(data["rangeOfPosition"]),
            matlab.double(data["r_UAVBS"]),
            data["minDataTransferRateOfUEAcceptable"] * (10**6),
            data["maxDataTransferRateOfUAVBS"] * (10**6),
            nargout=1,
        )
        return data
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        return e.args[0]


@app.route("/init", methods=["POST"])
def init():
    data = request.json
    try:
        eng.emulator_init(
            matlab.double(data["ue_size"]),
            matlab.double(data["rangeOfPosition"]),
            nargout=0,
        )
        return jsonify({"status": 1})
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        return e.args[0]


@app.route("/ourAlgorithm", methods=["POST"])
def ourAlgorithm():
    data = request.json
    try:
        data = eng.emulator_ourAlgorithm(
            data["minDataTransferRateOfUEAcceptable"] * (10**6),
            data["maxDataTransferRateOfUAVBS"] * (10**6),
            nargout=1,
        )
        return jsonify({"status": 1, "data": json.loads(data)})
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        return e.args[0]

@app.route("/spiralMBSPlacementAlgorithm", methods=["POST"])
def spiralMBSPlacementAlgorithm():
    data = request.json
    try:
        data = eng.emulator_spiralMBSPlacementAlgorithm(
            matlab.double(data["r_UAVBS"]),
            data["minDataTransferRateOfUEAcceptable"] * (10**6),
            data["maxDataTransferRateOfUAVBS"] * (10**6),
            nargout=1,
        )
        return jsonify({"status": 1, "data": json.loads(data)})
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        return e.args[0]

@app.route("/kmeans", methods=["POST"])
def kmeans():
    data = request.json
    try:
        data = eng.emulator_kmeans(
            matlab.double(data["index"]),
            matlab.double(data["k"]),
            data["minDataTransferRateOfUEAcceptable"] * (10**6),
            data["maxDataTransferRateOfUAVBS"] * (10**6),
            nargout=1,
        )
        return jsonify({"status": 1, "data": json.loads(data)})
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        return e.args[0]

@app.route("/random", methods=["POST"])
def random():
    data = request.json
    try:
        data = eng.emulator_random(
            matlab.double(data["rangeOfPosition"]),
            data["minDataTransferRateOfUEAcceptable"] * (10**6),
            data["maxDataTransferRateOfUAVBS"] * (10**6),
            nargout=1,
        )
        return jsonify({"status": 1, "data": json.loads(data)})
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        return e.args[0]

@app.route("/voronoi", methods=["POST"])
def voronoi():
    data = request.json
    try:
        data = eng.emulator_voronoi(
            matlab.double(data["r_UAVBS"]),
            data["minDataTransferRateOfUEAcceptable"] * (10**6),
            data["maxDataTransferRateOfUAVBS"] * (10**6),
            nargout=1,
        )
        return jsonify({"status": 1, "data": json.loads(data)})
    except matlab.engine.MatlabExecutionError as e:
        print(e)
        return e.args[0]
    
if __name__ == "__main__":
    app.run(port=port, debug=True)

# eel.init("web", allowed_extensions=[".js", ".html"])


# else:
#     totalDataTransferRatesOfUAVBSs = np.asarray(data[0]).tolist() # totalDataTransferRatesOfUAVBSs <class matlab.double> to numpy array to list
#     satisfiedRate = data[1]
#     dataTransferRatesOfUEs = np.asarray(data[2]).tolist() # totalDataTransferRatesOfUAVBSs <class matlab.double> to numpy array to list
#     eel.finish(totalDataTransferRatesOfUAVBSs, satisfiedRate, dataTransferRatesOfUEs)


# @eel.expose
# def renderResult(data):
#     for key, value in data.items():
#         try:
#             data[key] = float(value)
#         except ValueError:
#             pass
#     try:
#         data = eng.main(data['ue_size'], matlab.double([[data['rangeOfPositionMin'], data['rangeOfPositionMax']]]), data['r_UAVBS'], data['isCounterClockwise'], data['minDataTransferRateOfUEAcceptable'], data['maxDataTransferRateOfUAVBS'], nargout=3)
#     except matlab.engine.MatlabExecutionError as e:
#         print(e)
#         eel.executionError(e.args[0])
#     else:
#         totalDataTransferRatesOfUAVBSs = np.asarray(data[0]).tolist() # totalDataTransferRatesOfUAVBSs <class matlab.double> to numpy array to list
#         satisfiedRate = data[1]
#         dataTransferRatesOfUEs = np.asarray(data[2]).tolist() # totalDataTransferRatesOfUAVBSs <class matlab.double> to numpy array to list
#         eel.finish(totalDataTransferRatesOfUAVBSs, satisfiedRate, dataTransferRatesOfUEs)

# eel.init("web")
# eel.start("index.html", size=(2000, 1000), port=50505, shutdown_delay=5)
# print('quit')
# eng.quit()
