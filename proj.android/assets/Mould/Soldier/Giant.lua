Giant = class(Soldier)

-- to override
function Giant:resetOtherState()
	if self.stateInfo.action == "pose" then
		self.displayState.duration = getParam("soldierPoseTime" .. self.info.sid, 500)/1000
		self.displayState.isRepeat = false
		self.displayState.num = 5
		self.displayState.prefix = "soldier" .. self.info.sid .. "_" .. self.data.level .. "_p"
	elseif self.stateInfo.action == "attack1" or self.stateInfo.action == "attack2" then
		local atype = string.sub(self.stateInfo.action, -1)
		self.displayState.duration = 0.15 * (atype+5)
		self.displayState.isRepeat = false
		self.displayState.reverse = true
		self.displayState.num = atype+5
		self.displayState.prefix = "soldier" .. self.info.sid .. "_" .. self.data.level .. "_a" .. atype .. "_"
	end
end

-- to override
function Giant:prepareAttack()
	self.stateInfo = {actionTime=self.info.attackSpeed}
	self.stateInfo.attackValue = self:getAttackValue()
	local atype = math.random(2)
	self.stateInfo.attackTime = 0.15 * (3+atype)
	self.stateInfo.action = "attack" .. atype
end

function Giant:getFrameEspecially(i)
	if self.stateInfo.action ~= "pose" then
		return nil
	end
	if self.data.level>=4 then
    	if i>=4 then
    		if i<12 then
    			i = 3
    		elseif i<15 then
    			i = i-8
    		else
    			i = 0
    		end
    	end
	else
    	if i>=5 then
    		if i<12 then
    			i = 4
    		elseif i<15 then
    			i = i-7
    		else
    			i = 0
    		end
    	end
	end
	return i
end