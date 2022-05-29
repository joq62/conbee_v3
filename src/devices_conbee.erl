%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description :  
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(devices_conbee).    
     
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------


%% External exports
-export([
	 all/0
	]). 


%% ====================================================================
%% External functions
%% ====================================================================

   
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
all()->
    ["tradfri_bulb_E14_ws_candleopal_470lm",
     "tradfri_bulb_e27_cws_806lmw",
     "tradfri_bulb_e27_ww_806lm",
     "tradfri_control_outlet",
     "tradfri_on_off_switch",
     "lumi_sensor_magnet_aq2",
     "lumi_sensor_motion_aq2",
     "lumi_weather",
     "lumi_switch_n0agl1"
    ].
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
