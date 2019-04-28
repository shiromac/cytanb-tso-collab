----------------------------------------------------------------
--  Copyright (c) 2019 oO (https://github.com/oocytanb)
--  MIT Licensed
----------------------------------------------------------------

cytanb=(function()math.randomseed(os.time())local a={FatalLogLevel=100,ErrorLogLevel=200,WarnLogLevel=300,InfoLogLevel=400,DebugLogLevel=500,TraceLogLevel=600,ColorHueSamples=10,ColorSaturationSamples=4,ColorBrightnessSamples=5,ColorMapSize=10*4*5,NegativeNumberTag='#__CYTANB_NEGATIVE_NUMBER',InstanceIDParameterName='__CYTANB_INSTANCE_ID'}local b='__CYTANB_INSTANCE_ID'local c=400;local d;local cytanb={InstanceID=function()if d==''then d=vci.state.Get(b)or''end;return d end,Vars=function(e,f,g,h)local i;if f then i=f~='__NOLF'else f='  'i=true end;if not g then g=''end;if not h then h={}end;local j=type(e)if j=='table'then h[e]=h[e]and h[e]+1 or 1;local k=i and g..f or''local l='('..tostring(e)..') {'local m=true;for n,o in pairs(e)do if m then m=false else l=l..(i and','or', ')end;if i then l=l..'\n'..k end;if type(o)=='table'and h[o]and h[o]>0 then l=l..n..' = ('..tostring(o)..')'else l=l..n..' = '..cytanb.Vars(o,f,k,h)end end;if not m and i then l=l..'\n'..g end;l=l..'}'h[e]=h[e]-1;if h[e]<=0 then h[e]=nil end;return l elseif j=='function'or j=="thread"or j=="userdata"then return'('..j..')'elseif j=='string'then return'('..j..') '..string.format('%q',e)else return'('..j..') '..tostring(e)end end,GetLogLevel=function()return c end,SetLogLevel=function(p)c=p end,Log=function(p,...)if p<=c then local q=table.pack(...)if q.n==1 then local e=q[1]if e~=nil then print(type(e)=='table'and cytanb.Vars(e)or tostring(e))else print('')end else local l=''for r=1,q.n do local e=q[r]if e~=nil then l=l..(type(e)=='table'and cytanb.Vars(e)or tostring(e))end end;print(l)end end end,FatalLog=function(...)cytanb.Log(a.FatalLogLevel,...)end,ErrorLog=function(...)cytanb.Log(a.ErrorLogLevel,...)end,WarnLog=function(...)cytanb.Log(a.WarnLogLevel,...)end,InfoLog=function(...)cytanb.Log(a.InfoLogLevel,...)end,DebugLog=function(...)cytanb.Log(a.DebugLogLevel,...)end,TraceLog=function(...)cytanb.Log(a.TraceLogLevel,...)end,ListToMap=function(s,t)local table={}local u=t==nil;for v,e in pairs(s)do table[e]=u and e or t end;return table end,RandomUUID=function()return{math.random(0,0xFFFFFFFF),bit32.bor(0x4000,bit32.band(math.random(0,0xFFFFFFFF),0xFFFF0FFF)),bit32.bor(0x80000000,bit32.band(math.random(0,0xFFFFFFFF),0x3FFFFFFF)),math.random(0,0xFFFFFFFF)}end,UUIDString=function(w)local x=w[2]or 0;local y=w[3]or 0;return string.format('%08x-%04x-%04x-%04x-%04x%08x',bit32.band(w[1]or 0,0xFFFFFFFF),bit32.band(bit32.rshift(x,16),0xFFFF),bit32.band(x,0xFFFF),bit32.band(bit32.rshift(y,16),0xFFFF),bit32.band(y,0xFFFF),bit32.band(w[4]or 0,0xFFFFFFFF))end,ColorFromARGB32=function(z)local A=type(z)=='number'and z or 0xFF000000;return Color.__new(bit32.band(bit32.rshift(A,16),0xFF)/0xFF,bit32.band(bit32.rshift(A,8),0xFF)/0xFF,bit32.band(A,0xFF)/0xFF,bit32.band(bit32.rshift(A,24),0xFF)/0xFF)end,ColorToARGB32=function(B)return bit32.bor(bit32.lshift(math.floor(255*B.a+0.5),24),bit32.lshift(math.floor(255*B.r+0.5),16),bit32.lshift(math.floor(255*B.g+0.5),8),math.floor(255*B.b+0.5))end,ColorFromIndex=function(C,D,E,F,G)local H=math.max(math.floor(D or a.ColorHueSamples),1)local I=G and H or H-1;local J=math.max(math.floor(E or a.ColorSaturationSamples),1)local K=math.max(math.floor(F or a.ColorBrightnessSamples),1)local L=math.max(math.min(math.floor(C or 0),H*J*K-1),0)local M=L%H;local N=math.floor(L/H)local O=N%J;local P=math.floor(N/J)if G or M~=I then local Q=M/I;local R=(J-O)/J;local e=(K-P)/K;return Color.HSVToRGB(Q,R,e)else local e=(K-P)/K*O/(J-1)return Color.HSVToRGB(0.0,0.0,e)end end,GetSubItemTransform=function(S)local T=S.GetPosition()local U=S.GetRotation()local V=S.GetLocalScale()return{positionX=T.x,positionY=T.y,positionZ=T.z,rotationX=U.x,rotationY=U.y,rotationZ=U.z,rotationW=U.w,scaleX=V.x,scaleY=V.y,scaleZ=V.z}end,TableToSerialiable=function(W)if type(W)~='table'then return W end;local X={}for v,e in pairs(W)do if type(e)=='number'and e<0 then X[v..a.NegativeNumberTag]=tostring(e)else X[v]=cytanb.TableToSerialiable(e)end end;return X end,TableFromSerialiable=function(X)if type(X)~='table'then return X end;local W={}for v,e in pairs(X)do if type(e)=='string'and string.endsWith(v,a.NegativeNumberTag)then W[string.sub(v,1,#v-#a.NegativeNumberTag)]=tonumber(e)else W[v]=cytanb.TableFromSerialiable(e)end end;return W end,EmitMessage=function(Y,Z)local table=Z and cytanb.TableToSerialiable(Z)or{}table[a.InstanceIDParameterName]=cytanb.InstanceID()vci.message.Emit(Y,json.serialize(table))end,OnMessage=function(Y,_)local a0=function(a1,a2,a3)local Z;if a3==''then Z={}else local a4,X=pcall(json.parse,a3)if not a4 or type(X)~='table'then cytanb.TraceLog('Invalid message format: ',a3)return end;Z=cytanb.TableFromSerialiable(X)end;_(a1,a2,Z)end;vci.message.On(Y,a0)return{Off=function()if a0 then a0=nil end end}end}setmetatable(cytanb,{__index=a})if vci.assets.IsMine then d=cytanb.UUIDString(cytanb.RandomUUID())vci.state.Set(b,d)else d=''end;return cytanb end)()

-- グリップしてアイテムを使用すると呼び出される。
function onUse(use)
	vci.assets._ALL_PlayAudioFromIndex(0)
end

cytanb.OnMessage('cytanb.color-palette.item-status', function (sender, name, parameterMap)
	-- vci.message から色情報を取得する。
	local color = cytanb.ColorFromARGB32(parameterMap['argb32'])

	print('onMessage: ' .. name .. ',  color = ' .. tostring(color))
	vci.assets._ALL_SetMaterialColorFromIndex(0, color)
end)
