--goes in note types folder

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'altdad' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); 
		end
	end
	--debugPrint('Script started!')
end