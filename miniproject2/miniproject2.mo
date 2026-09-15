within ;
model miniproject2
  replaceable package Medium
    extends Modelica.Media.Water.StandardWater;
    model miniproject1 "Model of a pumping system for drinking water"
      extends Modelica.Icons.Example;

      replaceable package Medium = Modelica.Media.Water.StandardWaterOnePhase
        constrainedby Modelica.Media.Interfaces.PartialMedium;
      //replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
      //  constrainedby Modelica.Media.Interfaces.PartialMedium;

      Modelica.Fluid.Sources.FixedBoundary source(
        nPorts = 1,
        use_T=true,
        T=Modelica.Units.Conversions.from_degC(20),
        p=system.p_ambient,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));

      Modelica.Fluid.Pipes.StaticPipe pipe(
        allowFlowReversal=true,
        length=100,
        height_ab=50,
        diameter=0.3,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(
            origin={-30,-51},
            extent={{-9,-10},{11,10}},
            rotation=90)));

      Modelica.Fluid.Machines.PrescribedPump pumps(
        checkValve=true,
        checkValveHomotopy=Modelica.Fluid.Types.CheckValveHomotopyType.Closed,
        N_nominal=1200,
        redeclare function flowCharacteristic =
            Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
            (V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
        use_N_in=true,
        nParallel=1,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        V(displayUnit="l") = 0.05,
        massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare package Medium = Medium,
        p_b_start=600000,
        T_start=system.T_start)
        annotation (Placement(transformation(extent={{-68,-80},{-48,-60}})));

      Modelica.Fluid.Vessels.OpenTank reservoir(
        T_start=Modelica.Units.Conversions.from_degC(20),
        use_portsData=true,
        crossArea=50,
        level_start=2.2,
        height=3,
        nPorts=3,
        portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.3),
            Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.3),
            Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=0.01)},
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-20,-16},{0,4}})));

      Modelica.Fluid.Valves.ValveLinear userValve(
        allowFlowReversal=false,
        dp_nominal=200000,
        m_flow_nominal=400,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{58,-38},{74,-22}})));
      Modelica.Fluid.Sources.FixedBoundary sink(
        p=system.p_ambient,
        T=system.T_ambient,
        nPorts=2,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
      Modelica.Blocks.Sources.Step valveOpening(startTime=200, offset=1e-6)
        annotation (Placement(transformation(extent={{56,0},{76,20}})));
      Modelica.Blocks.Sources.Constant RelativePressureSetPoint(k=2e4)
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      Modelica.Blocks.Logical.OnOffController controller(bandwidth=4000,
          pre_y_start=false)
                            annotation (Placement(transformation(extent={{-40,60},{
                -20,80}})));
      Modelica.Blocks.Logical.TriggeredTrapezoid PumpRPMGenerator(
        rising=3,
        falling=3,
        amplitude=1200,
        offset=0.001) annotation (Placement(transformation(extent={{0,60},{20,80}})));
      Modelica.Fluid.Sensors.RelativePressure reservoirPressure(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{10,-12},{30,-32}})));
      Modelica.Blocks.Continuous.FirstOrder PT1(
        T=2,
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));

      inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                       annotation (Placement(transformation(extent=
                {{60,-96},{80,-76}})));
    equation
      connect(userValve.port_b, sink.ports[1]) annotation (Line(points={{74,-30},
              {77,-30},{77,-28},{80,-28}}, color={0,127,255}));
      connect(source.ports[1], pumps.port_a) annotation (Line(points={{-80,-70},{
              -74,-70},{-68,-70}}, color={0,127,255}));
      connect(valveOpening.y, userValve.opening) annotation (Line(points={{77,10},{
              98,10},{98,-12},{66,-12},{66,-23.6}}, color={0,0,127}));
      connect(RelativePressureSetPoint.y, controller.reference)
                                                        annotation (Line(points={{
              -79,70},{-60,70},{-60,76},{-42,76}}, color={0,0,127}));
      connect(controller.y, PumpRPMGenerator.u)
        annotation (Line(points={{-19,70},{-2,70}}, color={255,0,255}));
      connect(reservoirPressure.p_rel, controller.u) annotation (Line(points={{20,
              -13},{20,50},{-52,50},{-52,64},{-42,64}}, color={0,0,127}));
      connect(reservoirPressure.port_b, sink.ports[2]) annotation (Line(
          points={{30,-22},{44,-22},{44,-48},{80,-48},{80,-32}},
          color={0,127,255},
          pattern=LinePattern.Dot));
      connect(PumpRPMGenerator.y, PT1.u)
        annotation (Line(points={{21,70},{38,70}}, color={0,0,127}));
      connect(PT1.y, pumps.N_in) annotation (Line(points={{61,70},{74,70},{74,30},{
              -58,30},{-58,-60}}, color={0,0,127}));
      connect(pipe.port_a, pumps.port_b) annotation (Line(points={{-30,-60},
              {-30,-70},{-48,-70}}, color={0,127,255}));
      connect(reservoir.ports[1], pipe.port_b) annotation (Line(
          points={{-12.6667,-16},{-12.6667,-30},{-30,-30},{-30,-40}}, color={0,127,255}));
      connect(reservoir.ports[3], reservoirPressure.port_a) annotation (Line(
          points={{-7.33333,-16},{-7,-16},{-7,-22},{10,-22}},
          color={0,127,255},
          pattern=LinePattern.Dot));
      connect(reservoir.ports[2], userValve.port_a) annotation (Line(
          points={{-10,-16},{-10,-30},{58,-30}}, color={0,127,255}));
      annotation (
        Documentation(info="<html>
<p>
Water is pumped from a source by a pump (fitted with check valves), through a pipe whose outlet is 50 m higher than the source, into a reservoir. The users are represented by an equivalent valve, connected to the reservoir.
</p>
<p>
The water controller is a simple on-off controller, regulating on the gauge pressure measured at the base of the tower; the output of the controller is the rotational speed of the pump, which is represented by the output of a first-order system. A small but nonzero rotational speed is used to represent the standby state of the pumps, in order to avoid singularities in the flow characteristic.
</p>
<p>When the simulation starts, the level is above the set point, so the initial state of the pump controller is off. Hence, the check valve of the pump is engaged. In order to facilitate the solution of the initialization problem, the <code>homotopyType</code> parameter is set accordingly.
</p>
<p>
Simulate for 2000 s. When the valve is opened at time t=200, the pump starts turning on and off to keep the reservoir level around 2 meters, which roughly corresponds to a gauge pressure of 200 mbar.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/PumpingSystem.png\" border=\"1\"
     alt=\"PumpingSystem.png\">
</html>",     revisions="<html>
<ul>
<li><em>Jan 2009</em>
    by R&uuml;diger Franke:<br>
       Reduce diameters of pipe and reservoir ports; use separate port for measurement of reservoirPressure, avoiding disturbances due to pressure losses.</li>
<li><em>1 Oct 2007</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Parameters updated.</li>
<li><em>2 Nov 2005</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created.</li>
</ul>
</html>"),
        experiment(
          StopTime=2000,
          Interval=0.4,
          Tolerance=1e-006));
    end miniproject1;

    model Miniproject_1 "Model of a pumping system for drinking water"
      extends Modelica.Icons.Example;

      replaceable package Medium = Modelica.Media.Water.StandardWaterOnePhase
        constrainedby Modelica.Media.Interfaces.PartialMedium;
      //replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
      //  constrainedby Modelica.Media.Interfaces.PartialMedium;

      Modelica.Fluid.Sources.FixedBoundary source(
        nPorts = 1,
        use_T=true,
        T=Modelica.Units.Conversions.from_degC(20),
        p=system.p_ambient,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));

      Modelica.Fluid.Pipes.StaticPipe pipe(
        allowFlowReversal=true,
        length=100,
        height_ab=50,
        diameter=0.3,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(
            origin={-30,-51},
            extent={{-9,-10},{11,10}},
            rotation=90)));

      Modelica.Fluid.Machines.PrescribedPump pumps(
        checkValve=true,
        checkValveHomotopy=Modelica.Fluid.Types.CheckValveHomotopyType.Closed,
        N_nominal=1200,
        redeclare function flowCharacteristic =
            Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
            (V_flow_nominal={0,0.25,0.5}, head_nominal={100,60,0}),
        use_N_in=true,
        nParallel=1,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        V(displayUnit="l") = 0.05,
        massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare package Medium = Medium,
        p_b_start=600000,
        T_start=system.T_start)
        annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));

      Modelica.Fluid.Vessels.OpenTank reservoir(
        T_start=Modelica.Units.Conversions.from_degC(20),
        use_portsData=true,
        crossArea=1,
        level_start=2.2,
        height=2,
        nPorts=3,
        portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
            0.3),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
            0.3),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
            0.01)},
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-20,-16},{0,4}})));

      Modelica.Fluid.Valves.ValveLinear userValve(
        allowFlowReversal=false,
        dp_nominal=200000,
        m_flow_nominal=400,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{58,-38},{74,-22}})));
      Modelica.Fluid.Sources.FixedBoundary sink(
        p=system.p_ambient,
        T=system.T_ambient,
        nPorts=2,
        redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
      Modelica.Blocks.Sources.Step valveOpening(startTime=200, offset=1e-6)
        annotation (Placement(transformation(extent={{56,0},{76,20}})));
      Modelica.Blocks.Sources.Constant RelativePressureSetPoint(k=9810)
        annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
      Modelica.Blocks.Logical.OnOffController controller(bandwidth=4000,
          pre_y_start=false)
                            annotation (Placement(transformation(extent={{-40,60},{
                -20,80}})));
      Modelica.Blocks.Logical.TriggeredTrapezoid PumpRPMGenerator(
        rising=3,
        falling=3,
        amplitude=1200,
        offset=0.001) annotation (Placement(transformation(extent={{0,60},{20,80}})));
      Modelica.Fluid.Sensors.RelativePressure reservoirPressure(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{10,-12},{30,-32}})));
      Modelica.Blocks.Continuous.FirstOrder PT1(
        T=2,
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0)
        annotation (Placement(transformation(extent={{40,60},{60,80}})));

      inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                       annotation (Placement(transformation(extent=
                {{60,-96},{80,-76}})));
      Modelica.Blocks.Sources.TimeTable timeTable(table=[0,1; 100,0; 200,1; 300,
            0; 400,1; 500,0; 600,1; 700,0; 800,1; 900,0])
        annotation (Placement(transformation(extent={{114,6},{134,26}})));
    equation
      connect(userValve.port_b, sink.ports[1]) annotation (Line(points={{74,-30},
              {77,-30},{77,-31},{80,-31}}, color={0,127,255}));
      connect(source.ports[1], pumps.port_a) annotation (Line(points={{-80,-70},
              {-70,-70}},          color={0,127,255}));
      connect(RelativePressureSetPoint.y, controller.reference)
                                                        annotation (Line(points={{
              -79,70},{-60,70},{-60,76},{-42,76}}, color={0,0,127}));
      connect(controller.y, PumpRPMGenerator.u)
        annotation (Line(points={{-19,70},{-2,70}}, color={255,0,255}));
      connect(reservoirPressure.p_rel, controller.u) annotation (Line(points={{20,
              -13},{20,50},{-52,50},{-52,64},{-42,64}}, color={0,0,127}));
      connect(reservoirPressure.port_b, sink.ports[2]) annotation (Line(
          points={{30,-22},{44,-22},{44,-48},{80,-48},{80,-29}},
          color={0,127,255},
          pattern=LinePattern.Dot));
      connect(PumpRPMGenerator.y, PT1.u)
        annotation (Line(points={{21,70},{38,70}}, color={0,0,127}));
      connect(PT1.y, pumps.N_in) annotation (Line(points={{61,70},{74,70},{74,
              30},{-60,30},{-60,-60}},
                                  color={0,0,127}));
      connect(pipe.port_a, pumps.port_b) annotation (Line(points={{-30,-60},{
              -30,-70},{-50,-70}},  color={0,127,255}));
      connect(reservoir.ports[1], pipe.port_b) annotation (Line(
          points={{-11.3333,-16},{-11.3333,-30},{-30,-30},{-30,-40}}, color={0,127,255}));
      connect(reservoir.ports[3], reservoirPressure.port_a) annotation (Line(
          points={{-8.66667,-16},{-7,-16},{-7,-22},{10,-22}},
          color={0,127,255},
          pattern=LinePattern.Dot));
      connect(reservoir.ports[2], userValve.port_a) annotation (Line(
          points={{-10,-16},{-10,-30},{58,-30}}, color={0,127,255}));
      connect(timeTable.y, userValve.opening) annotation (Line(points={{135,16},
              {140,16},{140,-14},{66,-14},{66,-23.6}}, color={0,0,127}));
      annotation (
        Documentation(info="<html>
<p>
Water is pumped from a source by a pump (fitted with check valves), through a pipe whose outlet is 50 m higher than the source, into a reservoir. The users are represented by an equivalent valve, connected to the reservoir.
</p>
<p>
The water controller is a simple on-off controller, regulating on the gauge pressure measured at the base of the tower; the output of the controller is the rotational speed of the pump, which is represented by the output of a first-order system. A small but nonzero rotational speed is used to represent the standby state of the pumps, in order to avoid singularities in the flow characteristic.
</p>
<p>When the simulation starts, the level is above the set point, so the initial state of the pump controller is off. Hence, the check valve of the pump is engaged. In order to facilitate the solution of the initialization problem, the <code>homotopyType</code> parameter is set accordingly.
</p>
<p>
Simulate for 2000 s. When the valve is opened at time t=200, the pump starts turning on and off to keep the reservoir level around 2 meters, which roughly corresponds to a gauge pressure of 200 mbar.
</p>

<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/PumpingSystem.png\" border=\"1\"
     alt=\"PumpingSystem.png\">
</html>",     revisions="<html>
<ul>
<li><em>Jan 2009</em>
    by R&uuml;diger Franke:<br>
       Reduce diameters of pipe and reservoir ports; use separate port for measurement of reservoirPressure, avoiding disturbances due to pressure losses.</li>
<li><em>1 Oct 2007</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Parameters updated.</li>
<li><em>2 Nov 2005</em>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created.</li>
</ul>
</html>"),
        experiment(
          StopTime=2000,
          Interval=0.4,
          Tolerance=1e-006));
    end Miniproject_1;
  end Medium;
  Modelica.Fluid.Vessels.OpenTank hotwatertank(
    height=5,
    crossArea=1,
    p_ambient(displayUnit="kPa") = 100000,
    T_ambient=293.15,
    use_portsData=true,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=50),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=50)},
    use_HeatTransfer=false,
    nPorts=2,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{12,-2},{52,38}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=hotwatertank.level)
    annotation (Placement(transformation(extent={{-126,16},{-106,36}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=0.5,
    uHigh=4.75,
    pre_y_start=false)
    annotation (Placement(transformation(extent={{-80,16},{-60,36}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=0, realFalse=4)
    annotation (Placement(transformation(extent={{-26,16},{-6,36}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary2(
    use_m_flow_in=true,
    T=293.15,
    nPorts=1,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        origin={70,-26},
        rotation=180)));
  Modelica.Fluid.Machines.ControlledPump pump1(
    p_b_start=300000,
    checkValveHomotopy=Modelica.Fluid.Types.CheckValveHomotopyType.NoHomotopy,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0.005,0.01,0.02}, head_nominal={40,21,0}),
    N_nominal=1200,
    rho_nominal=1000,
    efficiencyCharacteristic(eta_nominal=0.8),
    V=0.01,
    p_a_nominal(displayUnit="bar"),
    p_b_nominal(displayUnit="bar"),
    m_flow_nominal=2,
    control_m_flow=true,
    use_m_flow_set=true,
    use_p_set=false,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-80,-34},{-60,-14}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{94,26},{114,46}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    p(displayUnit="bar") = 100000,
    T=293.15,
    C=Medium.C_default,                        nPorts=1,
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-128,-34},{-108,-14}})));
  Modelica.Fluid.Pipes.StaticPipe pipe2(
    redeclare package Medium = Medium,
    length=20.1,
    diameter(displayUnit="mm") = 0.05,
    height_ab=20)
    annotation (Placement(transformation(extent={{-26,-34},{-6,-14}})));
  Modelica.Blocks.Sources.TimeTable userprofile1(table=[0,-2; 1,0; 2,-2; 3,0; 4,
        -2; 5,0; 6,-2; 7,0; 8,-4; 9,0; 10,-2; 11,0; 12,-2; 13,0; 14,-2; 15,0;
        16,-2; 17,0; 18,-4; 19,0; 20,-2; 21,0; 22,-2; 23,0; 24,-2], timeScale(
        displayUnit="h") = 3600)
             annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        origin={108,-34},
        rotation=180)));
  Modelica.Blocks.Sources.TimeTable userprofile2(table=[0,-2; 1,0; 2,-2; 3,0; 4,
        -2; 5,0; 6,-2; 7,0; 8,-2; 9,0; 10,-2; 11,0; 12,-4; 13,0; 14,-2; 15,0;
        16,-2; 17,0; 18,-2; 19,0; 20,-2; 21,0; 22,-2; 23,0; 24,-2], timeScale(
        displayUnit="h") = 3600)
             annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        origin={108,0},
        rotation=180)));
equation
  connect(hotwatertank.ports[1], boundary2.ports[1]) annotation (Line(points={{30,-2},
          {30,-26},{60,-26}},                              color={0,127,255}));
  connect(realExpression1.y, hysteresis.u)
    annotation (Line(points={{-105,26},{-82,26}},color={0,0,127}));
  connect(hysteresis.y, booleanToReal.u)
    annotation (Line(points={{-59,26},{-28,26}}, color={255,0,255}));
  connect(pump1.port_a, boundary1.ports[1]) annotation (Line(points={{-80,-24},
          {-108,-24}},                    color={0,127,255}));
  connect(booleanToReal.y, pump1.m_flow_set) annotation (Line(points={{-5,26},{
          -4,26},{-4,-6},{-76,-6},{-76,-15.8},{-75,-15.8}}, color={0,0,127}));
  connect(pump1.port_b, pipe2.port_a)
    annotation (Line(points={{-60,-24},{-26,-24}}, color={0,127,255}));
  connect(pipe2.port_b, hotwatertank.ports[2])
    annotation (Line(points={{-6,-24},{34,-24},{34,-2}},  color={0,127,255}));
  connect(userprofile1.y, boundary2.m_flow_in)
    annotation (Line(points={{97,-34},{80,-34}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,
            120}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
            140,120}})),
    uses(Modelica(version="4.1.0")));
end miniproject2;
