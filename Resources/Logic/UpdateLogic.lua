--这个逻辑就是减少“不作为”建筑的更新 先不修改。
UpdateLogic = {}

function UpdateLogic.init()
	UpdateLogic.list = {}
	UpdateLogic.addList = {}
	UpdateLogic.inExecute = nil
end

function UpdateLogic.addUpdate(target, handler)
	if not UpdateLogic.inExecute then
		table.insert(UpdateLogic.list, {target, handler})
		target.updateOpened = true
	else
		table.insert(UpdateLogic.addList, {target, handler})
	end
	target.updateDeleted = nil
end

function UpdateLogic.executeUpdate(diff)
	UpdateLogic.inExecute = true
	local count = #(UpdateLogic.list)
	local delNum = 0
	for i=1, count do
		local index = i-delNum
		local pair = UpdateLogic.list[index]
		if pair[1].updateDeleted then
			pair[1].updateDeleted = nil
			pair[1].updateOpened = nil
			table.remove(UpdateLogic.list, index)
			delNum = delNum + 1
		else
			pcall(pair[2], pair[1], diff)
		end
	end
	
	UpdateLogic.inExecute = nil
	while UpdateLogic.addList[1] do
		local pair = table.remove(UpdateLogic.addList)
		if not pair[1].updateDeleted then
			pair[1].udpateOpened = true
			table.insert(UpdateLogic.list, table.remove(UpdateLogic.addList))
		end
	end
end