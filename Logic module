local Antifly = {}
-- logik
function Antifly.Check(player, hrp, data, config)
	local velocity = hrp.AssemblyLinearVelocity
	local vertical = math.abs(velocity.Y)
	local horizontal = Vector3.new(velocity.X, 0 , velocity.Z).Magnitude
	
	local suspicious = false
	
	if horizontal > config.HorizontalSpeedTreshold then
		suspicious = true
	end
	
	if vertical > config.VerticalSpeedTreshold then
		suspicious = true
	end
	
	if suspicious then
		data.Flags += 1
	else
		data.Flags = math.max(0, data.Flags - config.FlagsDecay)
		data.LastValidPosition = hrp.Position
	end
	
	print(player.Name, "Suspicious:", suspicious)
	
	if data.Flags >= config.FlagsLimit then
		hrp.CFrame = CFrame.new(data.LastValidPosition)
		hrp.AssemblyLinearVelocity = Vector3.zero
		data.Flags = 0
	end
end

return Antifly
