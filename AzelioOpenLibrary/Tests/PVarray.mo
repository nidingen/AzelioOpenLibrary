within AzelioOpenLibrary.Tests;

model PVarray
  extends AzelioOpenLibrary.Icons.ExampleIcon;
  Modelica.Blocks.Sources.RealExpression Hourly_input(y = time / 3600) annotation(Placement(visible = true, transformation(origin = {-127.5, 0}, extent = {{-12.5, -10}, {12.5, 10}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.PVarray PV_(Lat = 31.03, Tracking = true, I_SC = 6.39, alpha_SC = 0.00085, NOCT = 44.5 + 273.15, shad = 0, soil = 0, mism = 0, cab = 0, eta_ref = 0.215) annotation(Placement(visible = true, transformation(origin = {19.891, 0.109}, extent = {{-40.109, -40.109}, {40.109, 40.109}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds TMY(tableOnFile = true, tableName = "TMY", fileName = "TMY_2005.txt", columns = 2:9) annotation(Placement(visible = true, transformation(origin = {-93.467, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AzelioOpenLibrary.Utilities.Radians_Conv Angle_Converter annotation(Placement(visible = true, transformation(origin = {-47.5, -17.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0)));
  AzelioOpenLibrary.ElectricalModels.GenericInverter Inverter_ annotation(Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Hourly_input.y, TMY.u) annotation(Line(visible = true, origin = {-109.608, 0}, points = {{-4.142, 0}, {4.141, 0}}, color = {1, 37, 163}));
  connect(TMY.y[1], PV_.G_GHI) annotation(Line(visible = true, origin = {-60.671, 16.098}, points = {{-21.796, -16.098}, {-9.329, -16.098}, {-9.329, 20.109}, {40.453, 20.109}}, color = {1, 37, 163}));
  connect(TMY.y[2], PV_.G_DHI) annotation(Line(visible = true, origin = {-60.671, 10.082}, points = {{-21.796, -10.082}, {-9.329, -10.082}, {-9.329, 14.092}, {40.453, 14.092}}, color = {1, 37, 163}));
  connect(TMY.y[3], PV_.G_DNI) annotation(Line(visible = true, origin = {-60.671, 4.065}, points = {{-21.796, -4.065}, {-9.329, -4.065}, {-9.329, 8.077}, {40.453, 8.077}}, color = {1, 37, 163}));
  connect(TMY.y[4], PV_.T_Amb) annotation(Line(visible = true, origin = {-60.671, -3.957}, points = {{-21.796, 3.957}, {40.453, 4.066}}, color = {1, 37, 163}));
  connect(TMY.y[5], Angle_Converter.Sun_Elev_deg) annotation(Line(visible = true, origin = {-71.554, -9.375}, points = {{-10.913, 9.375}, {1.554, 9.375}, {1.554, -1.875}, {12.804, -1.875}}, color = {1, 37, 163}));
  connect(Angle_Converter.Sun_Azim_rad, PV_.Sun_Azim) annotation(Line(visible = true, origin = {-25.439, -31.614}, points = {{-9.561, 7.864}, {5.221, 7.658}}, color = {1, 37, 163}));
  connect(TMY.y[6], Angle_Converter.Sun_Azim_deg) annotation(Line(visible = true, origin = {-86.554, -34.375}, points = {{4.087, 34.375}, {16.554, 34.375}, {16.554, 10.625}, {27.804, 10.625}}, color = {1, 37, 163}));
  connect(Angle_Converter.Sun_Elev_rad, PV_.Sun_Elev) annotation(Line(visible = true, origin = {-25.439, -19.348}, points = {{-9.561, 8.098}, {5.221, 7.424}}, color = {1, 37, 163}));
  connect(TMY.y[8], PV_.w) annotation(Line(visible = true, origin = {-60.671, -17.995}, points = {{-21.796, 17.995}, {-9.329, 17.995}, {-9.329, -17.995}, {40.453, -17.994}}, color = {1, 37, 163}));
  connect(PV_.P_DC, Inverter_.P_DC) annotation(Line(visible = true, origin = {73.494, 0.054}, points = {{-13.494, 0.054}, {3.494, 0.054}, {3.494, -0.054}, {6.506, -0.054}}, color = {1, 37, 163}));
  connect(PV_.P_nom1, Inverter_.P_nom) annotation(Line(visible = true, origin = {80, 16.776}, points = {{-20, 3.388}, {10, 3.388}, {10, -6.776}}, color = {1, 37, 163}));
  annotation(experiment(StopTime = 31536000, NumberOfIntervals = 8760, __Wolfram_Algorithm = "cvodes", Tolerance = 1e-10, __Wolfram_SynchronizeWithRealTime = false), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10})), Documentation(info = "<p>This model simulates the power output <em>P<sub>AC&nbsp;</sub></em>(W)&nbsp;and energy yield <em>E<sub>AC</sub></em> (J)&nbsp;of a solar park, based on NREL SAM procedure [1], using the following TMY data for a given location, when latitude and elevation above sea level <em>EASL</em> (m)&nbsp;are known:</p>
<ul>
<li>Global Horizontal Irradiance <em>G<sub>GHI</sub></em> (W/m<sup>2</sup>);</li>
<li>Diffuse Horizontal Irradiance <em>G<sub>DHI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Direct Normal Irradiance<em> G<sub>DNI</sub></em>&nbsp;(W/m<sup>2</sup>);</li>
<li>Ambient temperature <em>T<sub>Amb</sub></em> (&deg;C);</li>
<li>Solar azimuth angle <em>Azim<sub>Sun</sub></em> (rad);</li>
<li>Solar elevation angle <em>Elev<sub>Sun</sub></em> (rad);</li>
<li>Wind speed <em>w</em> (m/s).</li>
</ul>
<p>Regarding the PV module, it is necessary to know the following values, available from manufacturer datasheet:</p>
<ul>
<li>Short circuit current <em>I<sub>SC</sub></em> (A);</li>
<li>Current-temeperature coefficient <span style=\"font-family: symbol;\"><em>a</em></span>&nbsp;(A/K);</li>
<li>Nominal Operational Cell Temperature T<sub>NOCT</sub> (&deg;C);</li>
<li>Reference efficiency <span style=\"font-family: symbol;\">h</span>;</li>
<li>Number of soalr cells in a module <em>N<sub>cell</sub></em>;</li>
<li>Nominal module power <em>P<sub>nom</sub></em> (W).</li>
</ul>
<p>Firstly, it is necessary to select if the system includes a single-axis tracking system, to improve performance. This is done by selecting the boolean value \"true\" for the boolean variable \"Tracking\".</p>
<p>All angles are calculated in radians and all the temperatures are converted to Klevin. Sun Zenith <em>Zen<sub>Sun</sub></em> (rad)&nbsp;is determined as complementary angle of the solar elevation. The tracking axis angle <em>Track<sub>PV</sub></em> (rad) is assumed to be either zero (Southern Hemisphere) or pi (Northern Hemisphere).</p>
<p>Depending on the tracking system, the tilt angle of the collectors <em><span style=\"font-family: symbol;\">b</span><sub>c</sub></em> (rad), the rotation of the tracking angle <em>rot</em> (rad)&nbsp;and the actual collector azimuth angle <em>Azim<sub>PV</sub></em> (rad)&nbsp;are determined.</p>
<table style=\"height: 159px; margin-left: auto; margin-right: auto;\" width=\"439\">
<tbody>
<tr>
<td><strong>Fixed tilt&nbsp;</strong></td>
<td style=\"text-align: left;\"><strong>Single axis tracking</strong></td>
</tr>
<tr>
<td><em>rot = 0</em></td>
<td style=\"text-align: left;\"><em>rot = atan(tan(Zen<sub>Sun</sub>)&nbsp;<span style=\"font-family: symbol;\"><span style=\"font-family: verdana, geneva;\">&middot;&nbsp;</span></span>sin(Azim<sub>Sun</sub> - Azim<sub>PV</sub>))</em></td>
</tr>
<tr>
<td><em><span style=\"font-family: symbol;\">b</span><sub>c&nbsp;</sub>= f(Lat)</em></td>
<td style=\"text-align: left;\"><em>&nbsp;<span style=\"font-family: symbol;\">b</span><sub>c&nbsp;</sub>=&nbsp;abs(rot)</em></td>
</tr>
<tr>
<td><em>Azim<sub>PV</sub> = Track<sub>PV</sub></em></td>
<td style=\"text-align: left;\"><em>&nbsp;Azim<sub>PV</sub> = Track<sub>PV</sub> + asin(sin(rot) / sin(<span style=\"font-family: symbol;\">b</span><sub>c</sub>))</em></td>
</tr>
</tbody>
</table>
<p>At this point, the incidence angle <em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b</span></sub></span></em>&nbsp;(rad) and cosine efficiency cos(<em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b</span></sub></span></em>)&nbsp;can be calculated:&nbsp;</p>
<p><em><span style=\"font-family: symbol;\">q<sub><span style=\"font-family: verdana, geneva;\">b&nbsp;</span></sub><span style=\"font-family: verdana, geneva;\">= acos(cos(<span style=\"font-family: symbol;\">b</span><sub>c</sub>)&nbsp;&middot; cos(Zen<sub>Sun</sub>) + sin(<span style=\"font-family: symbol;\">b</span><sub>c</sub>)&nbsp;&middot; sin(Zen<sub>Sun</sub>)&nbsp;&middot; cos(Azim<sub>Sun&nbsp;</sub>- Azim<sub>PV</sub>))</span></span></em></p>
<p>Referring to [1], actual incidence angles for beam <em>G<sub>b </sub></em>(W), diffuse <em>G<sub>d</sub>&nbsp;</em>(W) and global irradiance <em>G<sub>g</sub></em>&nbsp;(W) are determined by&nbsp;multiplying TMY&nbsp;irradiance with incidence angle modifiers <em>IAM<sub>b</sub></em>, <em>IAM<sub>d</sub></em> and <em>IAM<sub>g</sub></em>&nbsp;based on trasmittance and optical properties of glass.&nbsp;</p>
<p>Air mass <em>AM</em> is determined and from it the air mass modifier coefficient <em>M</em> can be derived and used to finally obtain the usefuyl irradiance on the tilted collector <em>G</em> (W).</p>
<p><em>G = M&nbsp;<span style=\"font-family: symbol;\"><span style=\"font-family: verdana, geneva;\">&middot; (G<sub>b</sub>&nbsp;&middot; IAM<sub>b</sub> + G<sub>d</sub>&nbsp;&middot; IAM<sub>d</sub> + G<sub>g</sub>&nbsp;&middot; IAM<sub>g</sub>)</span></span></em></p>
<p>By introducing the transmittance-absorbance product <span style=\"font-family: symbol;\">ta</span>, the actual cell temperature is determined as function of this latest parameter, useful irradiance, reference current value, temperatures, wind speed and reference irradiance:</p>
<p><em>T<sub>PV</sub> = T<sub>Amb</sub> + (T<sub>NOCT</sub> - 293.15)</em>&nbsp;<em>&middot; (G / 800) &middot; (1 - <span style=\"font-family: symbol;\">h/ta</span>) &middot; (9.5 / ( 5.7 + 3.8&nbsp;&middot; 0.51&nbsp;&middot; w))</em></p>
<p>Subsequently, light current <em>I<sub>L</sub></em> (A), actual energy bandgap <em>E<sub>bg</sub></em> (eV) and dark saturation current <em>I<sub>darksat</sub></em> (A)&nbsp;are deteremined according to De Soto equations, used in [1].</p>
<p><em>I<sub>L</sub> = G&nbsp;&middot; (I<sub>SC</sub> + <span style=\"font-family: symbol;\">a</span> &middot; (T<sub>PV</sub> - 298.15)) / 1000</em></p>
<p><em>E<sub>bg</sub> = 1.121&nbsp;&middot; (1 - 0.000267&nbsp;&middot; (T<sub>PV</sub> - 298.15))</em></p>
<p><em>I<sub>darksat</sub> = I<sub>dark ref</sub> &middot; (T<sub>PV</sub>/298.15)<sup>3</sup> &middot; exp(((1.121 / &nbsp;298.15) - (E<sub>bg</sub>/ T<sub>PV</sub>)) / (8.6173303 &middot;10<sup>-5</sup>))</em></p>
<p><em>exp(e &middot; V<sub>MPP</sub> / (k &middot; T<sub>PV</sub>)) = (1 + I<sub>L</sub>/I<sub>darksat</sub>) / (1 + (e &middot; V<sub>MPP</sub> / (k &middot; T<sub>PV</sub>)))&nbsp;</em></p>
<p><em>IMPP =&nbsp;e &middot; V<sub>MPP</sub> &middot; (I<sub>L</sub> + I<sub>darksat</sub>) / (k &middot; T<sub>PV </sub>+ e &middot; V<sub>MPP</sub><span style=\"font-size: xx-small;\">)</span></em></p>
<p>Once maximum power point voltage <em>V<sub>MPP</sub></em> (V) and current <em>I<sub>MPP</sub></em> (A)&nbsp;are determined, the DC power output from a single cell, module <em>P<sub>MPP,M</sub></em>&nbsp;(W) and then for the entire solar park are calcualted, as well as the gross, DC energy yield, by introducing losses due to DC cables, mismatiching, shadowing and soiling.</p>
<p><em>P<sub>MPP,M</sub> = V<sub>MPP</sub> &middot; I<sub>MPP</sub> &middot; N<sub>cell</sub></em></p>
<p><em>P<sub>DC</sub> = P<sub>MPP,M</sub> &middot; N<sub>mod</sub> &middot; (1 - shad) &middot; (1 - soil) &middot; (1 - mism)&nbsp; &middot; (1 - cab)</em></p>
<p><em>d(P<sub>DC</sub>)/dt = E<sub>DC</sub></em></p>
<p>The inverter block determines the AC power and energy output by mean of inverter efficiency.</p>
<h2>References</h2>
<p>[1] SAM Photolvtaic Model Technical Reference Update, P. Gilman et al, National Renewable Energy Laboratory, 2018</p>
<p>&nbsp;</p>
<p>&nbsp;</p>", revisions = ""), Diagram(coordinateSystem(extent = {{-160, -60}, {120, 60}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end PVarray;
