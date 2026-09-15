within ;
model MiniProject3_1
  Modelica.StateGraph.InitialStep off(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-318,66},{-298,86}})));
  Modelica.StateGraph.StepWithSignal onechiller_on(nIn=2, nOut=2)
    annotation (Placement(transformation(extent={{-318,34},{-298,54}})));
  Modelica.StateGraph.StepWithSignal twochiller_on(nIn=2, nOut=2)
    annotation (Placement(transformation(extent={{-318,-2},{-298,18}})));
  Modelica.StateGraph.StepWithSignal threechiller_on(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-320,-34},{-300,-14}})));
  Modelica.StateGraph.Transition transition1(condition=open1chiller.y)
    annotation (Placement(transformation(extent={{-354,34},{-334,54}})));
  Modelica.StateGraph.Transition transition2(condition=open2chiller.y)
    annotation (Placement(transformation(extent={{-354,-2},{-334,18}})));
  Modelica.StateGraph.Transition transition3(condition=close1chiller.y)
    annotation (Placement(transformation(extent={{-282,34},{-262,54}})));
  Modelica.StateGraph.Transition transition4(condition=turnonthirdchiller.y)
    annotation (Placement(transformation(extent={{-354,-34},{-334,-14}})));
  Modelica.StateGraph.Transition transition5(condition=turnoffsecondchiller.y)
    annotation (Placement(transformation(extent={{-282,-2},{-262,18}})));
  Modelica.StateGraph.Transition transition6(condition=turnoffthirdchiller1.y)
    annotation (Placement(transformation(extent={{-282,-34},{-262,-14}})));
  Buildings.Fluid.Sources.MassFlowSource_T sou1(
    nPorts=3,
    redeclare package Medium = Buildings.Media.Water "Water",
    use_T_in=true,
    m_flow=150,
    T=298.15) "Mass flow source"
    annotation (Placement(transformation(extent={{-36,6},{-16,26}})));
  Buildings.Fluid.Sources.MassFlowSource_T sou2(
    nPorts=3,
    redeclare package Medium = Buildings.Media.Water "Water",
    use_T_in=true,
    m_flow=100,
    T=291.15) "Mass flow source"
    annotation (Placement(transformation(extent={{90,-14},{70,6}})));
  Buildings.Fluid.Sources.Boundary_pT sin1(redeclare package Medium =
        Buildings.Media.Water "Water",
      nPorts=1)
              "Pressure source"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        origin={92,36})));
  Buildings.Fluid.Sources.Boundary_pT sin2(redeclare package Medium =
        Buildings.Media.Water "Water",
      nPorts=1)
              "Pressure source"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-48,-24})));
  Buildings.Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Buildings.Media.Water "Water",
    m_flow_nominal=160,
    dp_nominal=6000) "Flow resistance"
    annotation (Placement(transformation(extent={{54,26},{74,46}})));
  Buildings.Fluid.FixedResistances.PressureDrop res2(
    dp_nominal=6000,
    redeclare package Medium = Buildings.Media.Water "Water",
    m_flow_nominal=112)               "Flow resistance"
    annotation (Placement(transformation(extent={{-4,-34},{-24,-14}})));
  parameter Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_McQuay_WSC_471kW_5_89COP_Vanes
    per(QEva_flow_nominal=-2813600)
        "Chiller performance data"
    annotation (Placement(transformation(extent={{82,76},{102,96}})));
  Buildings.Fluid.Chillers.ElectricEIR chi1(
    redeclare package Medium1 = Buildings.Media.Water "Water",
    redeclare package Medium2 = Buildings.Media.Water "Water",
    PLR1(start=0.05, fixed=false),
    per=per,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp1_nominal=6000,
    dp2_nominal=6000) "Chiller model"
    annotation (Placement(transformation(extent={{24,-6},{44,14}})));
  Modelica.Blocks.Logical.GreaterThreshold open1chiller(threshold=0)
    "Greater threshold"
    annotation (Placement(transformation(extent={{172,100},{192,120}})));
  Modelica.Blocks.Logical.GreaterThreshold close1chiller(threshold=600)
    "Greater threshold"
    annotation (Placement(transformation(extent={{240,66},{260,86}})));
  Modelica.Blocks.Logical.GreaterThreshold open2chiller(threshold=0.9)
    "Greater threshold"
    annotation (Placement(transformation(extent={{172,26},{192,46}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{130,100},{150,120}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=chi1.PLR1)
    annotation (Placement(transformation(extent={{130,66},{150,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=chi1.PLR1)
    annotation (Placement(transformation(extent={{130,26},{150,46}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=0.05)
    annotation (Placement(transformation(extent={{172,66},{192,86}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{206,66},{226,86}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{176,-16},{196,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=chi1.PLR1)
    annotation (Placement(transformation(extent={{132,-8},{152,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=chi2.PLR1)
    annotation (Placement(transformation(extent={{132,-26},{152,-6}})));
  Buildings.Fluid.Chillers.ElectricEIR chi2(
    redeclare package Medium1 = Buildings.Media.Water "Water",
    redeclare package Medium2 = Buildings.Media.Water "Water",
    PLR1(start=0.05, fixed=false),
    per=per,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp1_nominal=6000,
    dp2_nominal=6000) "Chiller model"
    annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
  Buildings.Fluid.Chillers.ElectricEIR chi3(
    redeclare package Medium1 = Buildings.Media.Water "Water",
    redeclare package Medium2 = Buildings.Media.Water "Water",
    PLR1(fixed=false, start=0.05),
    per=per,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp1_nominal=6000,
    dp2_nominal=6000) "Chiller model"
    annotation (Placement(transformation(extent={{24,-60},{44,-40}})));
  Modelica.Blocks.Logical.And turnonthirdchiller
    annotation (Placement(transformation(extent={{228,-58},{248,-38}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=chi1.PLR1)
    annotation (Placement(transformation(extent={{134,-48},{154,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=chi2.PLR1)
    annotation (Placement(transformation(extent={{134,-80},{154,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold morethan90(threshold=0.9)
    "Greater threshold"
    annotation (Placement(transformation(extent={{176,-48},{196,-28}})));
  Modelica.Blocks.Logical.GreaterThreshold morethan90_1(threshold=0.9)
    "Greater threshold"
    annotation (Placement(transformation(extent={{176,-80},{196,-60}})));
  Modelica.Blocks.Math.Add3 add3
    annotation (Placement(transformation(extent={{178,-126},{198,-106}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=chi1.PLR1)
    annotation (Placement(transformation(extent={{136,-110},{156,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=chi2.PLR1)
    annotation (Placement(transformation(extent={{136,-126},{156,-106}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=chi3.PLR1)
    annotation (Placement(transformation(extent={{136,-142},{156,-122}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=0.6)
    annotation (Placement(transformation(extent={{212,-16},{232,4}})));
  Modelica.Blocks.Logical.Timer timer1
    annotation (Placement(transformation(extent={{246,-16},{266,4}})));
  Modelica.Blocks.Logical.GreaterThreshold turnoffsecondchiller(threshold=600)
    "Greater threshold"
    annotation (Placement(transformation(extent={{280,-16},{300,4}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold2(threshold=0.9)
    annotation (Placement(transformation(extent={{218,-126},{238,-106}})));
  Modelica.Blocks.Logical.Timer timer2
    annotation (Placement(transformation(extent={{252,-126},{272,-106}})));
  Modelica.Blocks.Logical.GreaterThreshold turnoffthirdchiller1(threshold=600)
    "Greater threshold"
    annotation (Placement(transformation(extent={{286,-126},{306,-106}})));
  Modelica.Blocks.Sources.Constant Tset(k=279.15)
    annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
  Modelica.Blocks.Sources.TimeTable Tevaporator_in(table=[0,273.15 + 14; 1,
        273.15 + 14; 2,273.15 + 14; 3,273.15 + 13; 4,273.15 + 13; 5,273.15 + 14;
        6,273.15 + 15; 7,273.15 + 15; 8,273.15 + 16; 9,273.15 + 16; 10,273.15
         + 17; 11,273.15 + 18; 12,273.15 + 18; 13,273.15 + 20; 14,273.15 + 19;
        15,273.15 + 17; 16,273.15 + 17; 17,273.15 + 17; 18,273.15 + 17; 19,
        273.15 + 16; 20,273.15 + 16; 21,273.15 + 15; 22,273.15 + 15; 23,273.15
         + 15], timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{66,-56},{86,-36}})));
  Modelica.Blocks.Sources.TimeTable Tcondensor_in(table=[0,273.15 + 25; 1,
        273.15 + 24; 2,273.15 + 24; 3,273.15 + 23; 4,273.15 + 23; 5,273.15 + 24;
        6,273.15 + 25; 7,273.15 + 25; 8,273.15 + 26; 9,273.15 + 26; 10,273.15
         + 27; 11,273.15 + 28; 12,273.15 + 28; 13,273.15 + 30; 14,273.15 + 29;
        15,273.15 + 27; 16,273.15 + 27; 17,273.15 + 27; 18,273.15 + 27; 19,
        273.15 + 26; 20,273.15 + 26; 21,273.15 + 25; 22,273.15 + 25; 23,273.15
         + 25], timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-76,36},{-56,56}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-148,18},{-128,38}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{-184,40},{-164,60}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{-184,-30},{-164,-10}})));
  replaceable package Medium
  end Medium;
equation
connect(off.outPort[1], transition1.inPort) annotation (Line(points={{-297.5,
        76},{-292,76},{-292,60},{-360,60},{-360,44},{-348,44}}, color={0,0,0}));
connect(transition1.outPort, onechiller_on.inPort[1]) annotation (Line(points={{-342.5,
        44},{-330,44},{-330,43.75},{-319,43.75}},         color={0,0,0}));
connect(onechiller_on.outPort[1], transition2.inPort) annotation (Line(points={{-297.5,
        43.875},{-292,43.875},{-292,24},{-360,24},{-360,8},{-348,8}},
      color={0,0,0}));
connect(transition2.outPort, twochiller_on.inPort[1]) annotation (Line(points={{-342.5,
        8},{-330,8},{-330,7.75},{-319,7.75}},         color={0,0,0}));
connect(onechiller_on.outPort[2], transition3.inPort) annotation (Line(points={{-297.5,
        44.125},{-285.75,44.125},{-285.75,44},{-276,44}},         color={0,0,
        0}));
connect(transition3.outPort, off.inPort[1]) annotation (Line(points={{-270.5,
        44},{-254,44},{-254,92},{-324,92},{-324,76},{-319,76}}, color={0,0,0}));
connect(twochiller_on.outPort[1], transition4.inPort) annotation (Line(points={{-297.5,
        7.875},{-292,7.875},{-292,-8},{-360,-8},{-360,-24},{-348,-24}},
      color={0,0,0}));
connect(transition4.outPort, threechiller_on.inPort[1])
  annotation (Line(points={{-342.5,-24},{-321,-24}}, color={0,0,0}));
connect(twochiller_on.outPort[2], transition5.inPort) annotation (Line(points={{-297.5,
        8.125},{-288,8.125},{-288,8},{-276,8}},         color={0,0,0}));
connect(transition5.outPort, onechiller_on.inPort[2]) annotation (Line(points={{-270.5,
        8},{-256,8},{-256,28},{-324,28},{-324,44.25},{-319,44.25}},
      color={0,0,0}));
connect(threechiller_on.outPort[1], transition6.inPort)
  annotation (Line(points={{-299.5,-24},{-276,-24}}, color={0,0,0}));
connect(transition6.outPort, twochiller_on.inPort[2]) annotation (Line(points={{-270.5,
        -24},{-256,-24},{-256,-40},{-324,-40},{-324,8.25},{-319,8.25}},
      color={0,0,0}));
connect(res1.port_b,sin1. ports[1]) annotation (Line(
    points={{74,36},{82,36}},
    color={0,127,255},
    smooth=Smooth.None));
connect(res2.port_b,sin2. ports[1]) annotation (Line(
    points={{-24,-24},{-38,-24}},
    color={0,127,255},
    smooth=Smooth.None));
connect(sou1.ports[1], chi1.port_a1) annotation (Line(
    points={{-16,14.6667},{2,14.6667},{2,10},{24,10}},
    color={0,127,255},
    smooth=Smooth.None));
connect(chi1.port_b1, res1.port_a) annotation (Line(
    points={{44,10},{48,10},{48,36},{54,36}},
    color={0,127,255},
    smooth=Smooth.None));
connect(sou2.ports[1], chi1.port_a2) annotation (Line(
    points={{70,-5.33333},{52,-5.33333},{52,-2},{44,-2}},
    color={0,127,255},
    smooth=Smooth.None));
connect(chi1.port_b2, res2.port_a) annotation (Line(
    points={{24,-2},{12,-2},{12,-24},{-4,-24}},
    color={0,127,255},
    smooth=Smooth.None));
connect(realExpression.y, open1chiller.u)
  annotation (Line(points={{151,110},{170,110}}, color={0,0,127}));
connect(realExpression1.y, lessThreshold.u)
  annotation (Line(points={{151,76},{170,76}}, color={0,0,127}));
connect(lessThreshold.y, timer.u)
  annotation (Line(points={{193,76},{204,76}}, color={255,0,255}));
connect(timer.y, close1chiller.u)
  annotation (Line(points={{227,76},{238,76}}, color={0,0,127}));
connect(realExpression2.y, open2chiller.u)
  annotation (Line(points={{151,36},{170,36}}, color={0,0,127}));
connect(realExpression6.y, add.u1) annotation (Line(points={{153,2},{164,2},{
        164,0},{174,0}}, color={0,0,127}));
connect(realExpression7.y, add.u2) annotation (Line(points={{153,-16},{166,
        -16},{166,-12},{174,-12}}, color={0,0,127}));
connect(sou2.ports[2], chi2.port_a2) annotation (Line(points={{70,-4},{54,-4},
        {54,-26},{44,-26}}, color={0,127,255}));
connect(sou2.ports[3], chi3.port_a2) annotation (Line(points={{70,-2.66667},{
        66,-2.66667},{66,-8},{56,-8},{56,-56},{44,-56}}, color={0,127,255}));
connect(res1.port_a, chi2.port_b1) annotation (Line(points={{54,36},{48,36},{
        48,12},{50,12},{50,-14},{44,-14}}, color={0,127,255}));
connect(res1.port_a, chi3.port_b1) annotation (Line(points={{54,36},{48,36},{
        48,12},{50,12},{50,-44},{44,-44}}, color={0,127,255}));
connect(chi2.port_a1, sou1.ports[2]) annotation (Line(points={{24,-14},{10,
        -14},{10,2},{-10,2},{-10,16},{-16,16}}, color={0,127,255}));
connect(chi3.port_a1, sou1.ports[3]) annotation (Line(points={{24,-44},{8,-44},
        {8,0},{-12,0},{-12,17.3333},{-16,17.3333}}, color={0,127,255}));
connect(res2.port_a, chi2.port_b2) annotation (Line(points={{-4,-24},{12,-24},
        {12,-26},{24,-26}}, color={0,127,255}));
connect(res2.port_a, chi3.port_b2) annotation (Line(points={{-4,-24},{12,-24},
        {12,-56},{24,-56}}, color={0,127,255}));
connect(realExpression8.y, morethan90.u)
  annotation (Line(points={{155,-38},{174,-38}}, color={0,0,127}));
connect(realExpression9.y, morethan90_1.u)
  annotation (Line(points={{155,-70},{174,-70}}, color={0,0,127}));
connect(morethan90.y, turnonthirdchiller.u1) annotation (Line(points={{197,
        -38},{214,-38},{214,-48},{226,-48}}, color={255,0,255}));
connect(morethan90_1.y, turnonthirdchiller.u2) annotation (Line(points={{197,
        -70},{214,-70},{214,-56},{226,-56}}, color={255,0,255}));
connect(realExpression3.y, add3.u1) annotation (Line(points={{157,-100},{168,
        -100},{168,-108},{176,-108}}, color={0,0,127}));
connect(realExpression4.y, add3.u2)
  annotation (Line(points={{157,-116},{176,-116}}, color={0,0,127}));
connect(realExpression5.y, add3.u3) annotation (Line(points={{157,-132},{168,
        -132},{168,-124},{176,-124}}, color={0,0,127}));
connect(add.y, lessThreshold1.u)
  annotation (Line(points={{197,-6},{210,-6}}, color={0,0,127}));
connect(lessThreshold1.y, timer1.u)
  annotation (Line(points={{233,-6},{244,-6}}, color={255,0,255}));
connect(timer1.y, turnoffsecondchiller.u)
  annotation (Line(points={{267,-6},{278,-6}}, color={0,0,127}));
connect(lessThreshold2.y, timer2.u)
  annotation (Line(points={{239,-116},{250,-116}}, color={255,0,255}));
connect(timer2.y, turnoffthirdchiller1.u)
  annotation (Line(points={{273,-116},{284,-116}}, color={0,0,127}));
connect(add3.y, lessThreshold2.u)
  annotation (Line(points={{199,-116},{216,-116}}, color={0,0,127}));
connect(Tset.y, chi1.TSet) annotation (Line(points={{-19,62},{-8,62},{-8,4},{
        14,4},{14,1},{22,1}}, color={0,0,127}));
connect(Tset.y, chi2.TSet) annotation (Line(points={{-19,62},{-8,62},{-8,4},{
        14,4},{14,-18},{10,-18},{10,-23},{22,-23}}, color={0,0,127}));
connect(Tset.y, chi3.TSet) annotation (Line(points={{-19,62},{-8,62},{-8,4},{
        14,4},{14,-18},{10,-18},{10,-53},{22,-53}}, color={0,0,127}));
connect(Tevaporator_in.y, sou2.T_in) annotation (Line(points={{87,-46},{102,
        -46},{102,0},{92,0}}, color={0,0,127}));
connect(Tcondensor_in.y, sou1.T_in) annotation (Line(points={{-55,46},{-48,46},
        {-48,20},{-38,20}}, color={0,0,127}));
connect(onechiller_on.active, or2.u1) annotation (Line(points={{-308,33},{
        -308,26},{-196,26},{-196,50},{-186,50}}, color={255,0,255}));
connect(twochiller_on.active, or2.u2) annotation (Line(points={{-308,-3},{
        -288,-3},{-288,-8},{-192,-8},{-192,34},{-194,34},{-194,42},{-186,42}},
      color={255,0,255}));
connect(threechiller_on.active, or1.u2) annotation (Line(points={{-310,-35},{
        -310,-42},{-158,-42},{-158,20},{-150,20}}, color={255,0,255}));
connect(or2.y, or1.u1) annotation (Line(points={{-163,50},{-156,50},{-156,36},
        {-158,36},{-158,28},{-150,28}}, color={255,0,255}));
connect(or1.y, chi1.on) annotation (Line(points={{-127,28},{-46,28},{-46,44},
        {-4,44},{-4,7},{22,7}}, color={255,0,255}));
connect(twochiller_on.active, or3.u1) annotation (Line(points={{-308,-3},{
        -288,-3},{-288,-8},{-202,-8},{-202,-20},{-186,-20}}, color={255,0,255}));
connect(threechiller_on.active, or3.u2) annotation (Line(points={{-310,-35},{
        -310,-42},{-202,-42},{-202,-28},{-186,-28}}, color={255,0,255}));
connect(or3.y, chi2.on) annotation (Line(points={{-163,-20},{-74,-20},{-74,
        -17},{22,-17}}, color={255,0,255}));
connect(threechiller_on.active, chi3.on) annotation (Line(points={{-310,-35},
        {-310,-80},{-2,-80},{-2,-47},{22,-47}}, color={255,0,255}));
annotation (
  Icon(coordinateSystem(preserveAspectRatio=false)),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  uses(Modelica(version="4.1.0"), Buildings(version="13.0.0")));
end MiniProject3_1;
