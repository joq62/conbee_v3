%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description :  
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(tradfri_bulb_E14_ws_candleopal_470lm).     
      
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-define(ModelId,"TRADFRIbulbE14WScandleopal470lm").
-define(Type,"lights").
%% --------------------------------------------------------------------
%   {"TRADFRI bulb E27 WW 806lm",
%     "2",
%         #{<<"alert">> => <<"none">>,
%           <<"bri">> => 0,
%           <<"on">> => false,
%           <<"reachable">> => false}},




%% External exports
-export([
	 turn_off/1,
	 turn_on/3,
	 is_on/1,
	 set/2,
	 get_bri/1,
	 set_bri/2,
	 get_ct/1,
	 set_ct/2,
	 reachable/1
	 
	]). 


%% ====================================================================
%% External functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
turn_on(Name,Brightness,ColorTemp)->
    tradfri_bulb_E14_ws_candleopal_470lm:set(Name,"on"),
    tradfri_bulb_E14_ws_candleopal_470lm:set_bri(Name,Brightness),
    tradfri_bulb_E14_ws_candleopal_470lm:set_ct(Name,ColorTemp),
    timer:sleep(4000),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
turn_off(Name)->
    tradfri_bulb_E14_ws_candleopal_470lm:set_bri(Name,0),
    tradfri_bulb_E14_ws_candleopal_470lm:set(Name,"off"),
    timer:sleep(4000),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
set(Name,State)->
    {ok,[{_Name,NumId,_ModelId,_StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
    {ok,ConbeeAddr}=application:get_env(conbee,addr),
    {ok,ConbeePort}=application:get_env(conbee,port),
    {ok,Crypto}=application:get_env(conbee,key),

    Cmd="/api/"++Crypto++"/"++?Type++"/"++NumId++"/state",
    Body=case State of
	     "on"->
		 jsx:encode(#{<<"on">> => true});		   
	     "off"->
		 jsx:encode(#{<<"on">> => false})
	 end,
    {ok, ConnPid} = gun:open(ConbeeAddr,ConbeePort),
    StreamRef = gun:put(ConnPid, Cmd, 
			[{<<"content-type">>, "application/json"}],Body),
    Result=lib_conbee:get_reply(ConnPid,StreamRef),
    ok=gun:close(ConnPid),
    Result.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
get_ct(Name)->
    {ok,[{_Name,_NumId,_ModelId,StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
     maps:get(<<"ct">>,StateMap).


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
set_ct(Name,ColorTemp)->
    {ok,[{_Name,NumId,_ModelId,_StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
  
    {ok,ConbeeAddr}=application:get_env(conbee,addr),
    {ok,ConbeePort}=application:get_env(conbee,port),
    {ok,Crypto}=application:get_env(conbee,key),

    Cmd="/api/"++Crypto++"/"++?Type++"/"++NumId++"/state",
    Body=jsx:encode(#{<<"ct">> => ColorTemp}),	      
    {ok, ConnPid} = gun:open(ConbeeAddr,ConbeePort),
    StreamRef = gun:put(ConnPid, Cmd, 
			[{<<"content-type">>, "application/json"}],Body),
    Result=lib_conbee:get_reply(ConnPid,StreamRef),
    ok=gun:close(ConnPid),
    Result.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
get_bri(Name)->
    {ok,[{_Name,_NumId,_ModelId,StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
     maps:get(<<"bri">>,StateMap).


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
set_bri(Name,Brightness)->
    {ok,[{_Name,NumId,_ModelId,_StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
  
    {ok,ConbeeAddr}=application:get_env(conbee,addr),
    {ok,ConbeePort}=application:get_env(conbee,port),
    {ok,Crypto}=application:get_env(conbee,key),

    Cmd="/api/"++Crypto++"/"++?Type++"/"++NumId++"/state",
    Body=jsx:encode(#{<<"bri">> => Brightness}),	      
    {ok, ConnPid} = gun:open(ConbeeAddr,ConbeePort),
    StreamRef = gun:put(ConnPid, Cmd, 
			[{<<"content-type">>, "application/json"}],Body),
    Result=lib_conbee:get_reply(ConnPid,StreamRef),
    ok=gun:close(ConnPid),
    Result.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
is_on(Name)->
    {ok,[{_Name,_NumId,_ModelId,StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
    maps:get(<<"on">>,StateMap).
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
reachable(Name)->
    {ok,[{_Name,_NumId,_ModelId,StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
     maps:get(<<"reachable">>,StateMap).
