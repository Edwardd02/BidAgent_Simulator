% Load the figures
fig1 = open('dataset_reference.fig');
fig2 = open('dataset.fig');

% Extract the axes handle and children
axes1 = get(fig1, 'CurrentAxes');
axes2 = get(fig2, 'CurrentAxes');
data1 = get(get(axes1, 'Children'), 'YData');
data2 = get(get(axes2, 'Children'), 'YData');

% Resample the data to a common set of points (linear interpolation)
x_common = linspace(min([axes1.XLim axes2.XLim]), max([axes1.XLim axes2.XLim]), max([length(data1) length(data2)]));
data1_interp = interp1(linspace(axes1.XLim(1), axes1.XLim(2), length(data1)), data1, x_common, 'linear', 'extrap');
data2_interp = interp1(linspace(axes2.XLim(1), axes2.XLim(2), length(data2)), data2, x_common, 'linear', 'extrap');

% Compute Pearson correlation coefficient
pearsonCorr = corrcoef(data1_interp, data2_interp);
disp(['Pearson correlation coefficient: ', num2str(pearsonCorr(1,2))]);


