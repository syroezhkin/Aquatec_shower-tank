local parameters = Style.GetParameterValues()
local dimensions = parameters.Dimensions

function MakeTank(M, NeckDiameter, Width, Height)
	local h = Height - 5 * M
	return Unite({
		CreateRightCircularCylinder(NeckDiameter / 2, 3 * M):Shift(0, 0, h),
		CreateBlock(NeckDiameter + M, NeckDiameter + M, 2 * M):Shift(0, 0, h),
		CreateRectangularPyramid(Width - 2 * M, Width - 2 * M, 2 * M):Shift(0, 0, h),
		CreateBlock(Width, Width, h),
		CreateBlock(Width - M, Width - M, M):Shift(0, 0, -M),
		CreateRectangularPyramid(Width - 3 * M, Width - 3 * M, -M):Shift(0, 0, -M),
	})
end

local detailedGeometry = ModelGeometry()
detailedGeometry:AddSolid(MakeTank(dimensions.Module, dimensions.NeckDiameter, dimensions.Width, dimensions.Height))
Style.SetDetailedGeometry(detailedGeometry)
