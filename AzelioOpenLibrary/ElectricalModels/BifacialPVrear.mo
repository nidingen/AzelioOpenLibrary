within AzelioOpenLibrary.ElectricalModels;

model BifacialPVrear
  Modelica.Blocks.Interfaces.RealInput G_DHI(unit = "W/m2") "Diffuse Horizontal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput G_DNI(unit = "W/m2") "Direct Normal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Azim(unit = "rad") "Solar Azimuth angle" annotation(Placement(visible = true, transformation(origin = {-155, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Sun_Elev(unit = "rad") "Solar Elevation angle" annotation(Placement(visible = true, transformation(origin = {-155, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput G_GHI(unit = "W/m2") "Global Horizontal Irradiance" annotation(Placement(visible = true, transformation(origin = {-155, 35}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput G_R_Tot(unit = "W/m2") "Total Irradiance on collector" annotation(Placement(visible = true, transformation(origin = {143.729, -26.518}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput G_R(unit = "W/m2") "Total useful irradiance on collector" annotation(Placement(visible = true, transformation(origin = {146.229, 0.966}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Boolean Tracking = true "True for single-axis tracking E-W, false for fixed tilt";
  parameter Real Lat(unit = "deg") = 31.03 "Location latitude";
  parameter Real EASL(unit = "m") = 1258 "Elevation above sea level at location";
  parameter Real Alb = 0.2 "Ground albedo coefficient";
  parameter Real D(unit = "m") "Spacing between two rows of modules";
  parameter Real H0(unit = "m") "PV module height above ground";
  parameter Real H(unit = "m") "PV module length";
  constant Real nref = 1.526 "Effective index of refraction of the cell cover";
  constant Real K_gl(unit = "m-1") = 4 "Glazing extinction coefficient";
  constant Real L_gl(unit = "m") = 0.002 "Glazing thickness";
  Real Sun_Zen(unit = "rad") "Sun Zenith angle";
  Real PV_track(unit = "rad") "PV tracking axis angle";
  Real PV_Azim(unit = "rad") "PV azimuth angle";
  Real beta_ref(unit = "rad") "Reference tilt angle";
  Real beta_c(unit = "rad") "Tilt";
  Real rot(unit = "rad") "Surface rotation angle about tracking axis";
  Real delta(unit = "rad") "View factor rear-sky angle";
  Real eps(unit = "rad") "View factor rear-ground angle";
  Real d(unit = "m") "distance for rear-ground view factor";
  Real VF_R_Sky "View factor rear-sky";
  Real VF_R_G "View factor rear-ground";
  Real G_d(unit = "W/m2") "Diffuse Irradiance on collector";
  Real G_g(unit = "W/m2") "Ground reflectes Irradiance on collector";
  Real theta_d(unit = "rad") "Effective incidence of diffused irradiance";
  Real theta_g(unit = "rad") "Effective incidence of reflected irradiance";
  Real theta_r(unit = "rad") "Referemce angle, 1 deg";
  Real theta_td(unit = "rad") "Refraction angle for diffused irradiance";
  Real theta_tg(unit = "rad") "Refraction angle for ground reflected irradiance";
  Real theta_tr(unit = "rad") "Refraction angle for reference";
  Real trans_d_temp "Diffuse transmittance";
  Real trans_g_temp "Reflected transmittance";
  Real trans_d "Diffuse transmittance";
  Real trans_g "Reflected transmittance";
  Real trans_0 "Reference transmittance";
  Real IAM_d "Incidence angle modifier for diffused irradiance";
  Real IAM_g "Incidence angle modifier for ground reflected irradiance";
  Real AM "Air mass";
  Real M "Air mass modifier";
equation
  Sun_Zen = 0.5 * Modelica.Constants.pi - Sun_Elev;
  if noEvent(Lat >= 0) then
    PV_track = Modelica.Constants.pi;
  else
    PV_track = 0;
  end if;
  if noEvent(abs(Lat) > 65) then
    beta_ref = Modelica.Constants.pi - Modelica.SIunits.Conversions.from_deg(0.224 * abs(Lat) + 33.6);
  else
    beta_ref = Modelica.Constants.pi - Modelica.SIunits.Conversions.from_deg(0.764 * abs(Lat) + 2.1);
  end if;
  if Tracking then
    rot = atan(tan(Sun_Zen) * sin(Sun_Azim - PV_track));
    beta_c = Modelica.Constants.pi - abs(rot);
    if noEvent(abs(beta_c) > 0) then
      if noEvent(sin(rot) / sin(beta_c) <= (-1)) then
        PV_Azim = PV_track - 0.5 * Modelica.Constants.pi;
      elseif noEvent(sin(rot) / sin(beta_c) >= 1) then
        PV_Azim = PV_track + 0.5 * Modelica.Constants.pi;
      else
        PV_Azim = PV_track + asin(sin(rot) / sin(beta_c));
      end if;
    else
      PV_Azim = PV_track;
    end if;
  else
    rot = 0;
    beta_c = beta_ref;
    PV_Azim = PV_track;
  end if;
  delta = atan((D + 0.5 * H * cos(beta_c)) / (0.5 * H * sin(beta_c)));
  VF_R_Sky = 0.5 * (sin(delta) - cos(beta_c));
  if noEvent(sin(beta_c) < 0 or sin(beta_c) > 0) then
    eps = atan((D - H * cos(beta_c)) / (H * sin(beta_c)));
    d = H0 * tan(eps);
  else
    eps = 0;
    d = 0;
  end if;
  VF_R_G = (H + sqrt(H0 ^ 2 + (D + d) ^ 2) - sqrt((D - H * cos(beta_c) + d) ^ 2 + (H * sin(beta_c) + H0) ^ 2)) / (2 * H);
  G_d = if noEvent(G_DHI * VF_R_Sky < 0) then 0 else G_DHI * VF_R_Sky;
  G_g = if noEvent(G_GHI * Alb * VF_R_G < 0) then 0 else G_GHI * Alb * VF_R_G;
  G_R_Tot = G_d + G_g;
  theta_d = Modelica.SIunits.Conversions.from_deg(59.68 - 0.1388 * Modelica.SIunits.Conversions.to_deg(beta_c) + 0.001497 * Modelica.SIunits.Conversions.to_deg(beta_c) ^ 2);
  theta_g = Modelica.SIunits.Conversions.from_deg(90.00 - 0.5788 * Modelica.SIunits.Conversions.to_deg(beta_c) + 0.002693 * Modelica.SIunits.Conversions.to_deg(beta_c) ^ 2);
  theta_r = Modelica.SIunits.Conversions.from_deg(1);
  theta_td = asin(sin(theta_d) / nref);
  theta_tg = asin(sin(theta_g) / nref);
  theta_tr = asin(sin(theta_r) / nref);
  trans_d_temp = exp(-K_gl * L_gl / cos(theta_td)) * (1 - 0.5 * (sin(theta_td - theta_d) ^ 2 / sin(theta_td + theta_d) ^ 2 + tan(theta_td - theta_d) ^ 2 / tan(theta_td + theta_d) ^ 2));
  trans_g_temp = exp(-K_gl * L_gl / cos(theta_tg)) * (1 - 0.5 * (sin(theta_tg - theta_g) ^ 2 / sin(theta_tg + theta_g) ^ 2 + tan(theta_tg - theta_g) ^ 2 / tan(theta_tg + theta_g) ^ 2));
  if noEvent(trans_d_temp < 0) then
    trans_d = 0;
  else
    trans_d = trans_d_temp;
  end if;
  if noEvent(trans_g_temp < 0) then
    trans_g = 0;
  else
    trans_g = trans_g_temp;
  end if;
  trans_0 = exp(-K_gl * L_gl / cos(theta_tr)) * (1 - 0.5 * (sin(theta_tr - theta_r) ^ 2 / sin(theta_tr + theta_r) ^ 2 + tan(theta_tr - theta_r) ^ 2 / tan(theta_tr + theta_r) ^ 2));
  IAM_d = if noEvent(trans_d / trans_0 < 0) then 0 else trans_d / trans_0;
  IAM_g = if noEvent(trans_g / trans_0 < 0) then 0 else trans_g / trans_0;
  if noEvent(Sun_Zen >= Modelica.SIunits.Conversions.from_deg(86)) then
    AM = (cos(Modelica.SIunits.Conversions.from_deg(86)) + 0.5057 * (96.080 - 86) ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  elseif noEvent(Sun_Zen <= 0) then
    AM = (1 + 0.5057 * 96.080 ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  else
    AM = (cos(Sun_Zen) + 0.5057 * (96.080 - Modelica.SIunits.Conversions.to_deg(Sun_Zen)) ^ (-1.634)) ^ (-1) * exp(-0.0001184 * EASL);
  end if;
  M = 0.918093 + 0.086257 * AM - 0.024459 * AM ^ 2 + 0.002816 * AM ^ 3 - 0.000126 * AM ^ 4;
  G_R = M * (G_d * IAM_d + G_g * IAM_g);
  annotation(Documentation(info = "<p>This block models the total incident irradiance <em>G<sub>r&nbsp;</sub></em>[W] on the rear of a bifacial PV module, based on a simplified model from a Master thesis from TU Delft [1]</p>
<p>Incident irradiance is calculated as function of the tilt angle and view factors between the rear side ant the ground and rear side and the sky. No DNI is assumed to reach the rear side.&nbsp;</p>
<p><em>G<sub>r</sub> = M &middot; (G<sub>d</sub> &middot; IAM<sub>d</sub> + G<sub>g</sub> &middot; IAM<sub>g</sub>) = M &middot; (DHI&middot; VF<sub>rear-sky</sub>&middot; IAM<sub>d</sub>&nbsp;+ <span style=\"font-family: symbol;\">r</span>&nbsp;&middot; GHI &middot; VF<sub>rear-ground</sub> &middot; IAM<sub>g</sub>)</em></p>
<p>where incidence angle modifiers are determined as in a normal PV module (see description for the front side of the bifacial PV), but the tilt angle is now cosidered the supplementary angle</p>
<p><em><span style=\"font-family: symbol;\">b</span><sub>rear</sub> = 180 - <span style=\"font-family: symbol;\">b</span><sub>front</sub></em></p>
<p>View factors are calculated as following</p>
<p><em>VF<sub>rear-sky</sub> = (sin<span style=\"font-family: symbol;\">d</span> - cos<span style=\"font-family: symbol;\">b</span>)/2</em></p>
<p><em>VF<sub>rear-ground</sub> = [H + sqrt(H<sub>0</sub><sup>2</sup> + (D + d)<sup>2</sup>) - sqrt((D - H&nbsp;&middot; cos<span style=\"font-family: symbol;\">b</span> + d)<sup>2</sup> + (H&nbsp;&middot; sin<span style=\"font-family: symbol;\">b</span> + H<sub>0</sub>)<sup>2</sup>)]/(2&nbsp;&middot; H)</em></p>
<p>See figures for reference angles:</p>
<p>&nbsp;<img src=\"C:\\Users\\niccolo.oggiono\\OneDrive - Cleanergy\\Master Thesis\\Modelling\\Definitive Models\\D.jpg\" alt=\"\" width=\"380\" height=\"205\" /></p>
<p><img src=\"C:\\Users\\niccolo.oggiono\\OneDrive - Cleanergy\\Master Thesis\\Modelling\\Definitive Models\\delta.jpg\" alt=\"\" width=\"388\" height=\"177\" /></p>
<p><em>&nbsp;</em></p>
<p>&nbsp;</p>
<h3>References</h3>
<p>[1] Sundeep Reddy Gali, R., 2017. \"Energy Yield Model for Bifacial PV Systems: A study and analysis of temperature and rear irradiance models\". Delft University of Technology.</p>
<p>&nbsp;</p>", revisions = ""), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Rectangle(visible = true, origin = {0, 1.965}, lineColor = {149, 23, 41}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 2.5, extent = {{-50, -50}, {50, 50}}), Polygon(visible = true, origin = {0.297, -66.13}, lineColor = {149, 23, 41}, fillColor = {149, 23, 41}, lineThickness = 2.5, points = {{-4.305, 18.037}, {-4.305, 0.67}, {-14.769, -1.905}, {-14.769, -11.905}, {-0.297, -17.142}, {14.843, -11.905}, {14.843, -1.905}, {4.379, 1.338}, {4.379, 18.037}}), Line(visible = true, origin = {-40, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {-30, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {-20, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {-10, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {10, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {30, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {40, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {20, 1.965}, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, 41.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, 31.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, 21.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, 11.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, 1.965}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, -8.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, -28.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, -38.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Line(visible = true, origin = {0, -18.035}, rotation = -90, points = {{0, 44.718}, {0, -44.718}}, color = {149, 23, 41}, thickness = 2.5), Text(visible = true, origin = {0, 70}, textColor = {149, 23, 41}, extent = {{-75, -16.216}, {75, 16.216}}, textString = "REAR", textStyle = {TextStyle.Bold})}), experiment(__Wolfram_SynchronizeWithRealTime = false), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end BifacialPVrear;
