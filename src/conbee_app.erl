%%%-------------------------------------------------------------------
%% @doc conbee public API
%% @end
%%%-------------------------------------------------------------------
-module(conbee_app).
-behaviour(application).

-define(HwConfig,"hw.config").
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    application:ensure_all_started(gun),
    case code:where_is_file(?HwConfig) of
	non_existing->
	    {error,[non_existing,?HwConfig]};
	AbsFilename ->
	    {ok,I}=file:consult(AbsFilename),
	    {conbee_addr,ConbeeAddr}=lists:keyfind(conbee_addr,1,I),
	    {conbee_port,ConbeePort}=lists:keyfind(conbee_port,1,I),
	    {conbee_key,ConbeeKey}=lists:keyfind(conbee_key,1,I),
	    io:format("~p~n",[{addr,ConbeeAddr,port,ConbeePort,key,ConbeeKey}]),
	    ok=application:set_env([{conbee,[{addr,ConbeeAddr},{port,ConbeePort},{key,ConbeeKey}]}]),
	    conbee_sup:start_link()
    end.

stop(_State) ->
    ok.

%% internal functions
