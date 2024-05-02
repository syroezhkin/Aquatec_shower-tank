local parameters = Style.GetParameterValues()
local dimensions = parameters.Dimensions

function SetPipeParameters(port, portParameters)
	local connectionType = portParameters.ConnectionType
	if connectionType == PipeConnectorType.Thread then
		port:SetPipeParameters(connectionType, portParameters.ThreadSize)
	else
		port:SetPipeParameters(connectionType, portParameters.NominalDiameter)
	end
end

function HideIrrelevantPortParams(portName)
	local isThread = Style.GetParameter(portName, "ConnectionType"):GetValue() == PipeConnectorType.Thread
	Style.GetParameter(portName, "ThreadSize"):SetVisible(isThread)
	Style.GetParameter(portName, "NominalDiameter"):SetVisible(not isThread)
end

function MakeBottom(M, Width)
	return Subtract(
		CreateRectangularPyramid(Width - 3 * M, Width - 3 * M, -1.25 * M):Shift(0, 0, -M),
		CreateBlock(Width, Width, 2 * M):Shift(0, 0, -4 * M)
	)
end

function MakeTank(M, NeckDiameter, Width, Height)
	local h = Height - 4 * M
	local baseAxes = Axis3D(Point3D(0, 0, 0), Vector3D(0, 0, 1))
	local bottomPiramidPlacement = Placement3D(Point3D(0, 0, -M), Vector3D(0, 0, -1), Vector3D(1, 0, 0))
	local rib = CreateBlock(2 * M, Width / 2 - 4 * M, M):Shift(0, Width / 4, h)
	return Unite({
		rib,
		rib:Clone():Rotate(baseAxes, math.pi / 2),
		rib:Clone():Rotate(baseAxes, -math.pi / 2),
		CreateBlock(2 * M, Width / 2, M):Shift(0, -Width / 4, h),
		CreateRightCircularCylinder(NeckDiameter / 2, 1.5 * M):Shift(0, 0, h),
		Intersect(
			CreateRectangularPyramid(Width - 2 * M, Width - 2 * M, 2 * M):Shift(0, 0, h),
			CreateBlock(Width, Width, M):Shift(0, 0, h)
		),
		CreateBlock(Width, Width, h),
		CreateBlock(Width - M, Width - M, M):Shift(0, 0, -M),
		CreateRectangularPyramid(Width - 3 * M, Width - 3 * M, M, bottomPiramidPlacement),
		CreateBlock(M, Width / 2, 1.5 * M):Shift(0, Width / 4 - M / 2, -2.5 * M),
	})
end

function MakeSymbol(M, width, height)
	local w = width / 2
	local h = height / 2
	local contour = CreateRectangle2D(Point2D(0, 0), 0, width, height)
	local geometry = GeometrySet2D()

	geometry:AddCurve(contour)
	geometry:AddCurve(CreateLineSegment2D(Point2D(-w, -h + 4 * M), Point2D(w, -h + 4 * M)))
	geometry:AddCurve(CreatePolyline2D({
		Point2D(-3 * M, -h + M),
		Point2D(0, -h + 3 * M),
		Point2D(0, -h + M),
		Point2D(3 * M, -h + 3 * M),
	}))
	geometry:AddCurve(CreatePolyline2D({
		Point2D(3 * M - 1.2 * M, -h + 3 * M),
		Point2D(3 * M, -h + 3 * M),
		Point2D(3 * M - 0.5 * M, -h + 3 * M - 1.1 * M),
	}))
	geometry:AddMaterialColorSolidArea(FillArea(contour))

	return geometry
end

HideIrrelevantPortParams("ColdWater")
HideIrrelevantPortParams("HotWater")

local detailedGeometry = ModelGeometry()
detailedGeometry:AddSolid(MakeTank(dimensions.Module, dimensions.NeckDiameter, dimensions.Width, dimensions.Height))
Style.SetDetailedGeometry(detailedGeometry)

local scale = 75
local symbolGeometry = ModelGeometry()
local geometryPlacement =
	Placement3D(Point3D(0, 0, dimensions.Height / 2 / scale), Vector3D(1, 0, 0), Vector3D(1, 0, 0))
local geometry = MakeSymbol(dimensions.Module / scale, dimensions.Width / scale, dimensions.Height / scale)
symbolGeometry:AddGeometrySet2D(geometry, geometryPlacement)
Style.SetSymbolGeometry(symbolGeometry)

local coldWaterPlace = Placement3D(
	Point3D(0, -dimensions.Width / 2, dimensions.Height - 4 * dimensions.Module),
	Vector3D(0, -1, 0),
	Vector3D(1, 0, 0)
)
local coldWaterPort = Style.GetPort("ColdOrHotWaterInlet")
SetPipeParameters(coldWaterPort, parameters.ColdWater)
coldWaterPort:SetPlacement(coldWaterPlace)

local hotWaterPlace = Placement3D(Point3D(0, 0, -2.5 * dimensions.Module), Vector3D(0, 0, -1), Vector3D(1, 0, 0))
local hotWaterPort = Style.GetPort("HotWaterOutlet")
SetPipeParameters(hotWaterPort, parameters.HotWater)
hotWaterPort:SetPlacement(hotWaterPlace)

local powerSupplyLinePlace = Placement3D(
	Point3D(0, (dimensions.Width - dimensions.Module) / 2, -2 * dimensions.Module),
	Vector3D(0, 1, 0),
	Vector3D(-1, 0, 0)
)
local powerSupplyLinePort = Style.GetPort("PowerSupplyLine")
powerSupplyLinePort:SetPlacement(powerSupplyLinePlace)
