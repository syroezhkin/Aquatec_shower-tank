---@meta

---@alias PipeConnectorType table
PipeConnectorType = {}

---@alias Solid table
Solid = {}

---@alias Point3D table
Point3D = {}

---@alias Point2D table
Point2D = {}

---@alias Vector3D table
Vector3D = {}

---@alias Axis3D table
Axis3D = {}

---@alias GeometrySet2D table
GeometrySet2D = {}

function Solid:Shift(x, y, z) end

function SetDetailedGeometry(geometry) end

function SetSymbolicGeometry(geometry) end

function SetSymbolGeometry(geometry) end

function FillArea(outerBoundary) end

---@alias Placement3D Placement3D
function Placement3D(point, z_axis_direction, x_axis_direction) end

---@return Solid
function CreateBlock(xSize, ySize, zSize) end

---@return Solid
function CreateRectangle2D(center, angle, width, height) end
--
---@return Solid
function CreateLineSegment2D(startPoint, endPoint) end

---@return Solid
function CreatePolyline2D(points) end

---@param width number
---@param depth number
---@param height number
---@param placement? Placement3D
---@return Solid
function CreateRectangularPyramid(width, depth, height, placement) end

---@return Solid
function CreateRightCircularCylinder(radius, height) end

---@return Solid
function Unite(solids) end

---@return Solid
function Subtract(solid1, solid2) end

---@return Solid
function Intersect(solid1, solid2) end

Style = {}

---@return table
function Style.GetParameterValues() end

---@return table
function Style.GetParameterGroup(groupName) end

ModelGeometry = {}
