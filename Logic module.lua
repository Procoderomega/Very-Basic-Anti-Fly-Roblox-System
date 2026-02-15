-- Version: 3.2

local Antifly = {}
-- logik
function Antifly.Check(player, hrp, data, config)
	
	local velocity = hrp.AssemblyLinearVelocity
	local vertical = (velocity.Y)
	local horizontal = Vector3.new(velocity.X, 0 , velocity.Z).Magnitude
	
	local RayParams = RaycastParams.new()
	RayParams.FilterDescendantsInstances = {player.Character}
	RayParams.FilterType = Enum.RaycastFilterType.Exclude
	
	local HeightRay = Vector3.new(0,-100,0)
	local HeightRayResult = workspace:Raycast(hrp.Position, HeightRay, RayParams)
	local DistanceToGround = HeightRayResult and (hrp.Position - HeightRayResult.Position).Magnitude or 100
	
	local gravity = workspace.Gravity
	local maxAllowedY = -(math.sqrt(2 * gravity * DistanceToGround))
	
	local RayDirection = Vector3.new(0,-5.5,0)
	local RayResult = workspace:Raycast(hrp.Position, RayDirection, RayParams)
	local IsInAir = not RayResult
	
	local suspicious = false
	
	if vertical < maxAllowedY and IsInAir then
		suspicious = true
	end
	
	if vertical > config.VerticalSpeedTreshold then
		suspicious = true
	end
	
	if horizontal > config.HorizontalSpeedTreshold then
		suspicious = true
	end
	
	if suspicious then
		data.Flags += 1
	else
		data.Flags = math.max(0, data.Flags - config.FlagsDecay)
		if not IsInAir then
			data.LastValidPosition = hrp.Position
		end
	end
	-- UnComment this to debug lol
	--print(player.Name, "Suspicious:", suspicious)
	--print(HeightRayResult)
	
	if data.Flags >= config.FlagsLimit then
		hrp.CFrame = CFrame.new(data.LastValidPosition)
		hrp.AssemblyLinearVelocity = Vector3.zero
		data.Flags = 0
		
	end
end

return Antifly
