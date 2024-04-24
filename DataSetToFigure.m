% Define the path to the text file (replace 'data.txt' with the actual file path).
file_path = 'DataSetReference.txt';

% Read the data from the text file. The data is expected to be in two columns separated by a comma.
data = readmatrix(file_path);

% Extract the x and y values
x_values = data(:, 1);
y_values = data(:, 2);
x_values = 60 - x_values;

% Create a new figure
figure;

% Plot the data
plot(x_values, y_values, 'o-'); % 'o-' means circle markers connected by lines

% Label the axes
xlabel('X Values');
ylabel('Y Values');

% Add a grid for better readability
grid on;

% Add a title to the plot
title('Plot of Y vs. X from Text File');