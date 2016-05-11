--# UPDATE SCRIPT 

--detection d'une mise a jour
path = System.currentDirectory()
System.currentDirectory('System/temp')
fichier = System.listDirectory()
update = false
for i=1 , table.getn(fichier) do
if fichier[i].name == 'update.dat' then
update = true
end
end
System.currentDirectory(path)
if update == true then
dofile('System/script/dataunload.lua')
dofile('System/Temp/update.dat')
else
alert('Update','Aucune M.A.J trouvee',true)
playI()
end