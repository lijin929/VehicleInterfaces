# file:///D:/Program%20Files/OpenModelica1.16.2-64bit/share/doc/omc/OpenModelicaUsersGuide/ompython.html#ompython-openmodelica-python-interface
from OMPython import ModelicaSystem
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import util



# 按间距中的绿色按钮以运行脚本。
if __name__ == '__main__':
    # VehicleInterfaces模型库的路径
    LibPath = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/package.mo"
    modelName = "VehicleInterfaces.Task.TCmatchingWithFrontdrive"
    # 加载VehicleInterfaces模型库，并选择导入的model
    mod = ModelicaSystem(fileName=LibPath,
                         modelName=modelName)
    # BuildModel模型新建或有修改，编译一次即可，后续参数、仿真配置等的修改无需重新编译
    # mod.buildModel()
    '''
    获取参数
    getQuantities()
    getContinuous()
    getInputs()
    getOutputs()
    getParameters()
    getSimulationOptions()
    getSolutions()
    '''
    # quantities = mod.getQuantities()
    parameters = mod.getParameters()
    # continuous = mod.getContinuous()
    # inputs = mod.getInputs()


    # 设置参数
    engine = np.array([[900, 1903],
                       [1000, 2138],
                       [1100, 2281],
                       [1200, 2282],
                       [1300, 2281],
                       [1500, 2282],
                       [1700, 2041],
                       [1900, 1826],
                       [2050, 0]])
    front_drive = [1.0, 1.0]
    diameter = 0.43
    oilDensity = 860
    lambda_table = np.array([[0, 1.93, 0, 6.23],
                            [0.1, 1.89, 19, 6.34],
                            [0.2, 1.8, 36, 6.42],
                            [0.3, 1.71, 51, 6.48],
                            [0.40, 1.58, 63, 6.5],
                            [0.50, 1.43, 72, 6.395],
                            [0.60, 1.35, 81, 5.636],
                            [0.65, 1.27, 83, 5.401],
                            [0.7, 1.23, 86, 4.951],
                            [0.75, 1.17, 88, 4.547],
                            [0.8, 1.12, 89, 4.117],
                            [0.85, 1.05, 89, 3.686],
                            [0.86, 1.05, 90, 3.616],
                            [0.89, 1, 89, 3.208],
                            [0.9, 1, 90, 3.059],
                            [0.95, 1, 95, 1.733],
                            [1, 1, 100, 0.016]])

    mod.setParameters("diameter=%s" % diameter)
    mod.setParameters("oilDensity=%s" % oilDensity)
    util.set_parameter(mod, "frontDrive", front_drive)
    util.set_parameter(mod, "lambdaTable", lambda_table)
    util.set_parameter(mod, "ne", engine)
    util.set_parameter(mod, "timeTable.table", np.array([[i, i + 1] for i in range(len(lambda_table))]))
    # mod.setContinuous()
    # 仿真求解设置
    # mod.getSimulationOptions()
    table_size = len(lambda_table)
    mod.setSimulationOptions(["stopTime=%s" % (table_size - 1),
                              "tolerance=0.1",
                              "stepSize=1",
                              "solver=dassl"])
    # mod.setSimulationOptions(["stopTime=%s" % table_size,
    #                           "numberOfIntervals=%s" % (table_size+1)])
    # mod.getLinearizationOptions()
    # 开始计算
    # mod.simulate()
    # mod.simulate(resultfile="tmpbouncingBall.mat")
    # mod.simulate(simflags="-noRootFinding -noEquidistantOutputFrequency=1 -initialStepSize=1 -maxStepSize=1")
    mod.simulate(simflags="-noEventEmit")
    # solutions = mod.getSolutions()
    output = pd.DataFrame({
        "time": mod.getSolutions("time")[0],
        "np": mod.getSolutions("npCowork")[0],
        "Tp": mod.getSolutions("TpCowork")[0],
        "nt": mod.getSolutions("ntCowork")[0],
        "Tt": mod.getSolutions("TtCowork")[0],
    })
    output["Pp"] = output.np * output.Tp / 9550
    output["Pt"] = output.nt * output.Tt / 9550
    output["eff"] = output.Pt / output.Pp
    output["loss"] = output.Pp - output.Pt
    Tp = pd.DataFrame(
        [mod.getSolutions("Tp[%s]" % (i + 1))[0] for i in range(len(engine))],
        columns=["i=%s" % mod.getParameters('table[%s,1]' % (i + 1))[0] for i in range(table_size)]
    )
    Tp["ne"] = engine[:, 0]


    #绘制共同工作特性曲线
    plt.figure()
    plt.plot(engine[:, 0], engine[:, 1], label="engine")
    plt.plot(output.np, output.Tp, linewidth=3, color="red", label="cowork")
    for i in range(table_size):
        label = "i=%s" % mod.getParameters('table[%s,1]' % (i + 1))[0]
        plt.plot(Tp["ne"], Tp[label], label=label)
    plt.legend(loc="right")
    plt.xlabel("n /rpm")
    plt.ylabel("T /Nm")
    plt.show()
    #绘制共同工作输出特性曲线
    plt.figure()
    plt.plot(output.nt, output.Tt, linewidth=3, color="red")
    plt.legend(loc="right")
    plt.xlabel("n /rpm")
    plt.ylabel("T /Nm")
    plt.show()
    #
    # #读取XXX_res.mat结果文件
    # import DyMat
    # import matplotlib.pyplot as plt
    #
    # # 文件路径
    # mat_fname = modelName + '_res.mat'
    # # 读取结果文件
    # mat_contents = DyMat.DyMatFile(mat_fname)
    # # 读取所有变量名
    # print(mat_contents.names())
    # # 读取树状结构的变量名
    # print(mat_contents.nameTree())
    # # 读取某一变量的值
    # print(mat_contents.data('npCowork'))
    # # 读取变量的描述
    # print(mat_contents.description('npCowork'))
    # # 读取时间
    # print(mat_contents.abscissa('npCowork',True))
    #

