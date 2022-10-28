# file:///D:/Program%20Files/OpenModelica1.16.2-64bit/share/doc/omc/OpenModelicaUsersGuide/ompython.html#ompython-openmodelica-python-interface
from OMPython import ModelicaSystem
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import util
from imp import reload

def print_hi(name):
    pass


# 按间距中的绿色按钮以运行脚本。
if __name__ == '__main__':
    # VehicleInterfaces模型库的路径
    LibPath = "D:/Program Files/OpenModelica1.16.2-64bit/lib/omlibrary/VehicleInterfaces 2.0.0/package.mo"
    modelName = "VehicleInterfaces.Task.AllDriveVehicleWithAT"
    # 输入变量
    engineTable = np.array([[900, 1903],
                            [1000, 2138],
                            [1100, 2281],
                            [1200, 2282],
                            [1300, 2281],
                            [1500, 2282],
                            [1700, 2041],
                            [1900, 1826],
                            [2050, 0]])

    diameter = 0.43
    oilDensity = 860
    lambdaTable = np.array([
        [0, 1.93, 0, 6.23],
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
    gearboxTable = np.array([
        [4.630, 0.9],
        [3.400, 0.9],
        [2.190, 0.9],
        [1.520, 0.9],
        [1.000, 0.9],
        [0.760, 0.9],
        [0.670, 0.9]])
    finalDriveTable = np.array([20.14, 0.85])
    tyreRadius = 0.34
    vehicleMass = 120000
    dragCoeffience = 0.8
    frontalArea = 4.8
    airDensity = 1.225
    theta = 0
    gearStart = 1
    phi = 0.7
    rollingCoeffience = 0.016
    d = np.array([
        [0.0310, 0.0310, 0.0310, 0.0310, 0.0310, 0.0360, 0.0440],
        [0.4000, 0.4000, 0.4000, 0.4000, 0.4000, 0.4000, 0.4000],
        [1.2000, 1.2000, 1.2000, 1.2000, 1.2000, 1.1000, 1.0800]])
    gearTC = 1

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
    # parameters = mod.getParameters()
    # continuous = mod.getContinuous()
    # inputs = mod.getInputs()
    # 设置参数
    util.set_parameter(mod, "engineTable", engineTable)
    mod.setParameters("diameter=%s" % diameter)
    mod.setParameters("oilDensity=%s" % oilDensity)
    util.set_parameter(mod, "lambdaTable", lambdaTable)
    util.set_parameter(mod, "gearboxTable", gearboxTable)
    util.set_parameter(mod, "finalDriveTable", finalDriveTable)
    mod.setParameters("tyreRadius=%s" % tyreRadius)
    mod.setParameters("vehicleMass=%s" % vehicleMass)
    mod.setParameters("dragCoeffience=%s" % dragCoeffience)
    mod.setParameters("frontalArea=%s" % frontalArea)
    mod.setParameters("airDensity=%s" % airDensity)
    mod.setParameters("theta=%s" % theta)
    mod.setParameters("gearStart=%s" % gearStart)
    mod.setParameters("phi=%s" % phi)
    mod.setParameters("rollingCoeffience=%s" % rollingCoeffience)
    util.set_parameter(mod, "d", d)
    mod.setParameters("gearTC=%s" % gearTC)


    # mod.setContinuous()
    # 仿真求解设置
    # mod.getSimulationOptions()
    mod.setSimulationOptions(["stopTime=1",
                              "stepSize=1"])
    # mod.getLinearizationOptions()
    # 开始计算
    # mod.simulate()
    # mod.simulate(resultfile="tmpbouncingBall.mat")
    # mod.simulate(simflags="-noRootFinding -noEquidistantOutputFrequency=1 -initialStepSize=1 -maxStepSize=1")
    mod.simulate(simflags="-noEventEmit")


    # solutions = mod.getSolutions()

    ## 变矩器特性匹配
    outputTC = util.get_solutions_TCmatching(mod, 'TC', len(lambdaTable))
    # 绘制共同工作特性曲线
    plt.figure()
    plt.plot(engineTable[:, 0], engineTable[:, 1], label="engine")
    plt.plot(outputTC['npCowork'], outputTC['TpCowork'], linewidth=3, color="red", label="cowork")
    for i in range(len(lambdaTable)):
        plt.plot(engineTable[:, 0], outputTC['Tp'][i], label="i=%s" % lambdaTable[i, 0])
    plt.legend(loc="right")
    plt.xlabel("n /rpm")
    plt.ylabel("T /Nm")
    plt.show()
    # 绘制共同工作输出特性曲线
    plt.figure()
    plt.plot(outputTC['no'], outputTC['To'], linewidth=3, color="red")
    plt.legend(loc="right")
    plt.xlabel("n /rpm")
    plt.ylabel("T /Nm")
    plt.show()


    ##
    outputAT = util.get_solutions_gearboxMatchingSIMO(mod, 'AT', len(gearboxTable))
    outputMT = util.get_solutions_gearboxMatchingSIMO(mod, 'MT', len(gearboxTable))
    outputFinalDrive = util.get_solutions_gearboxMatchingMIMO(mod, 'finalDrive')
    outputFinalDrive1 = util.get_solutions_gearboxMatchingMIMO(mod, 'finalDrive1')
    outputVehicleChassis = util.get_solutions_chassis(mod, 'vehicleChassis')
    outputVehicleChassis1 = util.get_solutions_chassis(mod, 'vehicleChassis1')
    outputThrustCal = util.get_solutions_throustCharacteristics(mod, 'thrustCal')
    outputThrustCal1 = util.get_solutions_throustCharacteristics(mod, 'thrustCal1')
    # 绘制直驶牵引特性曲线
    plt.figure()
    for i in range(len(gearboxTable)):
        plt.plot(outputThrustCal['velocity1'][i],
                 outputThrustCal['dynamicFactor'][i],
                 label="gear=%s@TC" % i)
        plt.plot(outputThrustCal1['velocity1'][i],
                 outputThrustCal1['dynamicFactor'][i],
                 linewidth=3, label="gear=%s" % i)
    plt.legend(loc="right")
    plt.xlabel("velocity /km/h")
    plt.ylabel("dynamicFactor")
    plt.show()

    # 绘制散热特性曲线
    plt.figure()
    for i in range(len(gearboxTable)):
        plt.plot(outputThrustCal['velocity1'][i],
                 outputFinalDrive['powerLoss'][i],
                 label="gear=%s@TC" % i)
        plt.plot(outputThrustCal1['velocity1'][i],
                 outputFinalDrive1['powerLoss'][i],
                 linewidth=3, label="gear=%s" % i)
    plt.legend(loc="right")
    plt.xlabel("velocity /km/h")
    plt.ylabel("power /kW")
    plt.show()


    ## 加速特性
    outputThrustWithTC = util.get_solutions_throustResultWithTC(mod, 'thrustWithTC')
    outputIntersection = util.get_solutions_throustResultIntersectionForAcc(mod, 'Intersection')
    outputAccelerationCal = util.get_solutions_accelerationCharacteristics(mod, 'accelerationCal')
    # 绘制加速特性曲线
    size = np.shape(outputAccelerationCal['t'])
    length = size[0] * size[1]
    plt.figure()
    plt.plot(np.reshape(outputAccelerationCal['t'], [length]),
             np.reshape(outputAccelerationCal['v'], [length]),
             linewidth=3, color="red")
    plt.xlabel("time /s")
    plt.ylabel("velocity /km/h")
    plt.show()
    # 绘制加速特性曲线
    plt.figure()
    plt.plot(np.reshape(outputAccelerationCal['t'], [length]),
             np.reshape(outputAccelerationCal['s'], [length]),
             linewidth=3, color="blue")
    plt.xlabel("time /s")
    plt.ylabel("s /km")
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

