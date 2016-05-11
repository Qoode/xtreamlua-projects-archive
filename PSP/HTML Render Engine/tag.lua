function hexToDec(n)
	local r,g,b = n:match("#(%x%x)(%x%x)(%x%x)")
	return tonumber("0x"..r),tonumber("0x"..g),tonumber("0x"..b)
end

tag = {}

--# Balise de type 1 (sans attribut)
tag.b = {t = 1,f = {b=1}}
tag.u = {t = 1,f = {u=1}}
tag.i = {t = 1,f = {i=1}}
tag.sup = {t = 1}
tag.sub = {t = 1}
tag.strong = {t = 1}
tag.strike = {t = 1}
tag.small = {t = 1,f={size=8}}
tag.big = {t = 1}
tag.code = {t = 1}
tag.cite = {t = 1}
tag.em = {t = 1}
tag.br = {t = 1,f= {br=1},alone = 1}
tag.h1 = {t = 1,f= {b=1,size=20,br=2}}
tag.h2 = {t = 1,f= {b=1,size=18,br=2}}
tag.h3 = {t = 1,f= {b=1,size=16,br=2}}
tag.h4 = {t = 1,f= {b=1,size=14,br=2}}
tag.h5 = {t = 1,f= {b=1,size=12,br=2}}
tag.h6 = {t = 1,f= {b=1,size=10,br=2}}
tag.center = {t = 1}

--# Balise de type 2
tag.div = {t = 2}
tag.span = {t = 2}
tag.p = {t = 2}
tag.font = {
				t = 2,
				a={
					color={name="color",get=function(n) return pge.gfx.createcolor(hexToDec(n)) end},
					size={name="size",get=function(n) return tonumber(n:match("%d+")) end}}}

--# Balise de type 3 (table)
tag.table = {t = 3}
tag.th = {t = 3}
tag.td = {t = 3}
tag.tr = {t = 3}

--# Balise de type 4 (formulaire)
tag.form = {t = 4}
tag.input = {t = 4}
tag.textara = {t = 4}
tag.option = {t = 4}
tag.select = {t = 4}

--# balise de type 5 (liste)
tag.li = {t = 5}
tag.ul = {t = 5}
tag.ol = {t = 5}

--# Balise de type 6 (divers)
tag.a = {t = 6}
tag.hr = {t = 6}
tag.img = {t = 6,alone = 1}
tag.body = {t = 6}

function tag_type(t)
	if tag[t] then return tag[t].t
	else return 0 end
end

function tag_alone(t)
	if tag[t] and tag[t].alone then return true end
	return false
end
