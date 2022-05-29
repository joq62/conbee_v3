%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description :  
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(tradfri_bulb_e27_cws_806lm).    
     
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-define(ModelId,"TRADFRI bulb E27 CWS 806lm").
-define(Type,"lights").
%% --------------------------------------------------------------------
%   <<"state">> =>
%    #{<<"alert">> => <<"none">>,<<"bri">> => 1,
%                    <<"colormode">> => <<"xy">>,<<"ct">> => 250,
%                    <<"effect">> => <<"none">>,<<"hue">> => 26317,
%                    <<"on">> => false,<<"reachable">> => true,
%                    <<"sat">> => 236,
%                    <<"xy">> => [0.151,0.4839]},



%% External exports
-export([
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

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
reachable(Name)->
    {ok,[{_Name,_NumId,_ModelId,StateMap,_ConfigMap}]}=lib_conbee:device(?Type,Name),
     maps:get(<<"reachable">>,StateMap).
