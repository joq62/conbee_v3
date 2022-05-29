%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(basic_eunit).   
 
-export([start/0]).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
    ok=application:start(conbee),
    pong=conbee_server:ping(),
    ok=test2(),
    ok=test1(),

    init:stop(),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test2()->
    true=conbee_server:cmd_devices(lumi_switch_n0agl1,reachable,["lumi_1_switch"]),
    not_implemented=conbee_server:cmd_devices(lumi_weather,reachable,["lumi_weather_1_sensor"]),
 %   true=conbee_server:cmd_devices(lumi_switch_n0agl1,reachable,["tradfri_motion_1_sensor"]),
    
 
    
    
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test1()->
    [
     "tradfri_bulb_E14_ws_candleopal_470lm",
     "tradfri_bulb_e27_cws_806lmw",
     "tradfri_bulb_e27_ww_806lm",
     "tradfri_control_outlet",
     "tradfri_on_off_switch",
     "lumi_sensor_magnet_aq2",
     "lumi_sensor_motion_aq2",
     "lumi_weather",
     "lumi_switch_n0agl1"]=conbee_server:all_devices(),
    
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------

setup()->

   ok.
