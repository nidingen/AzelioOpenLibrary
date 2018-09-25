within AzelioOpenLibrary.PowerCycleModels;

model StirlingGasChannel8_6_19 "Stirling engine working gas channel"
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Qh_port "Heat flow to gas heater [W]" annotation(Placement(visible = true, transformation(origin = {-150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102.093, 22.695}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Qc_port "Heat flow to gas cooler [W]" annotation(Placement(visible = true, transformation(origin = {0, -103.028}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Q_losses_port "Heat flow losses from engine [W]" annotation(Placement(visible = true, transformation(origin = {150, -103.329}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -97.745}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput nshaft "Shaft speed [rpm]" annotation(Placement(visible = true, transformation(origin = {-40, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-31.72, 97.513}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput pme "Mean working gas pressure in the engine [bar]" annotation(Placement(visible = true, transformation(origin = {40, 110}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {30, 97.957}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput HTCc "Heat transfer coefficient on the liquid side in the gas cooler [W/m2.K]" annotation(Placement(visible = true, transformation(origin = {20, -110}, extent = {{-20, -20}, {20, 20}}, rotation = -270), iconTransformation(origin = {30, -100}, extent = {{-20, -20}, {20, 20}}, rotation = -270)));
  Modelica.Blocks.Interfaces.RealInput HTCh "Heat transfer coefficient on the liquid side in the gas heater [W/m2.K]" annotation(Placement(visible = true, transformation(origin = {-153.155, -10}, extent = {{-20, -20}, {20, 20}}, rotation = -360), iconTransformation(origin = {-97.002, -22.427}, extent = {{-20, -20}, {20, 20}}, rotation = -360)));
  Modelica.Blocks.Interfaces.RealOutput Wt(start = 0) "Thermodynamic work [W]" annotation(Placement(visible = true, transformation(origin = {156.533, 0}, extent = {{-16.533, -16.533}, {16.533, 16.533}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.SIunits.Energy E_Qh;
  Modelica.SIunits.Energy E_wt;
  constant Real Qh_k = 1286.13686153468;
  constant Real Qh_n = -0.471403364941752;
  constant Real Qh_pme = -33.7435177537525;
  constant Real Qh_Tc = -0.97076318105971;
  constant Real Qh_HTCc = -0.372987346213383;
  constant Real Qh_Th = -1.040683587248;
  constant Real Qh_n_pme = 0.127030701853311;
  constant Real Qh_n_Tc = 0.000852419561584182;
  constant Real Qh_n_HTCc = 0.000137333472787942;
  constant Real Qh_n_Th = 0.00177606814691652;
  constant Real Qh_n_2 = -2.77323930768409E-09;
  constant Real Qh_pme_Tc = -0.0191466290358909;
  constant Real Qh_pme_HTCc = 0.000186643217100928;
  constant Real Qh_pme_Th = 0.0936357090387587;
  constant Real Qh_pme_2 = 0.0178130195841688;
  constant Real Qh_HTCc_2 = 4.01346230597176E-05;
  constant Real Qh_Th_2 = 0.00112672529087316;
  constant Real Qh_n_pme_Tc = -0.000175316426593906;
  constant Real Qh_n_pme_HTCc = 1.96075761193788E-06;
  constant Real Qh_n_pme_Th = 8.88296733224205E-05;
  constant Real Qh_n2_pme = -5.73732556957263E-06;
  constant Real Qh_n_pme2 = -8.75051300180521E-05;
  constant Real Qh_pme_HTCc2 = -2.68522767338339E-07;
  constant Real Qh_pme2_HTCc = 7.65596701058712E-06;
  constant Real Qh_n_HTCc2 = -1.79778500100072E-08;
  constant Real Qh_n_Th2 = -1.6130790641195E-06;
  constant Real Qh_pme_Th2 = -0.000051676817485379;
  constant Real Qc_k = 619.32476403897;
  constant Real Qc_n = -0.327295569887531;
  constant Real Qc_pme = -44.1508040185245;
  constant Real Qc_Tc = 0.999437492673986;
  constant Real Qc_HTCc = -0.0263646540738208;
  constant Real Qc_Th = -2.91970246409281;
  constant Real Qc_n_pme = -0.0742399961970836;
  constant Real Qc_n_Tc = 0.000204121286640034;
  constant Real Qc_n_HTCc = 2.00903207142723E-05;
  constant Real Qc_n_Th = 0.00242529099316374;
  constant Real Qc_n_2 = -0.000316841709423426;
  constant Real Qc_pme_Tc = 0.0854307882168122;
  constant Real Qc_pme_HTCc = -0.000303804113489534;
  constant Real Qc_pme_Th = 0.0222601368395007;
  constant Real Qc_pme_2 = 0.077244098113476;
  constant Real Qc_Tc_2 = 0.000683741891618701;
  constant Real Qc_HTCc_2 = 3.31407214939128E-06;
  constant Real Qc_Th_2 = 0.00191759239582466;
  constant Real Qc_n_pme_Tc = -4.69101595773424E-05;
  constant Real Qc_n_pme_HTCc = 1.93186325382798E-07;
  constant Real Qc_n_pme_Th = 2.58976681694079E-05;
  constant Real Qc_n2_pme = -0.000001724775040899;
  constant Real Qc_n_pme2 = -3.05653027750587E-05;
  constant Real Qc_pme_HTCc2 = 3.73987841195399E-09;
  constant Real Qc_pme2_HTCc = -2.14167082032363E-07;
  constant Real Qc_n_HTCc2 = -2.31577064742613E-09;
  constant Real Qc_n_Th2 = -1.08310219144027E-06;
  constant Real Qc_pme_Th2 = -1.92508687816029E-05;
  constant Real Wt_k = 12844.8840793348;
  constant Real Wt_n = -5.10095521520562;
  constant Real Wt_pme = -62.0363319317773;
  constant Real Wt_Tc = -25.6355112576031;
  constant Real Wt_HTCc = -0.483338729453415;
  constant Real Wt_Th = -19.4267898100617;
  constant Real Wt_n_pme = 0.0508155647032289;
  constant Real Wt_n_Tc = -0.00274354463839049;
  constant Real Wt_n_HTCc = 0.000189360050560291;
  constant Real Wt_n_Th = 0.0125662054154015;
  constant Real Wt_n_2 = 0.00020962901689107;
  constant Real Wt_pme_Tc = -0.036755803759622;
  constant Real Wt_pme_HTCc = 8.34048521510777E-05;
  constant Real Wt_pme_Th = 0.163560008971467;
  constant Real Wt_pme_2 = 0.0266271010721338;
  constant Real Wt_Tc_2 = 0.0441244823545153;
  constant Real Wt_HTCc_2 = 5.32381660631368E-05;
  constant Real Wt_Th_2 = 0.0117034952226359;
  constant Real Wt_n_pme_Tc = -0.000194378328386152;
  constant Real Wt_n_pme_HTCc = 2.55549791284905E-06;
  constant Real Wt_n_pme_Th = 0.000113272400064762;
  constant Real Wt_n2_pme = -1.11611167974124E-05;
  constant Real Wt_n_pme2 = -0.000119428794644974;
  constant Real Wt_pme_HTCc2 = -3.33096514113394E-07;
  constant Real Wt_pme2_HTCc = 9.24907597024687E-06;
  constant Real Wt_n_HTCc2 = -2.46224409867817E-08;
  constant Real Wt_n_Th2 = -7.66179927973927E-06;
  constant Real Wt_pme_Th2 = -0.000108349089837757;
  Real Th(start = 300) "Abbreviation of Qh_port.T";
  Real Tc(start = 300) "Abbreviation of Qc_port.T";
  Real sumFlows "Should be zero";
  // Engine-On variables:
equation
  Th = Qh_port.T;
  Tc = Qc_port.T;
  der(E_Qh) = Qh_port.Q_flow;
  der(E_wt) = Wt;
  sumFlows = Qh_port.Q_flow + Qc_port.Q_flow + Q_losses_port.Q_flow - Wt;
  Qh_port.Q_flow + Qc_port.Q_flow - Wt + Q_losses_port.Q_flow = 0;
  //if noEvent(nshaft > 0 and pme > 0) then
  if noEvent(nshaft > 0 and pme > 0) then
    Qh_port.Q_flow = Qh_k + Qh_n * nshaft + Qh_pme * pme + Qh_Tc * Tc + Qh_HTCc * HTCc + Qh_Th * Th + Qh_n_pme * nshaft * pme + Qh_n_Tc * nshaft * Tc + Qh_n_HTCc * nshaft * HTCc + Qh_n_Th * nshaft * Th + Qh_n_2 * nshaft * nshaft + Qh_pme_Tc * pme * Tc + Qh_pme_HTCc * pme * HTCc + Qh_pme_Th * pme * Th + Qh_pme_2 * pme * pme + Qh_HTCc_2 * HTCc * HTCc + Qh_Th_2 * Th * Th + Qh_n_pme_Tc * nshaft * pme * Tc + Qh_n_pme_HTCc * nshaft * pme * HTCc + Qh_n_pme_Th * nshaft * pme * Th + Qh_n2_pme * nshaft * nshaft * pme + Qh_n_pme2 * nshaft * pme * pme + Qh_pme_HTCc2 * pme * HTCc * HTCc + Qh_pme2_HTCc * pme * pme * HTCc + Qh_n_HTCc2 * nshaft * HTCc * HTCc + Qh_n_Th2 * nshaft * Th * Th + Qh_pme_Th2 * pme * Th * Th;
    // Removed a minus in Qc_port.Q_flow. Flow is now negative, i.e. going from the engine to the cooler.
    Qc_port.Q_flow = Qc_k + Qc_n * nshaft + Qc_pme * pme + Qc_Tc * Tc + Qc_HTCc * HTCc + Qc_Th * Th + Qc_n_pme * nshaft * pme + Qc_n_Tc * nshaft * Tc + Qc_n_HTCc * nshaft * HTCc + Qc_n_Th * nshaft * Th + Qc_n_2 * nshaft * nshaft + Qc_pme_Tc * pme * Tc + Qc_pme_HTCc * pme * HTCc + Qc_pme_Th * pme * Th + Qc_pme_2 * pme * pme + Qc_Tc_2 * Tc * Tc + Qc_HTCc_2 * HTCc * HTCc + Qc_Th_2 * Th * Th + Qc_n_pme_Tc * nshaft * pme * Tc + Qc_n_pme_HTCc * nshaft * pme * HTCc + Qc_n_pme_Th * nshaft * pme * Th + Qc_n2_pme * nshaft * nshaft * pme + Qc_n_pme2 * nshaft * pme * pme + Qc_pme_HTCc2 * pme * HTCc * HTCc + Qc_pme2_HTCc * pme * pme * HTCc + Qc_n_HTCc2 * nshaft * HTCc * HTCc + Qc_n_Th2 * nshaft * Th * Th + Qc_pme_Th2 * pme * Th * Th;
    Wt = Wt_k + Wt_n * nshaft + Wt_pme * pme + Wt_Tc * Tc + Wt_HTCc * HTCc + Wt_Th * Th + Wt_n_pme * nshaft * pme + Wt_n_Tc * nshaft * Tc + Wt_n_HTCc * nshaft * HTCc + Wt_n_Th * nshaft * Th + Wt_n_2 * nshaft * nshaft + Wt_pme_Tc * pme * Tc + Wt_pme_HTCc * pme * HTCc + Wt_pme_Th * pme * Th + Wt_pme_2 * pme * pme + Wt_Tc_2 * Tc * Tc + Wt_HTCc_2 * HTCc * HTCc + Wt_Th_2 * Th * Th + Wt_n_pme_Tc * nshaft * pme * Tc + Wt_n_pme_HTCc * nshaft * pme * HTCc + Wt_n_pme_Th * nshaft * pme * Th + Wt_n2_pme * nshaft * nshaft * pme + Wt_n_pme2 * nshaft * pme * pme + Wt_pme_HTCc2 * pme * HTCc * HTCc + Wt_pme2_HTCc * pme * pme * HTCc + Wt_n_HTCc2 * nshaft * HTCc * HTCc + Wt_n_Th2 * nshaft * Th * Th + Wt_pme_Th2 * pme * Th * Th;
  else
    Qh_port.Q_flow = 0;
    Qc_port.Q_flow = 0;
    Wt = 0;
  end if;
  annotation(Documentation(info = "<p><strong>Description</strong></p>
<p>This is a model of a Stirling engine gas channel.</p>
<p>It models the working gas channel (WGC) 8.6, tested in Azelio's development lab in 2018. Details on the testing and modeling can be found in [1]. The gas channel has 0.18200 m<sup>2</sup> of heat transfer surface area to the heating liquid, and 0.16666 m<sup>2</sup> of heat transfer area to the cooling liquid.</p>
<p>It outputs thermodynamic work wt (pressure-volume work) while interacting with a heat source (Qh) and a heat sink (Qc). There is also a heat port for the heat loss to the engine block cooling water (Q_losses). To obtain mechanical (shaft) work, internal losses, e.g. friction, need to be subtracted.</p>
<p>The model takes a few inputs:</p>
<ul>
<li>Engine shaft speed [rpm]. Permissible values are 1000-2000 rpm.</li>
<li>Engine working gas mean pressure [bar]. Permissible values are 50-150 bar.</li>
<li>Heat transfer coefficient on the hot side [W/m2K]. Permissible values are 15000-25000 W/m2K.</li>
<li>Heat transfer coefficient on the cold side [W/m2K]. Permissible values are 3000-8000 W/m2K.</li>
</ul>
<p>Furthermore, the model is valid for hot end temperatures between 800-1200K and cold end temperatures between 273-333K.</p>
<p>Note that the model itself does not check if the permissible limits are kept or not.</p>
<p>This model is a polynomial curve fit of results obtained with Azelio's in-house code for the Stirling cycle, SQUID [2]. The fit has less than 1.5% error relative in&nbsp;the operating envelope.</p>
<p><strong>References</strong></p>
<p>1. M. Nilsson et al, \"A Stirling Engine for Thermal Energy Storage\", Proceedings of SolarPACES2018, Casablanca, Morocco, 2018</p>
<p>2.&nbsp;<span class=\"fontstyle0\">N. Andersson, L.-E. Eriksson, M. Nilsson, \"Numerical Simulation of Stirling Engines Using an Unsteady QuasiOne-Dimensional Approach\", Journal of Fluids Engineering - Transactions of The ASME (0098-2202), Vol. 137&nbsp;(2015), 5, p. Art. no. 051104, 2015</span></p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {-0.179, -0.717}, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 25), Text(visible = true, origin = {0.729, -60}, textColor = {149, 23, 41}, extent = {{-90.729, -23.514}, {90.729, 23.514}}, textString = "%name"), Line(visible = true, origin = {-46.192, 9.484}, points = {{-25.955, 57.715}, {-23.808, -33.967}, {-28.299, -33.967}, {-33.808, -12.609}, {-28.299, 12.916}, {-21.267, 28.804}, {-13.808, 30.516}, {-10.067, 23.594}, {-1.993, -9.484}, {-3.808, -29.484}, {-5.379, -33.186}, {-8.765, -33.186}, {-10.849, -9.484}, {-7.723, 7.967}, {-3.808, 23.074}, {0.872, 30.516}, {8.425, 25.157}, {16.192, 7.967}, {18.583, -15.995}, {14.155, -41.781}, {9.467, -9.484}, {12.593, 10.516}, {16.192, 24.636}, {21.188, 30.516}, {28.481, 12.134}, {34.211, -9.484}, {34.211, -26.414}, {31.606, -33.186}}, color = {0, 148, 222}, thickness = 5, arrowSize = 7, smooth = Smooth.Bezier), Line(visible = true, origin = {36.314, 8.163}, points = {{-50.9, -32.907}, {-54.286, -26.395}, {-54.286, 5.902}, {-43.607, 39.241}, {-38.398, 5.12}, {-36.314, -18.163}, {-30.844, -38.163}, {-20.165, -6.6}, {-20.165, 19.967}, {-23.03, 36.375}, {-28.761, 1.837}, {-18.603, -28.163}, {-13.133, -34.73}, {-6.314, -21.186}, {-0.37, 1.837}, {-4.277, 40.282}, {-9.487, -0.349}, {-4.277, -20.144}, {3.686, -30.823}, {8.485, -30.823}, {13.686, -18.163}, {18.643, 4.86}, {18.643, 24.134}, {13.686, 31.837}, {11.09, 25.957}, {11.09, 6.162}, {15.518, -20.405}, {20.727, -32.646}, {28.541, -32.646}, {33.686, -20.405}, {35.833, -8.163}, {38.438, 17.101}, {36.875, 29.083}, {33.686, 33.51}, {31.406, 41.837}, {31.406, 57.994}}, color = {149, 23, 41}, thickness = 5, smooth = Smooth.Bezier)}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end StirlingGasChannel8_6_19;
