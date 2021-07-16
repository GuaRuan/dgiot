%%--------------------------------------------------------------------
%% Copyright (c) 2020-2021 DGIOT Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(dgiot_group_app).

-emqx_plugin(?MODULE).
-include_lib("dgiot/include/logger.hrl").

-behaviour(application).


-include("dgiot_group.hrl").

%% Application callbacks
-export([start/2, stop/1]).


%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    dgiot_metrics:start(dgiot_group),
    dgiot_data:init(?dgiot_GROUP),
    dgiot_data:init(?dgiot_GROUP_ROUTE),
    dgiot_data:init(?dgiot_GROUP_TASK),
    dgiot_data:init(?dgiot_GROUP_METER),
    dgiot_data:init(?dgiot_GROUP_WORK),
    {ok, Sup} = dgiot_group_sup:start_link(),
    {ok, Sup}.


stop(_State) ->
    ok.
