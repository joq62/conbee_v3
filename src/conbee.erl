%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : 
%%% Hw server to control specific hw using conbee II and protocol zigbee
%%% Contains all supported devices   
%%% conbee daemon is running in a docker container called "deconz"
%%% 
%%% Created : 
%%% -------------------------------------------------------------------
-module(conbee).  

-behaviour(gen_server). 

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
-define(SERVER,?MODULE).
-define(ConbeeContainer,"deconz").

%% External exports
-export([
	 all_devices/0,
	 active_devices/0,
	 cmd_devices/3,
	 

	 status_temp/0,
	 status_door/0,
	 status_motion/0,

	 info_lights/0,
	 info_switch/0,
	 
	 ping/0
	]).


-export([
	 start/0,
	 stop/0
	]).


-export([init/1, handle_call/3,handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
	
	       }).

%% ====================================================================
%% External functions
%% ====================================================================
appl_start([])->
    application:start(?MODULE).

%% ====================================================================
%% Server functions
%% ====================================================================
%% Gen server functions

start()-> gen_server:start_link({local, ?SERVER}, ?SERVER, [], []).
stop()-> gen_server:call(?SERVER, {stop},infinity).

%% ====================================================================
%% Application handling
%% ====================================================================

active_devices()->
    gen_server:call(?SERVER, {active_devices},infinity).

all_devices()->
    gen_server:call(?SERVER, {all_devices},infinity).

cmd_devices(M,F,A)->
    gen_server:call(?SERVER, {cmd_devices,M,F,A},infinity).

info_lights()-> 
    gen_server:call(?SERVER, {info_lights},infinity).
info_switch()-> 
    gen_server:call(?SERVER, {info_switch},infinity).

status_temp()-> 
    gen_server:call(?SERVER, {status_temp},infinity).
status_door()-> 
    gen_server:call(?SERVER, {status_door},infinity).
status_motion()-> 
    gen_server:call(?SERVER, {status_motion},infinity).
%% ====================================================================
%% Support functions
%% ====================================================================

%% 
%% @doc:check if service is running
%% @param: non
%% @returns:{pong,node,module}|{badrpc,Reason}
%%
-spec ping()-> {atom(),node(),module()}|{atom(),term()}.
ping()-> 
    gen_server:call(?SERVER, {ping},infinity).

%% ====================================================================
%% Gen Server functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Function: init/1
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%% --------------------------------------------------------------------
init([]) ->
    os:cmd("docker restart "++?ConbeeContainer),
    timer:sleep(5*1000),
    {ok, #state{}
    }.

%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------

handle_call({active_devices},_From,State) ->
    Reply=rpc:call(node(),lib_conbee,active_devices,[],10*1000),
    {reply, Reply, State};

handle_call({all_devices},_From,State) ->
    Reply=devices_conbee:all(),
    {reply, Reply, State};

handle_call({cmd_devices,M,F,A},_From,State) ->
    Reply=rpc:call(node(),M,F,A,10*1000),
    {reply, Reply, State};


handle_call({info_lights},_From,State) ->
   % io:format("~p~n",[{temp,?MODULE,?FUNCTION_NAME,?LINE}]),
    Reply=lights:get_info(),
    {reply, Reply, State};

handle_call({info_switch},_From,State) ->
   % io:format("~p~n",[{temp,?MODULE,?FUNCTION_NAME,?LINE}]),
    Reply= switch:get_info(),
    {reply, Reply, State};



handle_call({sensors_raw},_From,State) ->
   % io:format("~p~n",[{temp,?MODULE,?FUNCTION_NAME,?LINE}]),
    Reply= sensors:get_info_raw(),
    {reply, Reply, State};

handle_call({sensors},_From,State) ->
   % io:format("~p~n",[{temp,?MODULE,?FUNCTION_NAME,?LINE}]),
    Reply= sensors:get_info(),
    {reply, Reply, State};


handle_call({ping},_From, State) ->
    Reply=pong,
    {reply, Reply, State};

handle_call({stopped},_From, State) ->
    Reply=ok,
    {reply, Reply, State};


handle_call({not_implemented},_From, State) ->
    Reply=not_implemented,
    {reply, Reply, State};

handle_call({stop}, _From, State) ->
    {stop, normal, shutdown_ok, State};

handle_call(Request, From, State) ->
    %rpc:cast(node(),log,log,[?Log_ticket("unmatched call",[Request, From])]),
    Reply = {ticket,"unmatched call",Request, From},
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------


handle_cast(_Msg, State) ->
  %  rpc:cast(node(),log,log,[?Log_ticket("unmatched cast",[Msg])]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_info(Info, State) ->
    io:format("~p~n",[{?MODULE,?FUNCTION_NAME,?LINE,Info}]),
    %rpc:cast(node(),log,log,[?Log_ticket("unmatched info",[Info])]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------

		  
