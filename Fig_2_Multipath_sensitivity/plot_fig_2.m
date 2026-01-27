clear; 
close all; 
clc;

load sensitivity_GPS.mat
load sensitivity_BDS.mat
load sensitivity_Gal.mat
load sensitivity_GLO.mat

custom_map = [0.0314 0.0706 0.2275;   
              0.1020 0.2118 0.3686;   
              0.2588 0.5098 0.6627;   
              0.3922 0.6784 0.7804;   
              0.8510 0.9216 0.9373;   
              0.8 0.8 0.8;   
              0.9922 0.8039 0.6588;   
              0.9804 0.6588 0.4510;   
              0.8824 0.3098 0.1098;   
              0.6510 0.0471 0.0157];

x_ticks = [1,50,100,150,200,250];
x_ticklabels = {'0','100','200','300','400','500'};
y_ticks = [1, 11, 21, 31, 41, 51, 61];
y_ticklabels = {'0','5','10','15','20','25','30'};

data_list = {
    {'sensitivity_GPS_L1_tau_phi{1}', 'GPS L1'}, ...
    {'sensitivity_GPS_L2_tau_phi{1}', 'GPS L2'}, ...
    {'sensitivity_GPS_L5_tau_phi{1}', 'GPS L5'}, ...
    {'sensitivity_GPS_all_tau_phi{1}', 'GPS All'}, ...
    {'sensitivity_BDS_B1_tau_phi{1}', 'BDS L1'}, ...
    {'sensitivity_BDS_B3_tau_phi{1}', 'BDS L2'}, ...
    {'sensitivity_BDS_B2_tau_phi{1}', 'BDS L5'}, ...
    {'sensitivity_BDS_all_tau_phi{1}', 'BDS All'}, ...
    {'sensitivity_Gal_E1_tau_phi{1}', 'Gal L1'}, ...
    {'sensitivity_Gal_E6_tau_phi{1}', 'Gal L2'}, ...
    {'sensitivity_Gal_E5_tau_phi{1}', 'Gal L5'}, ...
    {'sensitivity_Gal_all_tau_phi{1}', 'Gal All'}, ...
    {'sensitivity_GLO_L1_tau_phi{1}', 'GLO L1'}, ...
    {'sensitivity_GLO_L2_tau_phi{1}', 'GLO L2'}, ...
    {'sensitivity_GLO_all_tau_phi{1}', 'GLO L5'}, 
};

for i = 1:length(data_list)
    data_info = data_list{i};
    
    Z_data = eval(data_info{1});

    figure('Position', [200, 100, 1200, 500], 'Color', 'white');
    
    z_min = min(Z_data(:));
    z_max = max(Z_data(:));
    levels = linspace(0, z_max, 11);
   
    hold on;
    [C, h] = contour(Z_data, 10, 'LineColor', [0.6 0.6 0.6], ...
        'LineWidth', 1.5, 'LineStyle', '--', 'LabelSpacing', 3000);
    
    h.LevelList = [0,0.2,0.3,0.4,0.5,0.6,0.7,0.8,1];
    
    set(gca, 'YDir', 'normal', 'Box', 'off', 'TickDir', 'out', ...
        'LineWidth', 1, 'FontName', 'Helvetica', 'FontSize', 25);

        ylim([0,61]);

    colormap(gca, custom_map);
    caxis([z_min, z_max]);
    

    cbar = colorbar('eastoutside', 'Ticks', 0:0.2:1, ...
                    'TickDirection', 'out', 'Box', 'off', 'LineWidth', 1);
    cbar.Label.String = 'Detection Rate';
    cbar.Label.FontSize = 25;
    cbar.Label.FontName = 'Helvetica';

    tick_positions = (levels(1:end-1) + levels(2:end)) / 2;
    set(cbar, 'Ticks', tick_positions);
    cbar.TickLabels = {'0.1', '0.2', '0.3', '0.4', '0.5','0.6','0.7','0.8','0.9','1'};
    

    set(gca, 'FontName', 'Helvetica', 'FontSize', 25, ...
        'XTick', x_ticks, 'XTickLabel', x_ticklabels, ...
        'YTick', y_ticks, 'YTickLabel', y_ticklabels);
    

    xlabel('Code delay (m)', 'FontSize', 25, 'FontName', 'Helvetica');
    ylabel('Phase rotation (cm)', 'FontSize', 25, 'FontName', 'Helvetica');
end
