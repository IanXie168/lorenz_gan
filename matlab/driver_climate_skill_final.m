% driver_climate_skill_final.m

% used to make figures for paper

%% ALL GANS TESTED with new new 500 and 600 series AND 700, 800 series >>> V1.5 <<<
exp_tag  = 'exp_20_stoch_1256787w8wv1.5';
fileroot = '/network/aopp/preds0/pred/users/arnold/SAMSI/L96_ML/data/';
%/network/aopp/cirrus/pred/arnold/SAMSI/L96_ML/data/';
filename_list = {[fileroot,'exp_20/lorenz_output.nc'],...
                 [fileroot,'exp_20_stoch/gan_000_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_100_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_101_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_102_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_103_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_202_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_203_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_500_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_501_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_502_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_503_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_602_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_603_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_700_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_701_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_702_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_703_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_801_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_802_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_803_climate/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_700_climate_white/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_701_climate_white/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_702_climate_white/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_703_climate_white/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_801_climate_white/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_802_climate_white/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/v1.5/gan_803_climate_white/02000000/lorenz_forecast_02000000_00.nc'],...
                 [fileroot,'exp_20_stoch/poly_add_climate/02000000/lorenz_forecast_02000000_00.nc']};

id_list = {'tru','Sgan000','Sgan100','Sgan101','Sgan102','Sgan103','Sgan202','Sgan203',...
           'Sgan500','Sgan501','Sgan502','Sgan503','Sgan602','Sgan603',...
           'Sgan700','Sgan701','Sgan702','Sgan703','Sgan801','Sgan802','Sgan803',...
           'Sgan700w','Sgan701w','Sgan702w','Sgan703w','Sgan801w','Sgan802w','Sgan803w',...
           'Spolyadd'};
id_list_legend = {'tru','XU-det','XU-lrg-w','XU-med-w','XU-sml-w','XU-tny-w',...
                                                  'X-sml-w' ,'X-tny-w',...
                 'XU-lrg-r5','XU-med-r5','XU-sml-r5','XU-tny-r5',...
                                                  'X-sml-r6' ,'X-tny-r6',...
                 'XU-lrg-r7','XU-med-r7','XU-sml-r7','XU-tny-r7',...
                                                  'X-med-r8','X-sml-r8' ,'X-tny-r8',...
                 'XU-lrg-w7','XU-med-w7','XU-sml-w7','XU-tny-w7',...
                                                  'X-med-w8','X-sml-w8' ,'X-tny-w8',...
                                                  'poly'};

%%
if length(id_list) ~=length(filename_list)
    error('mismatch between file names and ids')
end

no_X = 8;

%% load in data
mn=0;
mx=0;
for i_file = 1:length(id_list)
    
    my_file = char(filename_list{i_file});
    my_id   = char(id_list{i_file});
    if strcmp(my_id(1:3),'tru')
        my_data = ncread(my_file,'lorenz_x');
    else
        my_data = ncread(my_file,'x');
    end
    my_time = ncread(my_file,'time');
    
    eval(['X_',my_id,' = my_data;'])
    eval(['T_',my_id,' = my_time;'])
    
    % min and max for later
    mn = min(mn,min(min(my_data)));
    mx = max(mx,max(max(my_data)));
    
    i_file
end

%% for 'true' select only comparable data, not used for training
tru_start  = 399601;
eval(['tru_length = length(X_',char(id_list{2}),');'])
X_tru = X_tru(:,tru_start:tru_start+tru_length-1);
T_tru = T_tru(tru_start:tru_start+tru_length-1);

%% let's start with a PDF!
eval_pdf

%% -- and correlation in space and time
eval_corr

%% OK, now consider regime behaviour
eval_regime_analysis
