within AzelioOpenLibrary.Utilities;

model StartTime "Allows setting of start time"
  parameter Real day = 0 annotation(Dialog(group = "Start time"));
  parameter Real hour = 0 annotation(Dialog(group = "Start time"));
  parameter Real minute = 0 annotation(Dialog(group = "Start time"));
  Real t_start;
  Modelica.Blocks.Interfaces.RealOutput t_out_s annotation(Placement(transformation(extent = {{96, 50}, {116, 70}}, origin = {0, 0}, rotation = 0), visible = true, iconTransformation(origin = {100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput t_out_h annotation(Placement(transformation(extent = {{96, -50}, {116, -70}}, origin = {0, 0}, rotation = 0), visible = true, iconTransformation(origin = {100, -0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput t_out_h_day annotation(Placement(visible = true, transformation(origin = {244.77, -13.846}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  t_start = ((day * 24 + hour) * 60 + minute) * 60;
  t_out_s = t_start + time;
  t_out_h = t_out_s / 3600;
  t_out_h_day = mod(t_out_h, 24);
  annotation(Documentation(info = "<html><p>This model allows to select the start time, independently from the start stime in the simulation settings.</p></html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, lineColor = {128, 128, 128}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 5, extent = {{-97, -97}, {97, 97}}, radius = 20), Ellipse(visible = true, origin = {2.611, -9.041}, lineColor = {149, 23, 41}, fillColor = {255, 255, 255}, lineThickness = 10, extent = {{-70.959, -70.959}, {70.959, 70.959}}), Line(visible = true, origin = {23.539, 10.622}, points = {{-20.236, -20.622}, {3.246, 7.861}, {13.157, 11.23}, {10.089, 1.018}, {-20.236, -20.622}}, color = {149, 23, 41}, thickness = 8), Rectangle(visible = true, origin = {1.77, 72.187}, lineColor = {149, 23, 41}, fillColor = {255, 255, 255}, lineThickness = 8, extent = {{-10.029, -6.02}, {10.029, 6.02}}), Rectangle(visible = true, origin = {0.973, 84.103}, lineColor = {149, 23, 41}, fillColor = {255, 255, 255}, lineThickness = 8, extent = {{-20.973, -5.897}, {20.973, 5.897}}), Line(visible = true, origin = {1.652, 18.891}, rotation = 45, points = {{-20.236, -20.622}, {11.472, 18.381}, {23.991, 22.458}, {20.83, 9.023}, {-20.236, -20.622}}, color = {149, 23, 41}, thickness = 8)}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end StartTime;
