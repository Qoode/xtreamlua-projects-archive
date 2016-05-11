            tB,fB,     R,_U,    _SC,_E=true,false,       "return ",unpack,string.char,loadstring
             _TI=     _E(R..    _SC(_U({116,97,98,         108,101,46,105,110,115,101,114,116})))()
              _TC,    _CO=            _E(R..               _SC(_U({116,97,98,108,101,46,99,111,110,99,97,116})))(),_E(R.._SC(_U({112,114,105,110,116})))()
               tSd_7,t_W,             G_fL,                G_sL =R.."T[%i]","T[%i]=%i;",R.."G[%i]",R.."G[%i][%i]"
                slFfm,G,              T,F =                string.format,{},{},tB
function        gG_fFl              (i)if                not(_E(slFfm(G_fL,i))()) then _TI(G,{});end;end;
function          gG_fSl            (i,n)                for j=1,n do _TI(_E(slFfm(G_fL,i))(),io.read());end;end;
function      gg()local             n =                 io.read();for i=1,n do gG_fFl(i); gG_fSl(i,n);end;end;
function      AtNc8(c,n)if           _E(                 slFfm(tSd_7,n+1))() then return(c+_E(slFfm(G_sL,_E(slFfm(tSd_7,n))(),_E(slFfm(tSd_7,n+1))()))());
             else    return         (c+                  _E(slFfm(G_sL,_E(slFfm(tSd_7,n))(),_E(slFfm(tSd_7,1))()))())end;end;
function   CCC()      local c       = 0;                for n=1,#G do c=AtNc8(c,n) end;return c;end;
function V2_o(i,       j)local      B=_E                (slFfm(tSd_7,j))();_E(slFfm(t_W,j,_E(slFfm(tSd_7,i))()))();_E(slFfm(t_W,i,B))();end;


function fNT_t(i,j)    if(     j~=i)   then local     c = CCC();        V2_o            (i,j);if (c >     CCC     ())     then F=tB;else V2_o(i,j) end;end;end;
function _a(i)         for     j=1,    #T       do    fNT_t    (i        ,j);            end     ;end;    --_Ue   vI)z
function iFT() for     i=1,#G do _E   (slFfm(t_W,i    ,i))(    );        end;            end;    --Aer;    Erer_- +0Oi
function       sT()    iFT();while    (not    (not   (F)))     do       F=fB;           for i=1,#T do     _a(i) ;end;    end;end;
function       uI()    return(_SC(    _U({     84,     111,    116       ,97,            108,    32,99,    111,    115,    116,32,58,32})));end;
function WOOT()gg();   sT();   _CO(    _TC(      T,     " -> ") );        _CO(uI(),CCC    ());     end;    WOOT    ();--    zZ
