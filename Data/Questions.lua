local q = {}

q.questions = {}

q.usedQuestions = {}


-- ( The process of removing questions after each correct answer and adding them back
--We use this method of removing because objects in a table are not ordered as they created.
function q.removeQuestion( id )
	-- Itereate over the table backwards
	for i=#q.questions.questions, 1, -1 do
		if q.questions.questions[i].id == id then
			-- Remove from table then from display
			table.remove( q.questions.questions, i )
		end
	end
end

function q.addUsedQuestion( id )
	for i=1,#q.questions.questions do
		if q.questions.questions[i].id == id then
			print("ID: "..q.questions.questions[i].id)
			q.usedQuestions[#q.usedQuestions+1] = q.questions.questions[i]
			q.removeQuestion(id)
			print("questions = "..#q.questions.questions)
			print("Used questions = "..#q.usedQuestions)
			return
		end
	end
end

function q.repopulateQuestions(  )
	q.questions.questions = q.usedQuestions
	q.usedQuestions = {}
	print("Questions Re-Populated")
	print("Questions = "..#q.questions)
end

-- The process ends )

return q