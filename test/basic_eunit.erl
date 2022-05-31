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

    ok=test_lumi_sensor_motion_aq2(),
    ok=test_tradfri_bulb_E14_ws_candleopal_470lm(),

    ok=test_tradfri_control_outlet(),
    ok=test_tradfri_motion(), 
    ok=test_lumi_weather(),
    ok=test_lumi_switch(),
    ok=test2(),
    ok=test1(),

    init:stop(),
    ok.



%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test_lumi_sensor_motion_aq2()->
    not_implemented=conbee_server:cmd_devices(lumi_sensor_motion_aq2,reachable,["aqara_1_motion_sensor"]),
    Presence=conbee_server:cmd_devices(lumi_sensor_motion_aq2,is_presence,["aqara_1_motion_sensor"]),
    Dark=conbee_server:cmd_devices(lumi_sensor_motion_aq2,is_dark,["aqara_1_motion_sensor"]),
    DayLight=conbee_server:cmd_devices(lumi_sensor_motion_aq2,is_daylight,["aqara_1_motion_sensor"]),
    LightLevel=conbee_server:cmd_devices(lumi_sensor_motion_aq2,lightlevel,["aqara_1_motion_sensor"]),
    Lux=conbee_server:cmd_devices(lumi_sensor_motion_aq2,lux,["aqara_1_motion_sensor"]),
    io:format("aqara_1_motion_sensor ~p~n",[{Presence,Dark,DayLight,LightLevel,Lux}]),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test_tradfri_bulb_E14_ws_candleopal_470lm()->
    conbee_server:cmd_devices(lumi_switch_n0agl1,set,["lumi_1_switch","on"]),
    timer:sleep(1000),
    conbee_server:cmd_devices(tradfri_bulb_E14_ws_candleopal_470lm,set,["tradfri_lamp_2_lights","off"]),
    timer:sleep(1000),
    true=conbee_server:cmd_devices(tradfri_bulb_E14_ws_candleopal_470lm,reachable,["tradfri_lamp_2_lights"]),

    conbee_server:cmd_devices(tradfri_bulb_E14_ws_candleopal_470lm, set_bri,["tradfri_lamp_2_lights",10]),
    conbee_server:cmd_devices(tradfri_bulb_E14_ws_candleopal_470lm,set,["tradfri_lamp_2_lights","on"]),
    

    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test_tradfri_control_outlet()->
    true=conbee_server:cmd_devices(tradfri_control_outlet,reachable,["tradfri_outlet_2_switch"]),
    conbee_server:cmd_devices(tradfri_control_outlet,set,["tradfri_outlet_2_switch","off"]),
    timer:sleep(1000),
    false=conbee_server:cmd_devices(tradfri_control_outlet,is_on,["tradfri_outlet_2_switch"]),
    conbee_server:cmd_devices(tradfri_control_outlet,set,["tradfri_outlet_2_switch","on"]),
    true=conbee_server:cmd_devices(tradfri_control_outlet,is_on,["tradfri_outlet_2_switch"]),
    conbee_server:cmd_devices(tradfri_control_outlet,set,["tradfri_outlet_2_switch","off"]),
    false=conbee_server:cmd_devices(tradfri_control_outlet,is_on,["tradfri_outlet_2_switch"]),
    ok.
    
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test_tradfri_motion()->
    not_implemented=conbee_server:cmd_devices(tradfri_motion_sensor,reachable,["tradfri_motion_1_sensor"]),
    Presence=conbee_server:cmd_devices(tradfri_motion_sensor,is_presence,["tradfri_motion_1_sensor"]),
    io:format("tradfri_motion_1_sensor ~p~n",[Presence]),
    
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test_lumi_weather()->
    not_implemented=conbee_server:cmd_devices(lumi_weather,reachable,["lumi_weather_1_sensor"]),
    Temp=conbee_server:cmd_devices(lumi_weather,temp,["lumi_weather_1_sensor"]),
    Humidity=conbee_server:cmd_devices(lumi_weather,humidity,["lumi_weather_1_sensor"]),
    Pressure=conbee_server:cmd_devices(lumi_weather,pressure,["lumi_weather_1_sensor"]),
    io:format("lumi_weather_1_sensor ~p~n",[{Temp,Humidity,Pressure}]),
    
    ok.
    
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test_lumi_switch()->
    true=conbee_server:cmd_devices(lumi_switch_n0agl1,reachable,["lumi_1_switch"]),
    conbee_server:cmd_devices(lumi_switch_n0agl1,set,["lumi_1_switch","off"]),
    false=conbee_server:cmd_devices(lumi_switch_n0agl1,is_on,["lumi_1_switch"]),
    conbee_server:cmd_devices(lumi_switch_n0agl1,set,["lumi_1_switch","on"]),
    timer:sleep(2000),
    true=conbee_server:cmd_devices(lumi_switch_n0agl1,is_on,["lumi_1_switch"]),
    conbee_server:cmd_devices(lumi_switch_n0agl1,set,["lumi_1_switch","off"]),
    timer:sleep(2000),
    false=conbee_server:cmd_devices(lumi_switch_n0agl1,is_on,["lumi_1_switch"]),
    ok.
    
 
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
test2()->
    true=conbee_server:cmd_devices(lumi_switch_n0agl1,reachable,["lumi_1_switch"]),
    not_implemented=conbee_server:cmd_devices(lumi_weather,reachable,["lumi_weather_1_sensor"]),
    not_implemented=conbee_server:cmd_devices(tradfri_motion_sensor,reachable,["tradfri_motion_1_sensor"]),
    
 
    
    
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
