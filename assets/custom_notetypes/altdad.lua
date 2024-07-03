function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length')-1 do
--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'altdad' then
					setPropertyFromGroup('unspawnNotes', i, 'noteType', 'No Animation'); 
		end
	end
end